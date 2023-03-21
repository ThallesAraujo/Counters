//
//  BatteriesViewController.swift
//  Counters
//
//  Created by Thalles Araújo on 14/03/23.
//

import Foundation
import UIKit

//TODO: Monitorar estado da bateria https://stackoverflow.com/questions/27475506/check-battery-level-ios-swift

//TODO: Exibir imagem do dispositivo

class BatteriesViewController: ListViewController, UITableViewDelegate, UITableViewDataSource{
    
    override func viewDidLoad() {
        setupListiOS13()
        UIDevice.current.isBatteryMonitoringEnabled = true
        mainList.delegate = self
        mainList.dataSource = self
        mainList.reloadData()
        readDeviceProperties()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func readDeviceProperties(){
        print("Modelo: \(UIDevice.modelName)")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let cellContent = VStack{
            Label("\(UIDevice.current.name)")
            Label("\(UIDevice.current.batteryLevel.percent)%")
        }
        
        cellContent.mainView.distribution = .fillEqually
        
        print("Device name: \(UIDevice.current.name)")
        
        cell.addSubview(cellContent)
        cellContent.fillParent()
        
        return cell
    }
    
}
