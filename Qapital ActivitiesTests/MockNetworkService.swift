//
//  MockNetworkService.swift
//  Qapital ActivitiesTests
//
//  Created by Konstantin Zyrianov on 2021-09-17.
//

import Foundation
import Combine
@testable import Qapital_Activities

final class MockNetworkService: Networking {
    private let output: Output?
    private let failure: Failure?
    
    init(output: Output?, failure: Failure?) {
        self.output = output
        self.failure = failure
    }
    
    func dataTaskPublisher(for url: URL) -> AnyPublisher<Output, Failure> {
        if let output = self.output {
            return Just(output)
                .setFailureType(to: Failure.self)
                .eraseToAnyPublisher()
        }
        
        if let failure = self.failure {
            return Fail(error: failure)
                .eraseToAnyPublisher()
        }
        
        fatalError("Either output or failure shouldn't be nil")
    }
}
