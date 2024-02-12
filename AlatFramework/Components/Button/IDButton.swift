//
//  IDButton.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 09/05/2023.
//

import UIKit

@IBDesignable public class IDButton: UIButton {
    
    @IBInspectable public var identifier: String = "" { didSet {
        self.accessibilityIdentifier = identifier
    } }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
