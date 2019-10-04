//
//  ViewController.swift
//  bankApp
//
//  Created by Raphael Oliveira Chagas on 09/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import UIKit
import LoadingView

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var tryAgainLabel: UILabel!
    @IBOutlet weak var loginStack: UIStackView!
    
    let emptyText = "Usuário ou senha estão vazios."
    let wrongCredentials = "Usuário ou senha incorretos. Tente novamente."
    let errorOnTheServer = "Error ao processar. Tente novamente mais tarde."
    let strLiteralCPF = "[0-9]{3}\\.[0-9]{3}\\.[0-9]{3}\\/[0-9]{2}"
    let strLiteralEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+(\\.[A-Za-z]){0,64}"
    let strLiteralPass = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%&*_+=])[a-zA-Z]\\S{8,}$"
    let statementsVCIndentifier = "StatementsViewController"
    let storyboardName = "Main"
    let provider = ApiProvider()
    let loadingView = ROCLoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.passwordTextfield.delegate = self
        self.userTextfield.delegate = self
        self.loginButton.layer.cornerRadius = 4
        self.loginButton.layer.masksToBounds = true
        self.setAccessibility()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.enableDisableStack()
        self.passwordTextfield.text = nil
        self.navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
    }
    
    @IBAction func loginButtonClick(_ sender: UIButton) {
        self.tryLogin()
    }
    
    func setAccessibility() {
        self.accessibilityElements = [self.userTextfield, self.passwordTextfield, self.loginButton]
    }
    
    func tryLogin() {
        self.enableDisableStack(willDisable: true)
        
        var cpfOk = false
        var emailOk = false
        var passOk = false
        
        guard var inputUser = self.userTextfield.text?.lowercased(),
            let inputPass = self.passwordTextfield.text else {
                self.setErrorLabel(message: self.emptyText)
                self.enableDisableStack()
                return
        }
        
        if inputUser.isEmpty || inputPass.isEmpty {
            self.setErrorLabel(message: self.emptyText)
            self.enableDisableStack()
            return
        }
        
        let hasJustNumbers = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: inputUser
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "/", with: "")))
        
        if inputUser.count == 11 && hasJustNumbers {
            inputUser = ToolBox.shared.makeCPF(text: inputUser)
            cpfOk = NSPredicate.matchRegex(regex: self.strLiteralCPF, stringToCheck: inputUser)
        } else {
            emailOk = NSPredicate.matchRegex(regex: self.strLiteralEmail, stringToCheck: inputUser)
        }
        
        passOk = NSPredicate.matchRegex(regex: self.strLiteralPass, stringToCheck: inputPass)
        
        if cpfOk || emailOk && passOk {
            provider.postLogin(user: inputUser, password: inputPass, mocked: true) { (login) in
                if let login = login {
                    self.buildStatementsViewController(account: login)
                } else {
                    self.enableDisableStack()
                    self.setErrorLabel(message: self.errorOnTheServer)
                }
            }
        } else {
            self.enableDisableStack()
            self.setErrorLabel(message: self.wrongCredentials)
        }
    }
    
    func buildStatementsViewController(account: Login) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: self.statementsVCIndentifier) as? StatementsViewController else {
            self.setErrorLabel(message: self.errorOnTheServer)
            self.enableDisableStack()
            return
        }
        
        let userId = String(account.userAccount.userID)
        self.provider.getStatements(userId: userId, mocked: true) { (statements) in
            if statements != nil {
                let userAccount = account.userAccount
                vc.statements = statements
                vc.dateUser = userAccount
                self.loadingView.hide(parent: self.view)
                
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.enableDisableStack()
                self.setErrorLabel(message: self.errorOnTheServer)
            }
        }
    }
    
    func enableDisableStack(willDisable: Bool = false) {
        switch willDisable {
        case true:
            self.loadingView.show(parent: self.view)
            self.loginStack.isUserInteractionEnabled = false
            self.loginStack.alpha = 0.5
            self.loginButton.isEnabled = false
        case false:
            self.loadingView.hide(parent: self.view)
            self.loginStack.isUserInteractionEnabled = true
            self.loginStack.alpha = 1
            self.loginButton.isEnabled = true
            self.tryAgainLabel.isHidden = true
        }
    }
    
    func setErrorLabel(message: String) {
        self.tryAgainLabel.text = message
        self.tryAgainLabel.isHidden = false
        self.accessibilityElements = [self.userTextfield, self.passwordTextfield, self.tryAgainLabel, self.loginButton]
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var canReplace = true
        if textField == self.passwordTextfield && !self.tryAgainLabel.isHidden {
            if string == "" {
                self.passwordTextfield.text = nil
                canReplace = false
            }
            self.tryAgainLabel.isHidden = true
            self.setAccessibility()
        }
        if canReplace {
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .go {
            self.loginButtonClick(self.loginButton)
        }
        
        if textField.returnKeyType == .next {
            self.passwordTextfield.becomeFirstResponder()
        }
        return true
    }
}

