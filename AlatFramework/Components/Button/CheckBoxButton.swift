//
//  CheckBoxButton.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 04/02/2023.
//

import UIKit
@IBDesignable public class CheckboxButton: UIButton {

    @IBInspectable public var identifier: String = "" { didSet {
        self.accessibilityIdentifier = identifier
    } }
    
   @IBInspectable public var isChecked: Bool = false {
        didSet {
            if isChecked {
                self.setImage(AlatAssets.checkIcon.image, for: .normal)
            } else {
                self.setImage(AlatAssets.uncheckIcon.image, for: .normal)
            }
        }
    }
    
    @IBInspectable var tint: UIColor = .alatRed {
        didSet {
            setup()
        }
    }
    
    @IBInspectable public var titleText: String = "" {
        didSet {
            setup()
        }
    }
    
    public var stateChanged: (Bool) -> Void = { _ in }

    public override func awakeFromNib() {
        setup()
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
        setTitle("", for: .normal)
        if titleText != "" {
            setTitle("  " + titleText, for: .normal)
            setTitleColor(.textGrey, for: .normal)
            titleLabel?.font = .systemFont(ofSize: 12)
        }
        backgroundColor = .clear
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
        self.setImage(AlatAssets.uncheckIcon.image, for: .normal)
        imageView?.tintColor = tint
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
            stateChanged(isChecked)
        }
    }
}
