//
//  DebitCardModel.swift
//  AlatFramework
//
//  Created by Willi D Lax on 15/08/2023.
//

import Foundation

public struct DebitCardModel {
    public var cardName: String
    public var cardPan: String
    public var expDate: String
    
    public init(cardName: String, cardPan: String, expDate: String) {
        self.cardName = cardName
        self.cardPan = cardPan
        self.expDate = expDate
    }
}
