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
    
    func postLogin(user: String, password: String, success: @escaping (Login?) -> Void) {
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
    
    func getStatements(userId: String, success: @escaping (Statements?) -> Void) {
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
