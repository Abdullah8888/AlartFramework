//
//  TextViewField.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 03/02/2023.
//

import UIKit

@IBDesignable public class TextViewField: InputField, NSTextStorageDelegate {
    
    override public var text: String {
        get {
            if textArea.text == placeHolder {
                return ""
            }
            return textArea.text ?? ""
        }
        set {textArea.text = newValue}
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setup() {
        super.setup()
        setupTextArea()
    }
    
    func setupTextArea() {
        textArea.textStorage.delegate = self
        textArea.layoutManager.delegate = self
        textArea.layer.borderColor = UIColor.background.cgColor
        textArea.layer.borderWidth = 1
        textArea.layer.cornerRadius = 8
        textArea.textColor = .titleGrey
        textArea.font = Fonts.getFont(name: .Regular, 14)
        textArea.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        infoStack.isHidden = false
        counter.isHidden = false
        textArea.isHidden = false
        textView.isHidden = true
        textArea.backgroundColor = .greyLight
        textArea.heightAnchor.constraint(equalToConstant: 116).isActive = true
        updateHeight()
    }
    

    
    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        error = ""
        let count = textStorage.string == placeHolder ? 0 : textStorage.string.count
        counter.text = "\(count)/\(numberOfCharacters)"
    }
}

extension TextViewField: NSLayoutManagerDelegate {
    public func layoutManager(_ layoutManager: NSLayoutManager, lineSpacingAfterGlyphAt glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        12
    }
}
