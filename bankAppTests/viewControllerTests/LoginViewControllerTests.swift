//
//  LoginViewControllerTests.swift
//  bankAppTests
//
//  Created by Raphael Oliveira Chagas on 20/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import Foundation
import XCTest
@testable import bankApp

class LoginViewControllerTests: bankAppTests {
    
    func testViewDidLoad() {
        self.loginVC?.viewDidLoad()
        XCTAssertEqual(4, self.loginVC?.loginButton.layer.cornerRadius)
        XCTAssertTrue(self.loginVC?.loginButton.layer.masksToBounds ?? false)
    }
    
    func testViewDidAppear() {
        self.loginVC?.viewDidAppear(true)
        XCTAssertTrue(self.loginVC?.loginStack.isUserInteractionEnabled ?? false)
        XCTAssertEqual(1, self.loginVC?.loginStack.alpha)
        XCTAssertTrue(self.loginVC?.loginButton.isEnabled ?? false)
    }
    
    func testTryLoginWithNilUserAndPass() {
        self.loginVC?.userTextfield?.text = nil
        self.loginVC?.passwordTextfield?.text = nil
        self.loginVC?.tryLogin()
        XCTAssertEqual(self.loginVC?.emptyText, self.loginVC?.tryAgainLabel.text)
        self.loginVC?.loadView()
    }
    
    func testTryLoginWithEmptyUser() {
        self.loginVC?.userTextfield.text = ""
        self.loginVC?.tryLogin()
        XCTAssertEqual(self.loginVC?.emptyText, self.loginVC?.tryAgainLabel.text)
    }
    
    func testTryLoginWithEmptyPass() {
        self.loginVC?.passwordTextfield.text = ""
        self.loginVC?.tryLogin()
        XCTAssertEqual(self.loginVC?.emptyText, self.loginVC?.tryAgainLabel.text)
    }
    
    func testeTryLoginWithWrongCPF() {
        self.loginVC?.passwordTextfield.text = "Teste@12345"
        self.loginVC?.userTextfield.text = "000000000000"
        self.loginVC?.tryLogin()
        XCTAssertEqual(self.loginVC?.wrongCredentials, self.loginVC?.tryAgainLabel.text)
    }
    
    func testeTryLoginWithWrongEmail() {
        self.loginVC?.passwordTextfield.text = "Teste@12345"
        self.loginVC?.userTextfield.text = "teste.com"
        self.loginVC?.tryLogin()
        XCTAssertEqual(self.loginVC?.wrongCredentials, self.loginVC?.tryAgainLabel.text)
    }
    
    func testeTryLoginWithWrongPass() {
        self.loginVC?.userTextfield.text = "teste@teste.com"
        self.loginVC?.passwordTextfield.text = "teste123"
        self.loginVC?.tryLogin()
        XCTAssertEqual(self.loginVC?.wrongCredentials, self.loginVC?.tryAgainLabel.text)
    }
    
    func testEnableDisableStack() {
        self.loginVC?.enableDisableStack()
        XCTAssertTrue(self.loginVC?.loginStack.isUserInteractionEnabled ?? false)
        XCTAssertEqual(1, self.loginVC?.loginStack.alpha)
        XCTAssertTrue(self.loginVC?.loginButton.isEnabled ?? false)
    }
    
    func testEnableDisableStackWillEnable() {
        self.loginVC?.enableDisableStack(willDisable: true)
        XCTAssertFalse(self.loginVC?.loginStack.isUserInteractionEnabled ?? false)
        XCTAssertEqual(0.5, self.loginVC?.loginStack.alpha)
        XCTAssertFalse(self.loginVC?.loginButton.isEnabled ?? false)
    }
    
    func testSetErrorLabel() {
        self.loginVC?.setErrorLabel(message: "teste")
        XCTAssertEqual("teste", self.loginVC?.tryAgainLabel.text)
    }
}
