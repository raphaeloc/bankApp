//
//  Statements.swift
//  bankApp
//
//  Created by Raphael Oliveira Chagas on 13/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import Foundation

struct Statements: Codable {
    let statementList: [StatementList]
    let error: Error
}
