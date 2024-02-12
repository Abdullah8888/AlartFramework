//
//  AccountNumberField.swift
//  AlatFramework
//
//  Created by Willi D Lax on 27/02/2023.
//

import UIKit

public class AccountNumberField: VerifiableField {
    
    public var onVerifyTapped: () -> Void = {}
    public var whileTyping: () -> Void = {}
    
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
        numberOfCharacters = 15
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    public override func layoutSubviews() {
        topRightStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(verifyTapped)))
    }
    
    @objc func verifyTapped(){
        onVerifyTapped()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        whileTyping()
    }
    
    public func enterVerificationMode(){
        isLoading = true
        verified = false
        setLoadingIcon()
        isUserInteractionEnabled = false
    }
    
    public override func reset() {
        super.reset()
        hasLoaded = true
        isUserInteractionEnabled = true
    }
    
    public override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
        hasLoaded = true
    }
}
