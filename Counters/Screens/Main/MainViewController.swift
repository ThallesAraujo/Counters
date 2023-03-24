//
//  ViewController.swift
//  Counters
//
//  Created by Thalles Araújo on 04/03/23.
//

import UIKit
import HealthKit

class MainViewController: ListViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: HealthDataViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = .init({
            self.mainList.reloadData()
        })
        
        setupList()
        mainList.delegate = self
        mainList.dataSource = self
        viewModel?.getHealthData()
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
    
    
    //MARK: - TableView
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let healthData = viewModel?.healthData, !(healthData.isEmpty){
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: regularCellDataIdentifier) as? RegularDataCell, indexPath.item < healthData.count{
                let section = mainTableViewSections[indexPath.item]
                
                var dataColor = UIColor(named: section.colorName).orDefault
                
                cell.view = VStack(padding: 0){
                    HStack(padding: 0){
                        Image(name: section.iconName).tintColor(dataColor)
                        HStack(horizontalPadding: 4){
                            Label(section.title).textColor(dataColor)
                        }
                    }
                    Label("\(healthData[section.dataType.rawValue].orEmpty)\(section.unit)")
                }
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

