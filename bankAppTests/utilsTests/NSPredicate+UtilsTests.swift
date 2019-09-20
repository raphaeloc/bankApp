//
//  NSPredicate+UtilsTests.swift
//  bankAppTests
//
//  Created by Raphael Oliveira Chagas on 20/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import Foundation
import XCTest
@testable import bankApp

class NSPredicateUtilsTests {
    
    let strLiteralCPF = "[0-9]{3}\\.[0-9]{3}\\.[0-9]{3}\\/[0-9]{2}"
    let strLiteralEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+(\\.[A-Za-z]){0,64}"
    let strLiteralPass = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%&*_+=])[a-zA-Z]\\S{8,}$"
    
    func testMatchRegexCPF() {
        let cpf = "484.057.158/94"
        let assert = NSPredicate.matchRegex(regex: cpf, stringToCheck: strLiteralCPF)
        XCTAssertTrue(assert)
    }
    
    func testMatchRegexEmail() {
        let email = "teste@gmail.com"
        let assert = NSPredicate.matchRegex(regex: email, stringToCheck: strLiteralEmail)
        XCTAssertTrue(assert)
    }
    
    func testMatchRegexPass() {
        let pass = "Teste@12345"
        let assert = NSPredicate.matchRegex(regex: pass, stringToCheck: strLiteralPass)
        XCTAssertTrue(assert)
    }
}
