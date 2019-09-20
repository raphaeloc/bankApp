//
//  ViewController.swift
//  bankApp
//
//  Created by Raphael Oliveira Chagas on 09/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var tryAgainLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.passwordTextfield.delegate = self
        self.userTextfield.delegate = self
        self.loginButton.layer.cornerRadius = 4
        self.loginButton.layer.masksToBounds = true
        self.setAccessibility()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.enableDisableStack()
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
        
        guard var inputUser = self.userTextfield.text?.lowercased() else {
            self.setErrorLabel(message: self.emptyText)
            self.enableDisableStack()
            return
        }
        guard let inputPass = self.passwordTextfield.text else {
            self.setErrorLabel(message: self.emptyText)
            self.enableDisableStack()
            return
        }
        
        if inputUser.isEmpty || inputPass.isEmpty {
            self.setErrorLabel(message: self.emptyText)
            self.enableDisableStack()
            return
        }
        
        let hasJustNumbers = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: inputUser))
        
        if inputUser.count == 11 && hasJustNumbers {
            inputUser = ToolBox.shared.makeCPF(text: inputUser)
            cpfOk = NSPredicate.matchRegex(regex: self.strLiteralCPF, stringToCheck: inputUser)
        } else {
            emailOk = NSPredicate.matchRegex(regex: self.strLiteralEmail, stringToCheck: inputUser)
        }
        
        passOk = NSPredicate.matchRegex(regex: self.strLiteralPass, stringToCheck: inputUser)
        
        
        if cpfOk || emailOk && passOk {
            provider.postLogin(user: inputUser, password: inputPass) { (login) in
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
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: self.statementsVCIndentifier) as? StatementsViewController else {
            self.setErrorLabel(message: self.errorOnTheServer)
            self.enableDisableStack()
            return
        }
        
        let userId = String(account.userAccount.userID)
        self.provider.getStatements(userId: userId) { (statements) in
            if statements != nil {
                let userAccount = account.userAccount
                vc.statements = statements
                vc.dateUser = userAccount
                self.activityIndicator.isHidden = true
                
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
            self.loginStack.isUserInteractionEnabled = false
            self.loginStack.alpha = 0.5
            self.loginButton.isEnabled = false
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        case false:
            self.loginStack.isUserInteractionEnabled = true
            self.loginStack.alpha = 1
            self.loginButton.isEnabled = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    func setErrorLabel(message: String) {
        self.tryAgainLabel.text = message
        self.tryAgainLabel.isHidden = false
        self.activityIndicator.isHidden = true
        self.accessibilityElements = [self.userTextfield, self.passwordTextfield, self.tryAgainLabel, self.loginButton]
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.tryAgainLabel.isHidden = true
        self.setAccessibility()
        return true
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

