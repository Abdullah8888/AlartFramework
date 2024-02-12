//
//  PendingTransactionView.swift
//  AlatFramework
//
//  Created by Willi D Lax on 21/03/2023.
//

import UIKit

@IBDesignable public class PendingTransactionView: BaseXib {
    let nibName = "PendingTransactionView"
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var descriptionAmountLbl: UILabel!
    @IBOutlet weak var initiatorLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var forwardIcon: UIImageView!
    @IBOutlet weak var titleLabel: RegularLabel!
    @IBOutlet weak var transactionStack: UIStackView!
    @IBOutlet weak var toggle: UISwitch!
    
    @IBInspectable public var title: String {
        set{
            setupAsCardWithToggle(title: newValue)
        } get {
            return self.title
        }
    }
        
    public var toggleOn: Bool {
        set{
            toggle.isOn = newValue
        }
        get{
            return toggle.isOn
        }
    }
    
    public override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setup()
    }
    
    override func getNibName() -> String? {
        return nibName
    }
    
    func setup() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.background.cgColor
        contentView.layer.cornerRadius = 8
    }
    
    public func setupAsSimpleCard(title: String) {
        setup()
        titleLabel.isHidden = false
        titleLabel.text = title
        transactionStack.isHidden = true
    }
    
    public func setupAsCardWithToggle(title: String) {
        setup()
        toggle.isHidden = false
        forwardIcon.isHidden = true
        titleLabel.isHidden = false
        titleLabel.text = title
        transactionStack.isHidden = true
    }
    
    public func setValues(model: PendingTransactionModel, num: Int){
        descriptionAmountLbl.text = String(num) + ". " + model.type      //" - ₦" + model.amount.toAmount()!
        initiatorLbl.text = model.initiator
        dateLbl.text = "Date: " + model.date
    }
}

public struct PendingTransactionModel {
    //public var amount: Double
    public var initiator: String
    public var date: String
    public var type: String
    
    public init(initiator: String, date: String, type: String) {
        //self.amount = amount
        self.initiator = initiator
        self.date = date
        self.type = type
    }
}
