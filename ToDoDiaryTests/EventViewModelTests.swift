//
//  EventViewModelTests.swift
//  ToDoDiaryTests
//
//  Created by Tatsuya Ishii on 2020/12/27.
//

import XCTest
@testable import ToDoDiary

class EventViewModelTests: XCTestCase {

    private var eventViewModel: EventViewModel!
    
    override func setUpWithError() throws {
        eventViewModel = EventViewModel()
        eventViewModel.title = "件名です"
        eventViewModel.place = "場所です"
        eventViewModel.color = .blue
        eventViewModel.selectedDates = [Calendar(identifier: .gregorian).startOfDay(for: Date())]
        eventViewModel.notification = .once
        eventViewModel.detail = "詳細です"
        eventViewModel.startTime = Date()
        eventViewModel.endTime = Date().addingTimeInterval(TimeInterval(60 * 60))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateEvent() throws {
        XCTContext.runActivity(named: "日付を選択していない時") { activity in
            eventViewModel.selectedDates = []
            
            let _events = eventViewModel.createEventData()
            
            guard let events = _events else { XCTFail("イベントの作成に失敗"); return }
            
            guard events.count > 0 else { XCTFail("イベントの数がゼロです"); return }
            
            XCTAssertNil(events[0].date)
        }
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
