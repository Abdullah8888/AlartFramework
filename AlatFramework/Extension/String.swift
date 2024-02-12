//
//  String.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 04/02/2023.
//

extension String {
    public static func toReadableDate(date: Date) -> String {
        let readableDateFormatter = DateFormatter()
        readableDateFormatter.dateFormat = "dd/MM/yyyy"
        readableDateFormatter.timeZone = TimeZone.current
        return readableDateFormatter.string(from: date)
    }
    
    public func toDecimal() -> Decimal? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal

        if let number = formatter.number(from: self) {
            let decimal = number.decimalValue
            return decimal
        }
        
        return nil
    }
    
    var containsSpecialCharacter: Bool {
          let regex = ".*[^A-Za-z0-9].*"
          let testString = NSPredicate(format:"SELF MATCHES %@", regex)
          return testString.evaluate(with: self)
       }
}
