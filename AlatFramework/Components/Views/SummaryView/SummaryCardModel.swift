//
//  SummaryCardModel.swift
//  AlatFramework
//
//  Created by Willi D Lax on 02/03/2023.
//

import Foundation

public struct SummaryCardModel{
    public var accountNumber: String
    public var accountName: String
    public var bank: BankModel
    
    public init(accountNumber: String, accountName: String, bank: BankModel) {
        self.accountNumber = accountNumber
        self.accountName = accountName
        self.bank = bank
    }
}

public struct MultipleSummaryModel {
    public var groupName: String?
    public var numOfRecipients: Int
    public var totalAmount: Double
    public var charges: Double
    
    public init(groupName: String? = nil, numOfRecipients: Int, totalAmount: Double, charges: Double) {
        self.groupName = groupName
        self.numOfRecipients = numOfRecipients
        self.totalAmount = totalAmount
        self.charges = charges
    }
}

public struct AirtimeDataSummaryModel {
    public var phoneNumber: String
    public var netWork: String
    public var amount: Double
    public var dataPlan: String
    public var planId: Int
    public var networkId: Int
    
    public init(phoneNumber: String, netWork: String, amount: Double, dataPlan: String, planId: Int, networkId: Int) {
        self.phoneNumber = phoneNumber
        self.netWork = netWork
        self.amount = amount
        self.dataPlan = dataPlan
        self.planId = planId
        self.networkId = networkId
    }
}

public struct BillModel {
    public var identifier: String
    public var userName: String
    public var amount: Double
    public var categoryId: Int
    public var categoryName: String
    public var billerId: Int
    public var billerName: String
    public var packageId: Int
    public var packageName: String
    public var charge: Double
    
    public init(identifier: String, userName: String, amount: Double, categoryId: Int, categoryName: String, billerId: Int, billerName: String, packageId: Int, packageName: String, charge: Double) {
        self.identifier = identifier
        self.userName = userName
        self.amount = amount
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.billerId = billerId
        self.billerName = billerName
        self.packageId = packageId
        self.packageName = packageName
        self.charge = charge
    }
}
