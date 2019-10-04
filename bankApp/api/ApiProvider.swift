//
//  ApiProvider.swift
//  bankApp
//
//  Created by Raphael Oliveira Chagas on 10/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import UIKit
import Alamofire

class ApiProvider {
    
    func postLogin(user: String, password: String, mocked: Bool = false, success: @escaping (Login?) -> Void) {
        if mocked {
            guard let path = Bundle.main.path(forResource: "UserData", ofType: "json") else { return }
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let userData = try? JSONDecoder().decode(Login.self, from: data ?? Data())
            success(userData)
        } else {
            let url =  "https://bank-app-test.herokuapp.com/api/login/"
            let paramenters: Parameters = ["user": user, "password": password]
            
            Alamofire.request(url, method: .post, parameters: paramenters).responseData { (response) in
                switch response.result {
                    
                case .success(_):
                    guard let welcome = try? JSONDecoder().decode(Login.self, from: response.data ?? Data()) else { return }
                    dump(welcome)
                    success(welcome)
                case .failure(_):
                    success(nil)
                }
            }
        }
    }
    
    func getStatements(userId: String, mocked: Bool = false, success: @escaping (Statements?) -> Void) {
        if mocked {
            guard let path = Bundle.main.path(forResource: "Statements", ofType: "json") else { return }
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let statements = try? JSONDecoder().decode(Statements.self, from: data ?? Data())
            success(statements)
        } else {
            let url = "https://bank-app-test.herokuapp.com/api/statements/\(userId)"
            
            Alamofire.request(url).responseData { (response) in
                switch response.result {
                    
                case .success(_):
                    guard let statements = try? JSONDecoder().decode(Statements.self, from: response.data ?? Data()) else { return }
                    dump(statements)
                    success(statements)
                    
                case .failure(_):
                    success(nil)
                }
            }
        }
    }
}
