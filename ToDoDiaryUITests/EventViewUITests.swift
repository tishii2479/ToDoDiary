//
//  EventViewUITests.swift
//  ToDoDiaryUITests
//
//  Created by Tatsuya Ishii on 2020/12/27.
//

import XCTest
@testable import ToDoDiary

class EventViewUITests: XCTestCase {

//    override func setUpWithError() throws {
//
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
    
    func testCreateEvent() throws {
        XCTContext.runActivity(named: "普通のイベントの作成") { activity in
            let app = XCUIApplication()
            app.launch()
            
            let createEventButton = app.buttons["CreateEventButton"]
            
            createEventButton.tap()
            
            let titleField = app.textFields["TitleField"]
            
            titleField.tap()
            titleField.typeText("件名です")
            
            XCTAssertEqual(titleField.value as! String, "件名です")
            
            let placeField = app.textFields["PlaceField"]
            
            placeField.tap()
            placeField.typeText("場所です")
            
            XCTAssertEqual(placeField.value as! String, "場所です")
            
            let colorButton = app.buttons.matching(identifier: "ColorPalette").element(boundBy: 1)
            
            colorButton.tap()
        }
        
    }
    
//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
