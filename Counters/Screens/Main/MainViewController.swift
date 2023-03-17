//
//  ViewController.swift
//  Counters
//
//  Created by Thalles Araújo on 04/03/23.
//

import UIKit
import HealthKit

class MainViewController: ListViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - HealthKit
    
    var queryManager = HealthKitQueryManager()
    
    //MARK: - Data
    
    var healthData: [String: String] = [
        "calories": "0",
        "exerciseTime": "0",
        "standHours": "0",
        "stepCount": "0"
    ]{
        didSet {
            self.mainList.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        queryManager.getCaloriesType()
        setupList()
        mainList.delegate = self
        mainList.dataSource = self
        queryHealthKit()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //TODO: Por hora, corrige cores em células erradas. Porém não é a melhor solução
        self.mainList.reloadData()
    }
    
    func setupList(){
        setupListiOS13()
        self.mainList.register(RegularDataCell.self, forCellReuseIdentifier: regularCellDataIdentifier)
    }
    
    func queryHealthKit(){
        
        let queries = [
            (self.queryManager.getActiveEnergy, DataCellType.calories),
            (self.queryManager.getExerciseTime, DataCellType.exerciseTime),
            (self.queryManager.getStandHour, DataCellType.standHours),
            (self.queryManager.getStepCount, DataCellType.stepCount)
        ]
        
        for (query, dataType) in queries{
            query { data in
                
                print("Data: \(dataType): \(data)")
                
                if [DataCellType.exerciseTime].contains(dataType){
                    self.healthData[dataType.rawValue] = "\(data.asString(style: .abbreviated))"
                }else{
                    self.healthData[dataType.rawValue] = "\(Int(data))"
                }
            }
        }
        
    }
    
    //MARK: - TableView
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !healthData.isEmpty{
            if let cell = tableView.dequeueReusableCell(withIdentifier: regularCellDataIdentifier) as? RegularDataCell, indexPath.item < healthData.count{
                let section = mainTableViewSections[indexPath.item]
                
                cell.title.text = section.title
                cell.data.text = "\(healthData[section.dataType.rawValue].orEmpty)\(section.unit)"
                cell.icon.image = UIImage(named: section.iconName)
                cell.dataColor = UIColor(named: section.colorName).orDefault
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
