//
//  Decimal.swift
//  AlatFramework
//
//  Created by Willi D Lax on 01/03/2023.
//

import Foundation

extension Double {
    public func toAmountWithCurrency(currencyCode: String = "NGN") -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        if let formattedAmount = formatter.string(from: NSNumber(value: self)) {
            return formattedAmount
        }
        return nil
    }
    
    public func toAmount() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.currencySymbol = ""
        if let formattedAmount = formatter.string(from: NSNumber(value: self)) {
            return formattedAmount
        }
        return nil
    }
}
