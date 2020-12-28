//
//  CalendarManagerTests.swift
//  ToDoDiaryTests
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import XCTest
@testable import ToDoDiary

class CalendarManagerTests: XCTestCase {
    
    private var calendarManager: CalendarManager!
    
    override func setUpWithError() throws {
        calendarManager = CalendarManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalendarFormat() throws {
        XCTContext.runActivity(named: "月の初めのフォーマット") { activity in
            let firstDayOfMonth = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1))!
            
            let excepted = "1/1"
            
            let actual = calendarManager.formatDateForCalendar(date: firstDayOfMonth)
            
            XCTAssertEqual(actual, excepted)
        }
        
        XCTContext.runActivity(named: "月の途中のフォーマット") { activity in
            let otherDayOfMonth = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 3))!

            let otherExcepted = "3"

            let otherActual = calendarManager.formatDateForCalendar(date: otherDayOfMonth)

            XCTAssertEqual(otherActual, otherExcepted)
        }
    }
    
    func testFormatFullDate() throws {
        XCTContext.runActivity(named: "普通の日のフォーマット") { activity in
            let day = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 12, day: 25))
            
            let excepted = "2020/12/25 (金)"
            
            let actual = calendarManager.formatFullDate(date: day)
            
            XCTAssertEqual(actual, excepted)
        }
        
        XCTContext.runActivity(named: "月と日が一桁のフォーマット") { activity in
            let day2 = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2021, month: 1, day: 1))
            
            let excepted2 = "2021/1/1 (金)"
            
            let actual2 = calendarManager.formatFullDate(date: day2)
            
            XCTAssertEqual(actual2, excepted2)
        }
    }
    
    func testDayOffset() throws {
        XCTContext.runActivity(named: "各曜日") { activity in
            for i in 0 ..< 7 {
                let thursday = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 12, day: 20 + i))!
                
                let excepeted = i
                
                let actual = calendarManager.getDayOffset(date: thursday)
                
                XCTAssertEqual(excepeted, actual)
            }
        }
        
        XCTContext.runActivity(named: "日曜日（マイナス）") { activity in
            let minus = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 12, day: -1))!    // sunday
            
            let excepeted2 = 0
            
            let actual2 = calendarManager.getDayOffset(date: minus)
            
            XCTAssertEqual(excepeted2, actual2)
        }
    }
    
    func testOddMonth() throws {
        XCTContext.runActivity(named: "奇数の月") { activity in
            let oddMonth = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 11, day: 12))!
            
            XCTAssertTrue(calendarManager.isOddMonth(date: oddMonth))
        }
        
        XCTContext.runActivity(named: "偶数の月") { activity in
            let evenMonth = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 12, day: 12))!
            XCTAssertFalse(calendarManager.isOddMonth(date: evenMonth))
        }
    
        XCTContext.runActivity(named: "奇数（マイナス)") { activity in
            let minusMonth = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 12, day: -1))!
            
            XCTAssertTrue(calendarManager.isOddMonth(date: minusMonth))
        }
        
    }
    
    func testPeformanceOfCalendar() throws {
        let eventManager = EventManager()
        self.measure {
            for i in -2100 ..< 2100 {
                let date = calendarManager.getDateFromIndex(index: i)
                let dateStr = calendarManager.formatFullDate(date: date)
                let _events = eventManager.getEventArrayFromDate(date: dateStr)
                if let events = _events {
                    if events.count > 0 { print(events) }
                }
            }
        }
    }

}
