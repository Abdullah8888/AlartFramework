//
//  Decimal.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 16/03/2023.
//

import Foundation

extension Decimal {
    public func toAmountWithCurrency(currencyCode: String = "NGN") -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        formatter.currencySymbol = nil
        if let formattedAmount = formatter.string(from: NSDecimalNumber(decimal: self)) {
            return formattedAmount
        }
        return nil
    }
    
    public func toAmount() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.currencySymbol = ""
        if let formattedAmount = formatter.string(from: NSDecimalNumber(decimal: self)) {
            return formattedAmount
        }
        return nil
    }
}
