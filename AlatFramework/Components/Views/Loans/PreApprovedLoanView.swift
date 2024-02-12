//
//  PreApprovedLoanView.swift
//  AlatFramework
//
//  Created by Bakare Waris on 30/08/2023.
//


import UIKit

@IBDesignable public class PreApprovedLoanView: BaseXib {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var loanIllustrationImage: UIImageView!
    @IBOutlet weak var forwardImage: UIImageView!
    
    
    
    public override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setup()
    }
    
 
    
    func setup() {
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.alatRed.cgColor
        isUserInteractionEnabled = true
        contentView.backgroundColor = .clear
    }
}
