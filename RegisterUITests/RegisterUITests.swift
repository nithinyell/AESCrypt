//
//  RegisterUITests.swift
//  RegisterUITests
//
//  Created by Nithin on 28/12/19.
//  Copyright © 2019 Nithin. All rights reserved.
//

import XCTest

class RegisterUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.navigationBars["Music Students"].buttons["plus"].tap()
        
        let elementsQuery = app.alerts["Add New Student"].scrollViews.otherElements
        let collectionViewsQuery = elementsQuery.collectionViews
        let nameTextField = collectionViewsQuery.textFields["Name"]
        nameTextField.tap()
        let courseTextField = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Course"]/*[[".cells.textFields[\"Course\"]",".textFields[\"Course\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        courseTextField.tap()
        let ageTextField = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Age"]/*[[".cells.textFields[\"Age\"]",".textFields[\"Age\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        ageTextField.tap()
        
        elementsQuery.buttons["Save"].tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
