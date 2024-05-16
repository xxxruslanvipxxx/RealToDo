//
//  RealToDoUITests.swift
//  RealToDoUITests
//
//  Created by Руслан Забиран on 15.05.24.
//

import XCTest
@testable import RealToDo

final class RealToDoUITests: XCTestCase {

    override func setUpWithError() throws {
        
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddNewTask() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let expectedMainText = "Foo Bazz Bar"
        let expectedAdditionalText = "Bar Bazz Foo"
        
        app.buttons["Add"].tap()
        
        let mainTextField = app.textFields["MainTextField"]
        mainTextField.tap()
        mainTextField.typeText("Foo Bazz Bar")
        
        let additionalTextView = app.textViews["AdditionalTextView"]
        additionalTextView.tap()
        additionalTextView.typeText("Bar Bazz Foo")
        
        let addButton = app.buttons["SaveButton"]
        addButton.tap()
        
        let index = 0
        let tableView = app.tables.matching(identifier: "ListTableView")
        let cell = tableView.cells.element(matching: .cell, identifier: "cell_\(index)")
        
        let mainLabel = cell.staticTexts["mainLabel"]
        let additionalLabel = cell.staticTexts["additionalLabel"]
        
        XCTAssertEqual(mainLabel.label, expectedMainText)
        XCTAssertEqual(additionalLabel.label, expectedAdditionalText)
        
    }
    
    func testDeleteTask() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let index = 0
        let tableView = app.tables.matching(identifier: "ListTableView")
        let cell = tableView.cells.element(matching: .cell, identifier: "cell_\(index)")
        
        try? XCTSkipIf(!cell.exists)
        
        cell.swipeLeft(velocity: .slow)
        cell.buttons["Delete"].tap()
        
        XCTAssert(!cell.exists)

    }
    
    func testRedactTask() {
        
        let app = XCUIApplication()
        app.launch()
        
        let index = 0
        let tableView = app.tables.matching(identifier: "ListTableView")
        let cell = tableView.cells.element(matching: .cell, identifier: "cell_\(index)")
        
        try? XCTSkipIf(!cell.exists)
        cell.tap()
        
        let mainTextField = app.textFields["MainTextField"]
        mainTextField.tap()
        
        mainTextField.typeText("Foo Bazz Bar")
        
        let additionalTextView = app.textViews["AdditionalTextView"]
        additionalTextView.tap()
        additionalTextView.typeText("Bar Bazz Foo")
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
            
        }
    }
}
