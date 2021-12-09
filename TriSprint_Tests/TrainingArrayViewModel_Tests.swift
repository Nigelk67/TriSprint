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
    
    func test_trainingArray_addItemsfromPlan_shouldNotBeEmpty() {
        let loopCount: Int = Int.random(in: 1..<10)
        let vm = TrainingPlanArrayViewModel()
        for _ in 0..<loopCount {
            guard let randomDay = vm.numberOfTrainingDaysArray.randomElement() else {return}
            vm.fetchPlanArray(name: randomDay)
            XCTAssertTrue(!vm.trainingPlan.isEmpty)
        }
        
        
    }
    
   
    
}
