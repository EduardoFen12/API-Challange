//
//  numberFormatterSingleton.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//
import Foundation

class NumberFormatterManager{
    
    static let shared = NumberFormatterManager()
    
    private let formatter: NumberFormatter
    
    private init() {
        formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
    }
    
    func doubleToString(_ value: Double) -> String {
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
}
