//
//  ViewController.swift
//  Counters
//
//  Created by Thalles Araújo on 04/03/23.
//

import UIKit
import HealthKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: HealthDataViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = .init({
            let list = self.view.subviews.first(where: {type(of: $0) == ListView.self})
            if let ls = list as? ListView{
                ls.reloadData()
            }
        })
        
        //mainList.delegate = self
        //mainList.dataSource = self
        viewModel?.getHealthData()
        setupList()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let list = self.view.subviews.first(where: {type(of: $0) == ListView.self})
        if let ls = list as? ListView{
            ls.translatesAutoresizingMaskIntoConstraints = false
            ls.fillParent(withPadding: 0)
        }
        //TODO: Por hora, corrige cores em células erradas. Porém não é a melhor solução
        //self.mainList.reloadData()
    }
    
    func setupList(){
        
        guard let healthData = viewModel?.healthData else {return}
        
        self.view.addSubview(
            ListView(items: healthData, { healthData, indexPath in
                VStack{
                    HStack(padding: 0){
                        Image(name: self.getSection(indexPath).iconName).tintColor(self.getDataColor(indexPath))
                        HStack(horizontalPadding: 4){
                            Label(self.getSection(indexPath).title).textColor(self.getDataColor(indexPath))
                        }
                    }
                    Label("\((healthData as! HealthData).data)\(self.getSection(indexPath).unit)")
                }
            }))
        
//        setupListiOS13()
//        self.mainList.register(RegularDataCell.self, forCellReuseIdentifier: regularCellDataIdentifier)
    }
    
    func getSection(_ indexPath: IndexPath) -> MainTableViewSection{
        return mainTableViewSections[indexPath.item]
    }
    
    func getDataColor(_ indexPath: IndexPath) -> UIColor {
        return UIColor.init(named: getSection(indexPath).colorName).orDefault
    }
    
    
    //MARK: - TableView
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let healthData = viewModel?.healthData, !(healthData.isEmpty){
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: regularCellDataIdentifier) as? RegularDataCell, indexPath.item < healthData.count{
                
                let section = mainTableViewSections[indexPath.item]
                
                let dataColor = UIColor(named: section.colorName).orDefault
                
                cell.view = VStack(padding: 0){
                    HStack(padding: 0){
                        Image(name: section.iconName).tintColor(dataColor)
                        HStack(horizontalPadding: 4){
                            Label(section.title).textColor(dataColor)
                        }
                    }
                    Label("\(healthData[indexPath.row].data)\(section.unit)")
                }
                
                cell.draw(cell.frame)
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

