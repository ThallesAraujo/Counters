//
//  ViewController.swift
//  Counters
//
//  Created by Thalles Araújo on 04/03/23.
//

import UIKit
import HealthKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /*
     Extensions:
     - TodayView
     - LiveActivity
     - Watch
     */
    
    //MARK: - UI Elements
    
    var mainList: UITableView = .init()

    //MARK: - HealthKit
    
    lazy var healthStore = HKHealthStore()
    
    //MARK: - Data
    
    var calories: String = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeHealthKit()
        mainList.delegate = self
        mainList.dataSource = self
        self.title = "Counters"
    }
    
    func authorizeHealthKit(){
        
        let healthKitTypesToRead: Set<HKObjectType> = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!]
        
        healthStore.requestAuthorization(toShare: [], read: healthKitTypesToRead) { (success, error) -> Void in
            if success {
                print("success")
                self.getActiveEnergy(currentDate: Date()) { totalEnergy in
                    print("TotalEnergy \(totalEnergy)")
                    self.mainList.reloadData()
                }
            } else {
                print("failure")
            }
            
            if let error = error { print(error) }
        }
        
    }
    
    func getActiveEnergy(currentDate: Date ,completion: @escaping ((_ totalEnergy: Double) -> Void)) {
        let calendar = Calendar.current
        var totalBurnedEnergy = Double()
        let startOfDay = Int((currentDate.timeIntervalSince1970/86400)+1)*86400
        let startOfDayDate = Date(timeIntervalSince1970: Double(startOfDay))
        //   Get the start of the day
        let newDate = calendar.startOfDay(for: startOfDayDate)
        let startDate: Date = calendar.date(byAdding: Calendar.Component.day, value: -1, to: newDate)!

        //  Set the Predicates
        let predicate = HKQuery.predicateForSamples(withStart: startDate as Date, end: newDate as Date, options: .strictStartDate)

        //  Perform the Query
        let energySampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)

        let query = HKSampleQuery(sampleType: energySampleType!, predicate: predicate, limit: 0, sortDescriptors: nil, resultsHandler: {
            (query, results, error) in
            if results == nil {
                print("There was an error running the query: \(error.debugDescription)")
            }

            DispatchQueue.main.async {

                for activity in results as! [HKQuantitySample]
                {
                    let calories = activity.quantity.doubleValue(for: HKUnit.kilocalorie())
                    totalBurnedEnergy = totalBurnedEnergy + calories
                    self.calories = "\(totalBurnedEnergy)"
                }
                completion(totalBurnedEnergy)
            }
        })
        self.healthStore.execute(query)
    }
    
    //MARK: - TableView
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Calorias: \(self.calories)"
        return cell
    }


}

