//
//  DataRow.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 27/03/2023.
//

import UIKit

@IBDesignable public class DataRow: BaseXib {
    @IBOutlet weak var firstLabel: RegularLabel!
    @IBOutlet weak var secondLabel: MediumLabel!
    @IBOutlet weak var seperator: UIView!
    
    
    @IBInspectable public var firstItem: String = "" {
        didSet {
            firstLabel.text = firstItem
        }
    }
    
    @IBInspectable public var secondItem: String = "" {
        didSet {
            secondLabel.text = secondItem
        }
    }
    
    @IBInspectable public var showSeperator: Bool = true {
        didSet {
            seperator.isHidden = !showSeperator
        }
    }
    
    @IBInspectable public var isTotal: Bool = false {
        didSet {
            if isTotal {
                firstLabel.font = Fonts.getFont(name: .Medium, 14)
                secondLabel.font = Fonts.getFont(name: .SemiBold, 14)
            } else {
                firstLabel.font = Fonts.getFont(name: .Regular, 14)
                secondLabel.font = Fonts.getFont(name: .Medium, 14)
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
