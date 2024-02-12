//
//  WhiteButton.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 17/02/2023.
//

import UIKit

@IBDesignable public class WhiteButton: UIButton {
    
    @IBInspectable public var identifier: String = "" { didSet {
        self.accessibilityIdentifier = identifier
    } }
    
    @IBInspectable var isSmall: Bool = false {
        didSet {
            setUp()
        }
    }
    
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
    
    func setUp(_ isPrimary: Bool = true) {
        layer.cornerRadius = isSmall ? 4.0 : 8.0
        setTitleColor(.alatRed, for: .normal)
        backgroundColor = .white
        clipsToBounds = true
        titleLabel?.font = isSmall ? Fonts.getFont(name: .Medium, 10) : Fonts.getFont(name: .SemiBold, 14)
    }
}
