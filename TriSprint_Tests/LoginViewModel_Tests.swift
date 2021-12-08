//
//  LoginViewModel_Tests.swift
//  TriSprint_Tests
//
//  Created by Nigel Karan on 08.12.21.
//

import XCTest
@testable import TriSprint

//Naming Structure: "test_Variable/Function_ExpectedBehaviour"
// Testing structure: Given, When, Then

class LoginViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_isValidEmail_shouldBeTrue() {
        let emailString1 = "n@m.cm"
        let emailString2 = "nil@mdh.co.uk"
        let emailString3 = "nigel@msdh.com"
        let vm = LoginViewModel()
        let result1 = vm.isValidEmail(email: emailString1)
        let result2 = vm.isValidEmail(email: emailString2)
        let result3 = vm.isValidEmail(email: emailString3)
        XCTAssertTrue(result1)
        XCTAssertTrue(result2)
        XCTAssertTrue(result3)
    }
    func test_isValidEmail_shouldBeFalse() {
        let emailString1 = "nigel@msdh.m"
        let emailString2 = "@msdh.com"
        let emailString3 = "n@.com"
        let vm = LoginViewModel()
        let result1 = vm.isValidEmail(email: emailString1)
        let result2 = vm.isValidEmail(email: emailString2)
        let result3 = vm.isValidEmail(email: emailString3)
        XCTAssertFalse(result1)
        XCTAssertFalse(result2)
        XCTAssertFalse(result3)
    }
    
    func test_isValidPassword_shouldBeTrue() {
        let passwordStringMinimum = "hgtTegk8"
        let passwordStringMix = "11223333ghdnsdjsjasdkddkkUZUSBABSAMNjkhkjdksjfldsl678"
        let passwordString3 = "1ghfdkshfsdjfsdlsdfksdkfösdflsdäflsdäflllfödlösläsf,,,,ztzzr"
        let passwordString4 = "1FJDFLKGJDSKFLJSDLJFS??"
        let vm = LoginViewModel()
        let result1 = vm.isValidPassword(password: passwordStringMinimum)
        let result2 = vm.isValidPassword(password: passwordStringMix)
        let result3 = vm.isValidPassword(password: passwordString3)
        let result4 = vm.isValidPassword(password: passwordString4)
        XCTAssertTrue(result1)
        XCTAssertTrue(result2)
        XCTAssertTrue(result3)
        XCTAssertTrue(result4)
    }
    
    func test_isValidPassword_shouldBeFalse() {
        let passwordStringTooShort = "1we??"
        let passwordStringNoNumber = "we??zTu"
        let vm = LoginViewModel()
        let result1 = vm.isValidPassword(password: passwordStringTooShort)
        let result2 = vm.isValidPassword(password: passwordStringNoNumber)
        XCTAssertFalse(result1)
        XCTAssertFalse(result2)
        
    }
}
