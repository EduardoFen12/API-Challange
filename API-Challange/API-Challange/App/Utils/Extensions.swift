//
//  Extensions.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 26/08/25.
//
import Foundation
import SwiftUICore


extension String {
    func getMonth(isVoiceOver: Bool = false) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let localizedString = NSLocalizedString("DELIVERY BY MONTH", comment: "Delivery grouped by month")
        
        guard let date = inputFormatter.date(from: self) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MM"
        
        return isVoiceOver
            ? String(format: NSLocalizedString("delivered by month %@", comment: "VoiceOver accessibility label for delivery by month"), outputFormatter.string(from: date))
            : "\(localizedString), \(outputFormatter.string(from: date))"
    }
}

