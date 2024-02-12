//
//  Button.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 02/02/2023.
//
import UIKit

@IBDesignable public class PrimaryButton: UIButton {
    
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
        backgroundColor = .alatRed
        layer.cornerRadius = 8.0
        setTitleColor(.white, for: .normal)
        layer.borderColor = UIColor.alatRed.cgColor
        layer.borderWidth = 1.0
        setBackgroundColor(.alatRed.lighter(by: 15) ?? UIColor(), for: .disabled)
        clipsToBounds = true
        titleLabel?.font = Fonts.getFont(name: .SemiBold, 14)
    }
}
