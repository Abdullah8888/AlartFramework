//
//  PrimaryBorderedButton.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 08/02/2023.
//

import UIKit

@IBDesignable public class PrimaryBorderedButton: UIButton {
    
    @IBInspectable public var identifier: String = "" { didSet {
        self.accessibilityIdentifier = identifier
    } }
    
    public override func awakeFromNib() {
        setUp()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp() {
        backgroundColor = .clear
        layer.cornerRadius = 8.0
        setTitleColor(.alatRed, for: .normal)
        layer.borderColor = UIColor.alatRed.cgColor
        layer.borderWidth = 1.0
        clipsToBounds = true
        titleLabel?.font = Fonts.getFont(name: .SemiBold, 14)
    }
}
