//
//  DatePicker.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 04/02/2023.
//

import UIKit

@IBDesignable public class DatePicker: InputField {
    var picker = UIDatePicker()
    
    public var minimumDate: Date? {
        didSet {
            picker.minimumDate = minimumDate
        }
    }
    
    public var maximumDate: Date? {
        didSet {
            picker.maximumDate = maximumDate
        }
    }
    
    public var selectedDate: Date? {
        didSet {
            if let selectedDate {
                textField.text = String.toReadableDate(date: selectedDate)
            } else {
                textField.text = ""
            }
        }
    }
    
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
        setLeftImage()
        
        textBlocker.isHidden = false
        //picker.backgroundColor = .white
        picker.timeZone = .current
        picker.tintColor = .alatRed
        picker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            if #available(iOS 14.0, *) {
                picker.preferredDatePickerStyle = .inline
            } else {
                picker.preferredDatePickerStyle = .wheels
            }
        } else {
            // Fallback on earlier versions
        }
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.donButtonTapped(_:)))
        doneButton.tintColor = .white
        let toolBar = UIToolbar()
        toolBar.barTintColor = .alatRed
        toolBar.isTranslucent = true
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil), doneButton], animated: true)
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
        textField.inputView = picker
        textBlocker.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.pickerTapped(_:))))
    }
    
    func setLeftImage() {
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 12))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
        imageView.image = AlatAssets.dropdownIcon.image
        imageView.tintColor = .background
        imageView.contentMode = .scaleAspectFit
        iconContainer.addSubview(imageView)
        textField.rightViewMode = UITextField.ViewMode.always
        textField.rightView = iconContainer
    }
    
    public func setItem(with item: PickerItem) {
        
    }
    
    @objc func donButtonTapped(_ sender: UIBarButtonItem) {
        if picker.date != nil {
            textField.resignFirstResponder()
            selectedDate = picker.date
            textField.text = String.toReadableDate(date: picker.date)
        }
    }

    @objc func pickerTapped(_ sender: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }
}
