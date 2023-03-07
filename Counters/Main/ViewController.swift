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
        mainList.delegate = self
        mainList.dataSource = self
        queryHealthKit()
        self.title = "Counters"
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
        let cell = UITableViewCell()
        cell.textLabel?.text = getData(indexPath.row)
        return cell
    }

    
    internal func getData(_ index: Int) -> String{
        
        if !healthData.isEmpty{
            let section = mainTableViewSections[index]
            return "\(section.title) \(healthData[index]) \(section.unit)"
        }else{
            return "Sem dados"
        }
    }
    
}

