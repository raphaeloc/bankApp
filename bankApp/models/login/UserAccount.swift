//
//  StatementList.swift
//  bankApp
//
//  Created by Raphael Oliveira Chagas on 10/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import Foundation

struct UserAccount: Codable {
    let userID: Int
    let name, bankAccount, agency: String
    let balance: Double
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case name, bankAccount, agency, balance
    }
}
