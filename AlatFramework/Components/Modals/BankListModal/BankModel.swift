//
//  BankModel.swift
//  AlatFramework
//
//  Created by Willi D Lax on 26/02/2023.
//

import Foundation

public struct BankModel{
    public var bankName: String
    public var bankCode: String
    
    public init(bankName: String, bankCode: String) {
        self.bankName = bankName
        self.bankCode = bankCode
    }
}

extension BankModel: Equatable{
    
}
