//
//  ActivitiesDataSource.swift
//  Qapital Activities UIKit
//
//  Created by Konstantin Zyrianov on 2021-09-16.
//

import UIKit

final class ActivitiesDataSource: NSObject, UITableViewDataSource {
    private var activitiesSection: [TableViewItem] = []
    private var loadingSection: [TableViewItem] = []
    
    private var sections: [[TableViewItem]] {
        return [
            activitiesSection,
            loadingSection
        ]
    }
    
    private var registeredIdentifiers: Set<String> = Set()
    
    func item(for indexPath: IndexPath) -> TableViewItem {
        return sections[indexPath.section][indexPath.row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.item(for: indexPath)
        let cellDescriptor = item.cellDescriptor
        
        if !self.registeredIdentifiers.contains(cellDescriptor.reuseIdentifier) {
            if cellDescriptor.fromNib {
                tableView.register(UINib(nibName: cellDescriptor.reuseIdentifier, bundle: Bundle.main),
                                   forCellReuseIdentifier: cellDescriptor.reuseIdentifier)
            } else {
                tableView.register(cellDescriptor.cellClass, forCellReuseIdentifier: cellDescriptor.reuseIdentifier)
            }
            self.registeredIdentifiers.insert(cellDescriptor.reuseIdentifier)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellDescriptor.reuseIdentifier, for: indexPath)
        
        cellDescriptor.configure?(cell)
        
        return cell
    }
    
    func updateActivities(_ activities: [ActivityViewModel], for tableView: UITableView) {
        activitiesSection = activities.map({ .activity($0) })
        tableView.reloadData()
    }
    
    func updateLoadingSection(showLoading: Bool, for tableView: UITableView) {
        if showLoading {
            loadingSection = [.loading]
        } else {
            loadingSection = []
        }
        tableView.reloadData()
    }
}
