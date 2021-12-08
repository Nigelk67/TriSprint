//
//  TrainingArrayViewModel_Tests.swift
//  TriSprint_Tests
//
//  Created by Nigel Karan on 08.12.21.
//

import XCTest
@testable import TriSprint

class TrainingArrayViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_trainingArray_shouldBeEmpty() {
        let vm = TrainingPlanArrayViewModel()
        XCTAssertTrue(vm.trainingPlan.isEmpty)
    }
    
    func test_isSaving_shouldBeFalse() {
        let vm = TrainingPlanArrayViewModel()
        XCTAssertFalse(vm.isSaving)
    }
    
    func test_hasLoadedPlans_shouldBeFalse() {
        let vm = TrainingPlanArrayViewModel()
        XCTAssertFalse(vm.hasLoadedPlans)
    }
    
    func test_trainingArray_addItemsfor3DayPlan() {
        let daysPerWeek = "3"
        let vm = TrainingPlanArrayViewModel()
        vm.fetchPlanArray(name: daysPerWeek)
        XCTAssertTrue(!vm.trainingPlan.isEmpty)
    }
    
    func test_trainingArray_addItemsfor4DayPlan() {
        let daysPerWeek = "4"
        let vm = TrainingPlanArrayViewModel()
        vm.fetchPlanArray(name: daysPerWeek)
        XCTAssertTrue(!vm.trainingPlan.isEmpty)
    }
    
    func test_trainingArray_addItemsfor5DayPlan() {
        let daysPerWeek = "5"
        let vm = TrainingPlanArrayViewModel()
        vm.fetchPlanArray(name: daysPerWeek)
        XCTAssertTrue(!vm.trainingPlan.isEmpty)
    }
    
    
}
