//
//  ModelTests.swift
//  Qapital ActivitiesTests
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import XCTest
@testable import Qapital_Activities

extension Activity: Equatable {
    public static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.message == rhs.message &&
            lhs.amount == rhs.amount &&
            lhs.timestamp == rhs.timestamp &&
            lhs.userId == rhs.userId
    }
}

extension ActivitiesResponse: Equatable {
    public static func == (lhs: ActivitiesResponse, rhs: ActivitiesResponse) -> Bool {
        return lhs.oldest == rhs.oldest &&
            lhs.activities == rhs.activities
    }
}

// TODO: test invalid jsons, empty strings and if some field are optional - null for them
final class ModelTests: XCTestCase {
    
    func testActivitiesResponse() throws {
        let json = #"""
            { "oldest": "2016-05-23T00:00:00+00:00", "activities": [
            {
                "message": "<strong>You</strong> didn't resist a guilty pleasure at <strong>Starbucks</strong>.",
                "amount": 2.5,
                "userId": 2,
                "timestamp": "2016-10-04T00:00:00+00:00"
            },
            {
                "message": "<strong>You</strong> made a roundup.",
                "amount": 0.32,
                "userId": 3,
                "timestamp": "2016-10-03T00:00:00+00:00"
            }
        ] }
"""#
 
        let jsonData = Data(json.utf8)
        
        let activitiesResponse = try ISO8601JSONDecoder().decode(ActivitiesResponse.self, from: jsonData)
        
        guard let expectedOldestDate = DateHelper.date(from: "2016-05-23T00:00:00+00:00"),
              let expectedTimestamp1 = DateHelper.date(from: "2016-10-04T00:00:00+00:00"),
              let extectedTimestamp2 = DateHelper.date(from: "2016-10-03T00:00:00+00:00") else {
            assertionFailure("Invalid date")
            return
        }
        
        let expectedResponse = ActivitiesResponse(
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
        
        XCTAssert(activitiesResponse == expectedResponse)
    }
    
    func testUsersResponse() throws {
        let json = #"""
            [
                {
                    "userId": 1,
                    "displayName": "Mikael",
                    "avatarUrl": "http://qapital-ios-testtask.herokuapp.com/avatars/mikael.jpg"
                }
            ]
        """#
        let jsonData = Data(json.utf8)
        
        let usersResponse = try ISO8601JSONDecoder().decode([User].self, from: jsonData)
        
        guard let url = URL(string: "http://qapital-ios-testtask.herokuapp.com/avatars/mikael.jpg") else {
            assertionFailure("Invalid URL")
            return
        }
        
        let expectedResponse = [
            User(userId: 1,
                 displayName: "Mikael",
                 avatarUrl: url)
        ]
        
        XCTAssert(expectedResponse == usersResponse)
    }
}
