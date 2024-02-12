//
//  FxTransactionHistoryView.swift
//  AlatFramework
//
//  Created by Bakare Waris on 17/07/2023.
//

import Foundation

import UIKit

public class FxTransactionHistoryView: BaseXib {
    
   
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var refIdLabel: MediumLabel!
    @IBOutlet weak var dateAndAmountLabel: LightLabel!

    
    public var model: FxTransactionHistoryModel = FxTransactionHistoryModel() {
        didSet { setup() }
    }
    
    public override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super .init(coder: coder)
        setup()
    }
    
    
    public func setup(){
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.background.withAlphaComponent(0.5).cgColor
        contentView.backgroundColor = .greyLight
        
        refIdLabel.text = model.refId
        if model.currency == "USD" {
            dateAndAmountLabel.text = "\(model.date) | $\(model.amount)"
        } else if model.currency == "EUR" {
            dateAndAmountLabel.text = "\(model.date) | €\(model.amount)"
        } else if model.currency == "GBP" {
            dateAndAmountLabel.text = "\(model.date) | £\(model.amount)"
        } else {
            dateAndAmountLabel.text = "\(model.date) | ₦\(model.amount)"
        }

    }

}

public struct FxTransactionHistoryModel{
    public var refId: String = ""
    public var date: String = ""
    public var amount: String = ""
    public var currency: String = ""
}


