//
//  FxTransactionHistoryCard.swift
//  AlatFramework
//
//  Created by Bakare Waris on 13/07/2023.
//

import UIKit

public class FXTransactionHistoryCard: BaseXib {
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet var customView: CustomView!
    @IBOutlet weak private var statusLabel: MediumLabel!
    @IBOutlet weak private var date: LightLabel!
    @IBOutlet weak private var amount: MediumLabel!
    @IBOutlet weak private var subtitle: LightLabel!
    @IBOutlet weak private var title: MediumLabel!
    
    
    public var model: FXTransactionHistoryCardModel = FXTransactionHistoryCardModel() {
        didSet { setup() }
    }
    
    @IBInspectable var titleText: String = "" { didSet { model.title = titleText }}
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        statusView.layer.cornerRadius = 6
        customView.layer.cornerRadius = 8
        customView.layer.borderWidth = 1.0
        title.text = model.title
        subtitle.text = model.subtitle
        statusLabel.text = model.status
//        amount.text = "\(model.type == .credit ? "+" : "-")\(model.amount)"
        date.text = model.date
//        amount.textColor = model.type == .credit ? .success : .error
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapped)))
        if model.currency == "USD" {
            amount.text = "$ \(model.amount)"
        } else if model.currency == "EUR" {
            amount.text = "€ \(model.amount)"
        } else if model.currency == "GBP" {
            amount.text = "£ \(model.amount)"
        } else {
            amount.text = "₦ \(model.amount)"
        }
    }
    
    @objc func onTapped() {
        model.onTapped()
    }
}

public struct FXTransactionHistoryCardModel {
    public var title: String = ""
    public var subtitle: String = ""
    public var amount: String = ""
    public var date: String = ""
    public var type: FilterType = .submit
    public var currency: String = ""
    public var status: String = ""
    public var onTapped: () -> Void = {}
}

public enum FilterType: String {
    case submit = "SUBMITTED"
    case treated = "TREATED"
    case rejected = "REJECTED"
}
