//
//  ActivityViewModel.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import UIKit
import Combine

final class ActivityViewModel: ObservableObject, Identifiable {
    let message: NSAttributedString
    let date: String
    let amount: String
    let id: Date
    @Published private(set) var avatar: UIImage?
    
    private var avatarSubscription: AnyCancellable?
    private var service: Service
    
    private let userId: Int
    
    init(_ activity: Activity, service: Service) {
        let modifiedMessage = "<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: 16px; color: #8F96A3; \">\(activity.message)</span>"
        let data = Data(modifiedMessage.utf8)
        let message = (try? NSMutableAttributedString(
            data: data,
            options: [ .documentType: NSAttributedString.DocumentType.html ],
            documentAttributes: nil)) ?? NSMutableAttributedString(string: activity.message)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        
        let range = NSRange(location: 0, length: message.string.count)
        
        message.addAttributes([ .paragraphStyle: paragraphStyle ], range: range)
        
        
        self.message = message
        self.date = DateHelper.formattedString(from: activity.timestamp)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "USD"
        
        self.amount = numberFormatter.string(from: NSNumber(value: activity.amount)) ?? "$\(activity.amount)"
        
        self.id = activity.timestamp
        self.userId = activity.userId
        self.service = service
        
    }
    
    func fetchAvatar() {
        avatarSubscription = service
            .user(id: self.userId)
            .flatMap({ user in
                return self.service.getImage(url: user.avatarUrl)
            })
            .replaceError(with: UIImage(systemName: "person.crop.circle"))
            .receive(on: DispatchQueue.main)
            .assign(to: \.avatar, on: self)
    }
    
    func cancelFetchingAvatar() {
        avatarSubscription?.cancel()
    }
}
