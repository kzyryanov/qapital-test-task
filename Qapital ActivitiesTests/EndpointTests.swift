//
//  EndpointTests.swift
//  Qapital ActivitiesTests
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import XCTest
@testable import Qapital_Activities

final class EndpointTests: XCTestCase {
    
    func testActivities() throws {
        let fromDate = Date(timeIntervalSince1970: 0.0)
        let toDate = Date(timeIntervalSince1970: 3600.0)
        
        let url = try Endpoint.activities(from: fromDate, to: toDate).url(host: "example.com")
        
        let expectedUrlString = "http://example.com/activities?from=1970-01-01T00:00:00+00:00&to=1970-01-01T01:00:00+00:00"
        
        XCTAssert(url.absoluteString == expectedUrlString)
    }
    
    func testUsers() throws {
        let userId = 0
        
        let url = try Endpoint.user(id: userId).url(host: "example.com")
        
        let expectedUrlString = "http://example.com/users/\(userId)"
        
        XCTAssert(url.absoluteString == expectedUrlString)
    }
}

