//
//  ScheduleViewModel_Tests.swift
//  TriSprint_Tests
//
//  Created by Nigel Karan on 09.12.21.
//

import XCTest
@testable import TriSprint
// Testing structure: Given, When, Then
class ScheduleViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func test_setImage_IsNotNil() {
        //Given
        let loopCount: Int = Int.random(in: 1..<50)
        let vm = ScheduleViewModel()
        var imageName = ""
        let session = ["RideRun","Swim","Ride","Run","SwimRide","SwimRun","Full"]
        let completed = [0,1]
        //When
        for _ in 0..<loopCount {
            guard let randomSession = session.randomElement() else { return }
            guard let randomCompleted = completed.randomElement() else { return }
            imageName = vm.setImageNames(session: randomSession, completed: Int16(randomCompleted))
        }
        //Then
        XCTAssertTrue(!imageName.isEmpty)
    }
    
    

}
