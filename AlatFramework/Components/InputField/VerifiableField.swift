//
//  VerifiableField.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 13/03/2023.
//
import UIKit

@IBDesignable public class VerifiableField: InputField {
    
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
    public var verify: () -> Void = {}
    public var verified: Bool = false {
        didSet {
            setup()
        }
    }
    public var isLoading: Bool = false {
        didSet {
            setLoadingIcon()
        }
    }
    public var hasLoaded: Bool = false
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
        isLoading = true
        verified = false
        setLoadingIcon()
        verify()
    }
    override func setup() {
        super.setup()
        topRightStack.isHidden = !(topIcon == UIImage()) && topText.isEmpty
        setSuccessIcon()
    }
    
    public func reset() {
        isLoading = false
        hasLoaded = false
        verified = false
    }
    
    func setLoadingIcon() {
        if isLoading {
            let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 12))
            let imageView = UIImageView(frame: CGRect(x: -10, y: -5, width: 24, height: 24))
            imageView.image = AlatAssets.loading.image
            imageView.tintColor = .alatRed
            imageView.contentMode = .scaleAspectFit
            animateImage(image: imageView)
            iconContainer.addSubview(imageView)
            textField.rightViewMode = UITextField.ViewMode.always
            textField.rightView = iconContainer
        } else {
            textField.rightViewMode = UITextField.ViewMode.never
            textField.rightView = nil
        }
    }
    func setSuccessIcon() {
        if verified {
            let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 12))
            let imageView = UIImageView(frame: CGRect(x: -10, y: -5, width: 24, height: 24))
            imageView.image = AlatAssets.checkIcon.image
            imageView.tintColor = .success
            imageView.contentMode = .scaleAspectFit
            iconContainer.addSubview(imageView)
            textField.rightViewMode = UITextField.ViewMode.always
            textField.rightView = iconContainer
            textField.layer.borderColor = UIColor.success.cgColor
        } else {
            textField.layer.borderColor = error.isEmpty ? UIColor.background.cgColor : UIColor.error.cgColor
            textField.rightViewMode = UITextField.ViewMode.never
            textField.rightView = nil
        }
    }
    public override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
        if !isLoading, !hasLoaded, !text.isEmpty {
            isLoading = true
            verified = false
            setLoadingIcon()
            verify()
        }
    }
    public override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
        hasLoaded = false
    }
    func animateImage(image: UIImageView) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0.0
        animation.toValue = CGFloat(Double.pi * 2.0)
        animation.duration = 0.4
        animation.repeatCount = .infinity
        image.layer.add(animation, forKey: "rotationAnimation")
    }
}

