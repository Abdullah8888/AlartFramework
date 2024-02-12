//
//  SoftTokenModal.swift
//  AlatFramework
//
//  Created by Bakare Waris on 21/09/2023.
//

import UIKit

public protocol TokenPassingDelegate: AnyObject{
    func passData(pin: String, token: String)
}

public class SoftTokenModal: BaseXib {
    let nibName = "SoftTokenModal"
    
    var tokenDelegate: TokenPassingDelegate?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tokenField: PasswordField!
    @IBOutlet weak var pinField: PinField!
    @IBOutlet weak var cancelIcon: UIImageView!
    
    
    var hasPin: Bool = false
    var shouldUseToken: Bool = false
    var hasSoftToken: Bool = false
    var isSoftToken: Bool = false
    
    var softokenavailable: Bool = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func getNibName() -> String? {
        return nibName
    }
    
    func setup(){
        let cancelTapped = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        cancelIcon.addGestureRecognizer(cancelTapped)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleDismissal))
        swipeDown.direction = .down
        addGestureRecognizer(swipeDown)
    }
    
    @objc func handleDismissal() {
        dismiss()
    }
    
    
    @IBAction func proceedTapped(_ sender: Any) {
        if validateFields() {
            tokenDelegate?.passData(pin: pinField.text, token: tokenField.text)
        }
        
    }
    
//    func setupFieldsAndViews(){
//        print("pass pin is \(hasPin)")
//        print("pass softken is \(softokenavailable)")
//        if hasPin == true {
//            pinField.isHidden = false
//            pinField.numberOfCharacters = 4
//            pinField.titleText = "Enter Pin"
//            tokenField.isHidden = true
//        } else if softokenavailable == true {
//            tokenField.isHidden = false
//            pinField.isHidden = true
//            tokenField.titleText = "Enter Soft Token"
//            tokenField.numberOfCharacters = 6
//            tokenField.keyboardType = .numberPad
//        } else {
//            pinField.isHidden = false
//            tokenField.isHidden = false
//            tokenField.numberOfCharacters = 6
//            tokenField.keyboardType = .numberPad
//            tokenField.titleText = "Enter hard token"
//            pinField.titleText = "Enter hard token pin"
//        }
//    }
    
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            self?.frame.origin.y = Helpers.screenHeight
            self?.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.superview?.removeFromSuperview()
        })
    }
    
    public static func startTokenSelection(on view: UIView, delegate del: TokenPassingDelegate, softTokenAvailable: Bool, hasPin: Bool) {

        let backDrop = UIView(frame: Helpers.screen)
        backDrop.backgroundColor = .gray.withAlphaComponent(0.5)
        
       

        let modal = SoftTokenModal()
        modal.tokenDelegate = del
        modal.softokenavailable = softTokenAvailable
        modal.hasPin = hasPin
        
        if hasPin == true {
            modal.pinField.isHidden = false
            modal.pinField.numberOfCharacters = 4
            modal.pinField.titleText = "Enter Pin"
            modal.tokenField.isHidden = true
        } else if softTokenAvailable == true {
            modal.tokenField.isHidden = false
            modal.pinField.isHidden = true
            modal.tokenField.titleText = "Enter Soft Token"
            modal.tokenField.numberOfCharacters = 6
            modal.tokenField.keyboardType = .numberPad
        } else {
            modal.pinField.isHidden = false
            modal.tokenField.isHidden = false
            modal.tokenField.numberOfCharacters = 6
            modal.tokenField.keyboardType = .numberPad
            modal.tokenField.titleText = "Enter hard token"
            modal.pinField.titleText = "Enter hard token pin"
        }
    
        modal.layer.cornerRadius = 20
        modal.backgroundColor = .white
        modal.clipsToBounds = true
        backDrop.addSubview(modal)
        view.addSubview(backDrop)
        modal.frame = CGRect(x: 0, y: Helpers.screenHeight, width: Helpers.screenWidth, height: 500)
        view.layoutIfNeeded()

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            modal.frame.origin.y = Helpers.screenHeight  - 500 + modal.layer.cornerRadius
            view.layoutIfNeeded()
        }, completion: nil)

    }
    
    func clearFieldErrors(fields: [InputField]){
        for field in fields {
            field.error = ""
        }
    }
    
    func validateFields() -> Bool {
        clearFieldErrors(fields: [pinField, tokenField])
        var answer: Bool = false
    
        if softokenavailable == true {
            if (tokenField.text == "" || tokenField.text.count < 6 ){
                tokenField.error = "Please enter valid token"
                return false} else {
                    answer = true
                }
        } else if hasPin == true {
            if (pinField.text == "") || (pinField.text.count < 4){
                           pinField.error = "Please enter valid PIN"
                           return false
            } else {
                answer = true
            }
        } else {
            if (tokenField.text == "" || tokenField.text.count < 6  || pinField.text == "") || (pinField.text.count < 4 ) {
                return false
            } else {
                answer = true
            }
        }
        
        return answer
        
    }
    
    
}
