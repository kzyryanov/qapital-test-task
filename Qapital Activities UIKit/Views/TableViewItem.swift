//
//  TableViewItem.swift
//  Qapital Activities UIKit
//
//  Created by Konstantin Zyrianov on 2021-09-16.
//

import UIKit

enum TableViewItem: Equatable {
    struct CellDescriptor {
        let reuseIdentifier: String
        let fromNib: Bool
        let cellClass: UITableViewCell.Type
        let configure: ((_ cell: UITableViewCell) -> ())?
    }
    
    case loading
    case activity(ActivityViewModel)
    
    var cellDescriptor: CellDescriptor {
        switch self {
        case .loading:
            return CellDescriptor(
                reuseIdentifier: "LoadingCell",
                fromNib: false,
                cellClass: LoadingCell.self,
                configure: { cell in
                    guard let cell = cell as? LoadingCell else { return }
                    cell.configure()
                })
        case .activity(let activityViewModel):
            return CellDescriptor(
                reuseIdentifier: "ActivityCell",
                fromNib: true,
                cellClass: LoadingCell.self,
                configure: { cell in
                    guard let cell = cell as? ActivityCell else { return }
                    cell.configure(with: activityViewModel)
                })
        }
    }
    
    static func == (lhs: TableViewItem, rhs: TableViewItem) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.activity(let viewModel1), .activity(let viewModel2)):
            return viewModel1.id == viewModel2.id
        default:
            return false
        }
    }
}
