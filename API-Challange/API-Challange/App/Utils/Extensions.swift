//
//  Extensions.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 26/08/25.
//
import Foundation

extension String {
    func getMonth(isVoiceOver: Bool = false) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = inputFormatter.date(from: self) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MM"
        
        return isVoiceOver ? "delivered by month \(outputFormatter.string(from: date))" : "DELIVERY BY MONTH, \(outputFormatter.string(from: date))"
    }
}
