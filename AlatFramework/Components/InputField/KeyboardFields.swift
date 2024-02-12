//
//  NumberField.swift
//  AlatFramework
//
//  Created by Willi D Lax on 06/03/2023.
//

import UIKit

public class NumberField: InputField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func setup() {
        super.setup()
        textField.keyboardType = .numberPad
    }
}

public class EmailField: InputField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func setup() {
        super.setup()
        textField.keyboardType = .emailAddress
    }
}

public class PhoneField: InputField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func setup() {
        super.setup()
        textField.keyboardType = .phonePad
    }
}
