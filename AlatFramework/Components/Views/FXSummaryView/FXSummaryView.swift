//
//  FXSummaryView.swift
//  AlatFramework
//
//  Created by Bakare Waris on 03/07/2023.
//

import UIKit

public class FXSummaryView: BaseXib {
    
  
    @IBOutlet weak public var contentView: UIView!
    @IBOutlet weak public var amountValue: BoldLabel!
    @IBOutlet weak public var offShoreValue: BoldLabel!
    @IBOutlet weak public var comissionValue: BoldLabel!
    @IBOutlet weak public var vatValue: BoldLabel!
    @IBOutlet weak public var swiftValue: BoldLabel!
    @IBOutlet weak public var totalAmountValue: BoldLabel!
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        contentView.layer.cornerRadius = 8
    }
    
    
    
}



