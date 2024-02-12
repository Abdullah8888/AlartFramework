//
//  SecurityView.swift
//  AlatFramework
//
//  Created by Bakare Waris on 07/04/2023.
//

import UIKit

class SecurityView: BaseXib {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    @IBOutlet weak var thirdLbl: UILabel!
    
    public var model = SecurityViewModel() {
        didSet {
            setup()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    func setup() {
        titleLabel.text = model.details
        secondLbl.text = model.secondDetails
        thirdLbl.text = model.thirdDetails
    }
    
    func getHeight() -> CGFloat {
        contentView.bounds.height
    }
}

struct SecurityViewModel {
    var details: String = ""
    var secondDetails: String = ""
    var thirdDetails: String = ""
}


