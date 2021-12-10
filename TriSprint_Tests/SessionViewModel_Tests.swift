//
//  SessionViewModel_Tests.swift
//  TriSprint_Tests
//
//  Created by Nigel Karan on 10.12.21.
//

import XCTest
@testable import TriSprint


class SessionViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_eachSecondFunc_increasedBy1IsTrue() {
        let vm = SessionViewModel()
        for _ in 0..<10 {
            vm.eachSecond()
        }
        XCTAssertNotNil(vm.secs)
        XCTAssertEqual(vm.secs, 10)
    }
    
    func test_formatDisplayDistance_shouldShowMiles() {
        let loopCount: Int = Int.random(in: 1..<50)
        let formatter = MeasurementFormatter()
        formatter.locale = Locale(identifier: "en_US")
        var formattedDistanceInMi = "milesbeforeformatting"
        var trimmedString = "miles"
        
        for _ in 0..<loopCount {
            let kilometersRandom = Double.random(in: 20..<200)
            let kmDistance = Measurement(value: kilometersRandom, unit: UnitLength.kilometers)
            let miString = formatter.string(from: kmDistance)
            trimmedString = miString.replacingOccurrences(of: " ", with: "")
            formattedDistanceInMi = FormatDisplay.distance(kmDistance)
        }
        XCTAssertEqual(formattedDistanceInMi, trimmedString)
        
    }
  
    

}
