//
//  CalendarManagerTests.swift
//  ToDoDiaryTests
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import XCTest
@testable import ToDoDiary

class CalendarManagerTests: XCTestCase {
    
    var calendarManager: CalendarManager!
    
    override func setUpWithError() throws {
        calendarManager = CalendarManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalendarFormat() throws {
        let firstDayOfMonth = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1))!
        
        let excepted = "1/1"
        
        let actual = calendarManager.formatDateForCalendar(date: firstDayOfMonth)
        
        XCTAssertEqual(actual, excepted)

        let otherDayOfMonth = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 3))!

        let otherExcepted = "3"

        let otherActual = calendarManager.formatDateForCalendar(date: otherDayOfMonth)

        XCTAssertEqual(otherActual, otherExcepted)
    }
    
    func testFormatFullDate() throws {
        let day = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 12, day: 25))
        
        let excepted = "2020/12/25 (金)"
        
        let actual = calendarManager.formatFullDate(date: day)
        
        XCTAssertEqual(actual, excepted)
        
        let day2 = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2021, month: 1, day: 1))
        
        let excepted2 = "2021/1/1 (金)"
        
        let actual2 = calendarManager.formatFullDate(date: day2)
        
        XCTAssertEqual(actual2, excepted2)
    }
    
    func testDayOffset() throws {
        let thursday = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 12, day: 24))!
        
        let excepeted = 4
        
        let actual = calendarManager.getDayOffset(date: thursday)
        
        XCTAssertEqual(excepeted, actual)
        
        let minus = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 12, day: -1))!    // sunday
        
        let excepeted2 = 0
        
        let actual2 = calendarManager.getDayOffset(date: minus)
        
        XCTAssertEqual(excepeted2, actual2)
    }
    
    func testOddMonth() throws {
        let oddMonth = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 11, day: 12))!
        
        XCTAssertTrue(calendarManager.isOddMonth(date: oddMonth))
        
        let evenMonth = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 12, day: 12))!
        
        XCTAssertFalse(calendarManager.isOddMonth(date: evenMonth))
        
        let minusMonth = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 12, day: -1))!
        
        XCTAssertTrue(calendarManager.isOddMonth(date: minusMonth))
    }

}
