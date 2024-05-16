//
//  RealToDoTests.swift
//  RealToDoTests
//
//  Created by Руслан Забиран on 9.05.24.
//

import XCTest
@testable import RealToDo

final class RealToDoTests: XCTestCase {

    var taskVM: TaskViewModel!
    var navController: UINavigationController!
    var appCoordinator: AppCoordinator!
    var taskRepository: TaskRepositoryProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        navController = UINavigationController()
        appCoordinator = AppCoordinator(navCon: navController)
        taskRepository = TaskRepository()
        taskVM = TaskViewModel(appCoordinator: appCoordinator, taskRepository: taskRepository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        navController = nil
        appCoordinator = nil
        taskRepository = nil
        taskVM = nil
        try super.tearDownWithError()
    }

    func testTaskVMCorrectWithEmptyStateTextFieldState() throws {
        // Given
        let textFieldText = ""
        let expectedResult = true
        var validateResult: Bool
        // When
        taskVM.setTextFieldState(text: textFieldText)
        validateResult = taskVM.textFieldIsEmpty.value
        // Then
        XCTAssertEqual(expectedResult, validateResult)
    }

    func testPerformanceExample() throws {
        let textFieldText = ""
        measure {
            taskVM.setTextFieldState(text: textFieldText)
        }
    }

}
