//
//  PastLoanCellView.swift
//  AlatFramework
//
//  Created by Bakare Waris on 22/09/2023.
//

import UIKit


public class PastLoanCellView: BaseXib {
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var loanAmountLabel: BoldLabel!
    @IBOutlet weak var dateCompletedLabel: BoldLabel!
    @IBOutlet weak var smeLoanLabel: RegularLabel!
    
    
    public var model: PastLoanModel = PastLoanModel() {
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
        dateCompletedLabel.text = model.date
        loanAmountLabel.text = "₦ \(model.maxAmount.toAmount() ?? "")"
        smeLoanLabel.textColor = UIColor(red: 0.663, green: 0.031, blue: 0.212, alpha: 1)
    }
    
   
}

public struct PastLoanModel {
    public var maxAmount: Double = 0
    public var date: String = ""
}


