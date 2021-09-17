//
//  APIServicePreview.swift
//  APIServicePreview
//
//  Created by Konstantin Zyrianov on 2021-09-16.
//

import Foundation
import Combine
import UIKit

final class PreviewAPIService: Service {
    
    func activities(from fromDate: Date, to toDate: Date) -> AnyPublisher<ActivitiesResponse, Error> {
        guard let expectedOldestDate = DateHelper.date(from: "2016-05-23T00:00:00+00:00"),
              let expectedTimestamp1 = DateHelper.date(from: "2016-10-04T00:00:00+00:00"),
              let extectedTimestamp2 = DateHelper.date(from: "2016-10-03T00:00:00+00:00") else {
            return Fail(error: APIServiceError.dateError).eraseToAnyPublisher()
        }
        
        let response = ActivitiesResponse(
            oldest: expectedOldestDate,
            activities: [
                Activity(message: "<strong>You</strong> didn't resist a guilty pleasure at <strong>Starbucks</strong>.",
                         amount: 2.5,
                         userId: 2,
                         timestamp: expectedTimestamp1),
                Activity(message: "<strong>You</strong> made a roundup.",
                         amount: 0.32,
                         userId: 3,
                         timestamp: extectedTimestamp2)
            ])
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func user(id userId: Int) -> AnyPublisher<User, Error> {
        guard let url = URL(string: "http://qapital-ios-testtask.herokuapp.com/avatars/mikael.jpg") else {
            return Fail(error: APIServiceError.internalUrlError).eraseToAnyPublisher()
        }
        
        let response = User(
            userId: 1,
            displayName: "Mikael",
            avatarUrl: url)
        
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getImage(url: URL) -> AnyPublisher<UIImage?, Error> {
        return Just(UIImage(systemName: "person.crop.circle"))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
