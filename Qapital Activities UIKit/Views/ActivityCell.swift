//
//  ActivityCell.swift
//  Qapital Activities UIKit
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import UIKit
import Combine


final class ActivityCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    private var avatarSubscription: AnyCancellable?
    
    func configure(with activityViewModel: ActivityViewModel) {
        messageLabel.attributedText = activityViewModel.message
        dateLabel.text = activityViewModel.date
        amountLabel.text = activityViewModel.amount
        
        activityViewModel.cancelFetchingAvatar()
        activityViewModel.fetchAvatar()
        
        avatarSubscription?.cancel()
        avatarSubscription = activityViewModel
            .$avatar
            .map({ $0 ?? UIImage(systemName: "person.crop.circle") })
            .assign(to: \.image, on: avatarImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = min(avatarImageView.frame.height, avatarImageView.frame.width) * 0.5
    }
}
