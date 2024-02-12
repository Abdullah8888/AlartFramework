//
//  AccountModel.swift
//  AlatFramework
//
//  Created by Willi D Lax on 20/02/2023.
//

import Foundation

public struct AccountModel: Codable, Hashable {
    public var accountId, currency: String
    public var balance: Double
    public var accountName, accountNo: String
    public var accountDescription: String
    public var accountStatus: String
    public var numberOfUsers: Int?
    public var schemeCode: String
    
    public init(accountId: String, currency: String, balance: Double, accountName: String, accountNo: String, accountDescription: String, accountStatus: String, numberOfUsers: Int? = 0, schemeCode: String = "") {
        self.accountId = accountId
        self.currency = currency
        self.balance = balance
        self.accountName = accountName
        self.accountNo = accountNo
        self.accountDescription = accountDescription
        self.accountStatus = accountStatus
        self.numberOfUsers = numberOfUsers
        self.schemeCode = schemeCode
    }
}

extension AccountModel: Equatable{
    
}
