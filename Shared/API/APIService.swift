//
//  APIService.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-14.
//

import Combine
import UIKit.UIImage

enum APIServiceError: Error {
    case internalUrlError
    case statusCode
    case dateError
}

protocol Service {
    func activities(from fromDate: Date, to toDate: Date) -> AnyPublisher<ActivitiesResponse, Error>
    func user(id userId: Int) -> AnyPublisher<User, Error>
    func getImage(url: URL) -> AnyPublisher<UIImage?, Error>
}

final class APIService: Service {
    private static let host = "qapital-ios-testtask.herokuapp.com"
    
    // TODO: move networking outside for mocking and testing different responses
    
    private let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
        
    func activities(from fromDate: Date, to toDate: Date) -> AnyPublisher<ActivitiesResponse, Error> {
        return dataTask(for: .activities(from: fromDate, to: toDate))
    }
    
    func user(id userId: Int) -> AnyPublisher<User, Error> {
        return dataTask(for: .user(id: userId))
    }
    
    func getImage(url: URL) -> AnyPublisher<UIImage?, Error> {
        if let image = ImageCache.shared.image(for: url.absoluteString) {
            return Just(image)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .tryMap({ response in
                guard let httpURLResponse = response.response as? HTTPURLResponse,
                      httpURLResponse.statusCode == 200 else {
                    throw APIServiceError.statusCode
                }
                let image = UIImage(data: response.data)
                if let image = image {
                    ImageCache.shared.cache(image, for: url.absoluteString)
                }
                return image
            })
            .eraseToAnyPublisher()
    }
    
    private func dataTask<T: Decodable>(for endpoint: Endpoint) -> AnyPublisher<T, Error> {
        do {
            let url = try endpoint.url(host: APIService.host)
            print("Send request: \(url.absoluteString)")
            return session.dataTaskPublisher(for: url)
                .tryMap({ response in
                    guard let httpURLResponse = response.response as? HTTPURLResponse,
                          httpURLResponse.statusCode == 200 else {
                        throw APIServiceError.statusCode
                    }
                    return response.data
                })
                .decode(type: T.self, decoder: ISO8601JSONDecoder())
                .eraseToAnyPublisher()
        } catch let error {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
