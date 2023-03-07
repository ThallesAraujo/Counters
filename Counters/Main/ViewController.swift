//
//  ViewController.swift
//  Counters
//
//  Created by Thalles Araújo on 04/03/23.
//

import UIKit
import HealthKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - UI Elements
    
    var mainList: UITableView = .init()

    //MARK: - HealthKit
    
    var queryManager = HealthKitQueryManager()
    
    //MARK: - Data
    
    var healthData: [String] = []{
        didSet {
            self.mainList.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
        mainList.delegate = self
        mainList.dataSource = self
        queryHealthKit()
        self.title = "Counters"
    }
    
    func setupList(){
        if #available(iOS 13.0, *) {
            self.mainList = .init(frame: CGRect.zero, style: .insetGrouped)
        }
        
        self.mainList.register(RegularDataCell.self, forCellReuseIdentifier: regularCellDataIdentifier)
    }
    
    func queryHealthKit(){
        
        let queries = [
            self.queryManager.getActiveEnergy,
            self.queryManager.getExerciseTime,
            self.queryManager.getStandHour,
            self.queryManager.getStepCount
        ]
        
        for query in queries{
            query {data in
                self.healthData.append("\(data)")
                print("healthData: \(self.healthData)")
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
                cell.data.text = "\(healthData[indexPath.item]) \(section.unit)"
                print("IndexPath item \(indexPath.item) | cell data: \(healthData[indexPath.item])")
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

