//
//  PlainButton.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 05/02/2023.
//

import UIKit

@IBDesignable public class PlainButton: UIButton {
    
    @IBInspectable public var identifier: String = "" { didSet {
        self.accessibilityIdentifier = identifier
    } }
    
    @IBInspectable var color: UIColor = .alatRed {
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
        backgroundColor = .clear
        setTitleColor(color, for: .normal)
        setTitleColor(.background, for: .disabled)
        clipsToBounds = true
        titleLabel?.font = Fonts.getFont(name: .SemiBold, 14)
    }
}

