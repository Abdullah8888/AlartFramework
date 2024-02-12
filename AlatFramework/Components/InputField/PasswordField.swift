//
//  PasswordField.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 03/02/2023.
//

import UIKit

@IBDesignable public class PasswordField: InputField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func setup() {
        super.setup()
        setPasswordImage(for: true)
    }
    
    func setPasswordImage(for state: Bool) {
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 12))
        let imageView = UIImageView(frame: CGRect(x: -10, y: -5, width: 24, height: 24))
        imageView.tintColor = .alatRed
        imageView.image = state ? AlatAssets.eyeOn.image : AlatAssets.eyeOff.image
        imageView.tintColor = .background
        imageView.contentMode = .scaleAspectFit
        iconContainer.addSubview(imageView)
        textField.rightViewMode = UITextField.ViewMode.always
        textField.rightView = iconContainer
        textField.isSecureTextEntry = state
        textField.rightView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleEyeTap(_:))))
    }
    
    @objc func handleEyeTap(_ sender: UITapGestureRecognizer) {
        setPasswordImage(for: textField.isSecureTextEntry ? false : true)
    }
}
