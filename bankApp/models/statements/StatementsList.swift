//
//  StatementsList.swift
//  bankApp
//
//  Created by Raphael Oliveira Chagas on 13/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import Foundation

struct StatementList: Codable {
    let title: String
    let desc: String
    let date: String
    let value: Double
}
