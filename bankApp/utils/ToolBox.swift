//
//  ToolBox.swift
//  bankApp
//
//  Created by Raphael Oliveira Chagas on 20/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import Foundation

class ToolBox {
    
    static let shared = ToolBox()
    
    func makeCPF(text: String) -> String {
        var newText = text
        newText.insert(".", at: String.Index(encodedOffset: 3))
        newText.insert(".", at: String.Index(encodedOffset: 7))
        newText.insert("/", at: String.Index(encodedOffset: 11))
        return newText
    }
    
    func makeBRFormat(valor: Double) -> String {
        let currencyFomatter = NumberFormatter()
        currencyFomatter.usesGroupingSeparator = true
        currencyFomatter.numberStyle = .decimal
        currencyFomatter.minimumFractionDigits = 2
        currencyFomatter.maximumFractionDigits = 2
        currencyFomatter.decimalSeparator = ","
        currencyFomatter.groupingSeparator = "."
        currencyFomatter.currencyCode = "BRL"
        guard let fomattedString = currencyFomatter.string(for: valor) else { return "R$ 0,00" }
        
        return "R$ \(fomattedString)"
    }
}
