//
//  CalendarManagerTests.swift
//  ToDoDiaryTests
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import XCTest
@testable import ToDoDiary

class CalendarManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalendarFormatOfFirstDay() throws {
        let calendarManager = CalendarManager()
        
        let firstDayOfMonth = Calendar.current.date(from: DateComponents(year: 2020, month: 1, day: 1))!
        
        let excepted = "1/1"
        
        let actual = calendarManager.formatForCalendar(date: firstDayOfMonth)
        
        XCTAssertEqual(actual, excepted)
    }
    
    func testCalendarFormatOfOtherDay() throws {
        let calendarManager = CalendarManager()

        let otherDayOfMonth = Calendar.current.date(from: DateComponents(year: 2020, month: 1, day: 3))!

        let excepted = "3"

        let actual = calendarManager.formatForCalendar(date: otherDayOfMonth)

        XCTAssertEqual(actual, excepted)
    }
    
    func testDayOffset() throws {
        let calendarManager = CalendarManager()
        
        let thursday = Calendar.current.date(from: DateComponents(year: 2020, month: 12, day: 24))!
        
        let excepeted = 4
        
        let actual = calendarManager.getDayOffset(date: thursday)
        
        XCTAssertEqual(excepeted, actual)
    }

}
