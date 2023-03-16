//
//  BatteriesViewController.swift
//  Counters
//
//  Created by Thalles Araújo on 14/03/23.
//

import Foundation
import UIKit

//TODO: Monitorar estado da bateria https://stackoverflow.com/questions/27475506/check-battery-level-ios-swift

class BatteriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var mainList: UITableView = .init()
    
    override func viewDidLoad() {
        setupList()
        UIDevice.current.isBatteryMonitoringEnabled = true
        mainList.delegate = self
        mainList.dataSource = self
        mainList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func setupList(){
        if #available(iOS 13.0, *) {
            self.mainList = .init(frame: CGRect.zero, style: .insetGrouped)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let cellContent = VStack{
            Label("\(UIDevice.current.name)")
            Label("\(UIDevice.current.batteryLevel.percent)%")
        }
        
        print("Device name: \(UIDevice.current.name)")
        
        cell.addSubview(cellContent)
        cellContent.fillParent()
        
        return cell
    }
    
}
