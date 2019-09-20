//
//  NSPredicate+Utils.swift
//  bankApp
//
//  Created by Raphael Oliveira Chagas on 16/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import Foundation

extension NSPredicate {
    static func matchRegex(regex: String, stringToCheck: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: stringToCheck)
    }
}
