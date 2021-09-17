//
//  ActivitiesViewController.swift
//  Qapital Activities UIKit
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import UIKit
import Combine

final class ActivitiesViewController: UIViewController {
    private let activitiesViewModel: ActivitiesViewModel
    
    private var cancellableBag: Set<AnyCancellable> = Set()
    
    private weak var tableView: UITableView?
    
    private var hasMore: Bool
    private var activities: [ActivityViewModel]
    
    private lazy var dataSource = ActivitiesDataSource()
    
    init(activitiesViewModel: ActivitiesViewModel) {
        self.activitiesViewModel = activitiesViewModel
        self.hasMore = activitiesViewModel.hasMore
        self.activities = activitiesViewModel.activities
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self.dataSource
        
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tableView.register(UINib(nibName: "ActivityCell", bundle: Bundle.main), forCellReuseIdentifier: "ActivityCell")
        tableView.register(LoadingCell.self, forCellReuseIdentifier: "LoadingCell")
        
        self.tableView = tableView
        
        activitiesViewModel.$state.sink { [weak self] state in
            guard let self = self else { return }
            guard let tableView = self.tableView else { return }
            
            switch state {
            case .failed:
                self.dataSource.updateLoadingSection(showLoading: false, for: tableView)
            case .none:
                self.dataSource.updateLoadingSection(showLoading: false, for: tableView)
            case .loading:
                self.dataSource.updateLoadingSection(showLoading: true, for: tableView)
            case .loaded:
                self.dataSource.updateActivities(self.activitiesViewModel.activities, for: tableView)
                self.dataSource.updateLoadingSection(showLoading: self.activitiesViewModel.hasMore, for: tableView)
            }
        }.store(in: &cancellableBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

extension ActivitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let item = dataSource.item(for: indexPath)
        if item == .loading {
            activitiesViewModel.getActivities()
        }
    }
}
