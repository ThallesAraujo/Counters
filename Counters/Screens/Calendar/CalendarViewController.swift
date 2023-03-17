//
//  CalendarViewController.swift
//  Counters
//
//  Created by Thalles Araújo on 17/03/23.
//

import Foundation
import UIKit
class CalendarViewController: ListViewController, UITableViewDelegate, UITableViewDataSource{
    
    var queryManager: EventKitQueryManager = .init()
    
    var data: [CalendarViewControllerData] = [
        .init(dataType: .reminders, value: 0),
        .init(dataType: .events, value: 0)
    ]{
        didSet{
            self.mainList.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupListiOS13()
        self.executeQueries()
        self.mainList.delegate = self
        self.mainList.dataSource = self
    }
    
    func executeQueries(){
        
        let queries = [
            (CalendarViewControllerDataType.events, queryManager.getEventCount),
            (CalendarViewControllerDataType.reminders, queryManager.getRemindersCount)
        ]
        
        for (type, query) in queries {
            query({count in
                let index = self.data.firstIndex(where: {$0.dataType == type}).orZero
                self.data[index] = .init(dataType: type, value: count)
            })
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let dataToDisplay = data[indexPath.row]
        
        var cellContent = VStack{
            Label(dataToDisplay.dataType.rawValue)
            Label("\(dataToDisplay.value)")
        }
        
        cellContent.mainView.distribution = .fillEqually
        
        cell.addSubview(cellContent)
        cellContent.fillParent()
        
        return cell
    }
    
    
    
    
}
