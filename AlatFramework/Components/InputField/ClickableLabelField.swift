//
//  ClickableLabelField.swift
//  AlatFramework
//
//  Created by Bakare Waris on 23/03/2023.
//

import UIKit

@IBDesignable public class ClickableLabelField: InputField {
    
    @IBInspectable var topIcon: UIImage = UIImage() {
        didSet {
            topRightIcon.image = topIcon
        }
    }
    @IBInspectable var topText: String = "" {
        didSet {
            topRightLabel.text = topText
        }
    }
//    public var verify: () -> Void = {}
//    public var verified: Bool = false {
//        didSet {
//            setup()
//        }
//    }
//    public var isLoading: Bool = false {
//        didSet {
//            setLoadingIcon()
//        }
//    }
//    public var hasLoaded: Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override func layoutSubviews() {
        topRightStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topBtnTapped(_:))))
    }
    @objc func topBtnTapped(_ sender: UITapGestureRecognizer) {
//        isLoading = true
//        verified = false
//        setLoadingIcon()
//        verify()
    }
    override func setup() {
        super.setup()
        topRightStack.isHidden = false
        topRightLabel.isUserInteractionEnabled = true
        topRightStack.isUserInteractionEnabled = true
        setPasswordImage(for: true)
//        setSuccessIcon()
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

