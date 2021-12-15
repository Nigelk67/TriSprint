//
//  ActivityViewModel_Tests.swift
//  TriSprint_Tests
//
//  Created by Nigel Karan on 15.12.21.
//

import XCTest
@testable import TriSprint

class ActivityViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_formatDisplayDistanceInKm_shouldShowKmString() {
        let loopCount: Int = Int.random(in: 1..<20)
        var formattedKm = ""
        var trimmedString = ""
        let formatter = MeasurementFormatter()
        formatter.locale = Locale(identifier: "en_DE")
        for _ in 0..<loopCount {
            let kilometersRandom = Double.random(in: 20..<200)
            let kmDistance = Measurement(value: kilometersRandom, unit: UnitLength.kilometers)
            let kmString = formatter.string(from: kmDistance/1000)
            let trimmedString1 = kmString.replacingOccurrences(of: " ", with: "")
            trimmedString = trimmedString1.replacingOccurrences(of: ",", with: ".")
            formattedKm = FormatDisplay.distanceInKm(kmDistance)
        }
        XCTAssertEqual(trimmedString, formattedKm)
    }

}
