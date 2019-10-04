//
//  ToolBoxTests.swift
//  bankAppTests
//
//  Created by Raphael Oliveira Chagas on 20/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import Foundation
import XCTest
@testable import bankApp

class ToolBoxTests {
    
    func testMakeCPF() {
        let expected = "000.000.000/00"
        let cpf = ToolBox.shared.makeCPF(text: "00000000000")
        XCTAssertEqual(expected, cpf)
    }
    
    func testMakeBRFormat() {
        let expected = "R$ 0,00"
        let value = ToolBox.shared.makeBRFormat(value: 0.0)
        XCTAssertEqual(expected, value)
    }
    
    func testFormatDate() {
        let teste = ToolBox.shared.formatDate(dateStr: "2018/10/02")
    }
}
