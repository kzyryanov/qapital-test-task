//
//  DateHelperTests.swift
//  Qapital ActivitiesTests
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import XCTest
@testable import Qapital_Activities

final class DateHelperTests: XCTestCase {
    // TODO: pass differently formatted date strings and invalid one
    
    func testStringFromDate() throws {
        let dateComponents = DateComponents(
            calendar: Calendar.current,
            timeZone: TimeZone(identifier: "UTC"),
            year: 2016,
            month: 5,
            day: 23,
            hour: 0,
            minute: 0,
            second: 0)
        
        guard let date = dateComponents.date else {
            assertionFailure("Invalid date")
            return
        }
        
        let dateString = DateHelper.string(from: date)
        
        let expectedDateString = "2016-05-23T00:00:00+00:00"
        
        XCTAssert(dateString == expectedDateString)
    }
    
    func testDateFromString() throws {
        let dateString = "2016-05-23T00:00:00+00:00"
        
        let date = DateHelper.date(from: dateString)
        
        let dateComponents = DateComponents(
            calendar: Calendar.current,
            timeZone: TimeZone(identifier: "UTC"),
            year: 2016,
            month: 5,
            day: 23,
            hour: 0,
            minute: 0,
            second: 0)
        
        guard let expectedDate = dateComponents.date else {
            assertionFailure("Invalid date")
            return
        }
        
        XCTAssert(date == expectedDate)
    }
}
