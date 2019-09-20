//
//  StatementsTableViewCellTests.swift
//  bankAppTests
//
//  Created by Raphael Oliveira Chagas on 20/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import Foundation
import XCTest
@testable import bankApp

class StatementsTableViewCellTests: bankAppTests {
    
    let cell = Bundle.main.loadNibNamed("StatementsTableViewCell", owner: self, options: nil)?[0] as! StatementsTableViewCell
    
    func testSetRounded() {
        
        cell.setRounded()
        XCTAssertEqual(4, cell.holderView.layer.cornerRadius)
        XCTAssertEqual(4, cell.shadowView.layer.cornerRadius)
        XCTAssertEqual(2, cell.holderView.layer.shadowRadius)
        XCTAssertEqual(2, cell.shadowView.layer.shadowRadius)
    }
}
