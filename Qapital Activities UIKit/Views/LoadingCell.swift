//
//  LoadingCell.swift
//  Qapital Activities UIKit
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import UIKit

final class LoadingCell: UITableViewCell {
    private weak var activitiyIndicator: UIActivityIndicatorView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        selectionStyle = .none
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activitiyIndicator = activityIndicator
        self.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            activityIndicator.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 8),
            self.bottomAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 8),
            self.trailingAnchor.constraint(greaterThanOrEqualTo: activityIndicator.trailingAnchor, constant: 8),
            self.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor)
        ])
    }
    
    func configure() {
        self.activitiyIndicator?.startAnimating()
    }
}
