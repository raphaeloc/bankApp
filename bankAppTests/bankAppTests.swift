//
//  bankAppTests.swift
//  bankAppTests
//
//  Created by Raphael Oliveira Chagas on 20/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import XCTest
import UIKit
@testable import bankApp

class bankAppTests: XCTestCase {

    var loginVC: LoginViewController?
    var statementsVC: StatementsViewController?
    var navigationController: MockViewController?
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        statementsVC = storyboard.instantiateViewController(withIdentifier: "StatementsViewController") as? StatementsViewController
        loginVC?.loadView()
        statementsVC?.loadView()
        navigationController = MockViewController(rootViewController: loginVC!)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
