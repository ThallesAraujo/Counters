//
//  ListView.swift
//  Counters
//
//  Created by Thalles Araújo on 01/04/23.
//

import Foundation
import UIKit

typealias ListViewCellClosure = (Any, IndexPath) -> UIView

class ListView: UITableView{
    
    var delegateDataSource: ListViewDelegateDataSource?
    
    var items: [Any] = []{
        didSet{
            self.reloadData()
        }
    }
    
    var cellClosure: ListViewCellClosure = {_, _ in return UIView()}
    
    init(items: [Any], _  cellClosure: @escaping ListViewCellClosure){
        if #available(iOS 13.0, *) {
            super.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100), style: .insetGrouped)
        } else {
            super.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100), style: .plain)
        }
        self.items = items
        self.cellClosure = cellClosure
        self.delegateDataSource = ListViewDelegateDataSource(list: self, items: items, cellClosure: cellClosure)
        self.delegate = delegateDataSource
        self.dataSource = delegateDataSource
        self.items = items
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}


class ListViewDelegateDataSource: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    var list: ListView
    
    var items: [Any]
    
    var cellClosure: ListViewCellClosure
    
    init(list: ListView, items: [Any], cellClosure: @escaping ListViewCellClosure) {
        self.list = list
        self.items = items
        self.cellClosure = cellClosure
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = UITableViewCell(frame: CGRect.init(x: 0, y: 0, width: 100, height: 50))
        let view = cellClosure(item, indexPath)
        
        cell.addSubview(view)
        view.fillParent(withPadding: 8)
        
        return cell
    }
    
}
