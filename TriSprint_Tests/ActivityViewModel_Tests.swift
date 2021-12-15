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
    
    func test_formatDisplayPacePerKm_shouldShowPaceString() {
        let loopCount: Int = Int.random(in: 1..<20)
        var formattedPace = ""
        var trimmedString = ""
        for _ in 0..<loopCount {
            let kmRandom = Double.random(in: 3..<100)
            let seconds = Double.random(in: 1000..<5000)
            let paceInKm = (seconds / 60) / kmRandom
            let paceString = String(format: "%.3f",paceInKm)
            trimmedString = paceString + " min/km"
            formattedPace = FormatDisplay.pacePerKmDble(distance: (kmRandom * 1000), seconds: seconds, outputUnit: UnitSpeed.minutesPerKilometer)
        }
        XCTAssertEqual(trimmedString, formattedPace)
    }
    
    func test_formatDisplayPacePerMile_shouldShowPaceString() {
        let loopCount: Int = Int.random(in: 1..<20)
        var formattedPace = ""
        var trimmedString = ""
        for _ in 0..<loopCount {
            let mtrsRandom = Double.random(in: 1000..<50000)
            let miles = mtrsRandom / 1609
            let seconds = Double.random(in: 1000..<5000)
            let paceInMi = (seconds / 60) / miles
            let paceString = String(format: "%.3f", paceInMi)
            trimmedString = paceString + " min/mi"
            formattedPace = FormatDisplay.pacePerMileDble(distance: mtrsRandom, seconds: seconds, outputUnit: UnitSpeed.minutesPerMile)
        }
        XCTAssertEqual(trimmedString, formattedPace)
    }
    
    func test_formatDisplayKmph_shouldShowKmSpeedString() {
        let loopCount: Int = Int.random(in: 1..<20)
        var formattedSpeed = ""
        var trimmedString = ""
        for _ in 0..<loopCount {
            let mtrsRandom = Double.random(in: 1000..<50000)
            let km = mtrsRandom / 1000
            let seconds = Double.random(in: 1000..<5000)
            let hour = seconds / 3600
            let speedInKm = km / hour
            let speedString = String(format: "%.3f", speedInKm)
            trimmedString = speedString + " km/hr"
            formattedSpeed = FormatDisplay.speedKmph(distance: mtrsRandom, seconds: seconds)
        }
        XCTAssertEqual(trimmedString, formattedSpeed)
    }

}
