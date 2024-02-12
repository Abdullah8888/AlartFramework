//
//  PreApprovedLoanCellView.swift
//  AlatFramework
//
//  Created by Bakare Waris on 06/09/2023.
//

import UIKit


public class PreApprovedLoanCellView: BaseXib {
    
    @IBOutlet weak  var contentView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak public var loanAmountLabel: SemiLabel!
    @IBOutlet weak public var tenorLabel: SemiLabel!
    
    @IBOutlet weak var preapprovedLabel: RegularLabel!
    
    public var model: PrequalifiedLoansModel = PrequalifiedLoansModel() {
        didSet { setup() }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    func setup() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.background.cgColor
        statusView.layer.cornerRadius = 8
        statusView.backgroundColor = .alatRed.withAlphaComponent(0.10)
        
        tenorLabel.text = "\(model.tenor) MONTHS"
        loanAmountLabel.text = "₦ \(model.maxAmount.toAmount() ?? "")"
        preapprovedLabel.textColor =  UIColor(red: 0.663, green: 0.031, blue: 0.212, alpha: 1)
    }
    
   
}

public struct PrequalifiedLoansModel{
    public var maxAmount: Double = 0
    public var minAmount: Double = 0
    public var intrRatePerMonth: Int = 0
    public var tenor: Int = 0
}

