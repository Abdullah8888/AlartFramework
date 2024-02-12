//
//  Dropdown.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 03/02/2023.
//
import UIKit

@IBDesignable public class DropDown: InputField {
    
    @IBInspectable public var pickerTitle: String = ""
    public var items: [PickerItem] = []
    public var selectedItem: PickerItem? {
        didSet {
            textField.text = selectedItem?.name
        }
    }
    public var itemChanged: (PickerItem) -> Void = { _ in }
    public var fieldEdited: () -> Void = {}
    

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
        textBlocker.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.pickerTapped(_:))))
    }
    
    func setLeftImage() {
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 12))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
        imageView.tintColor = .alatRed
        imageView.image = AlatAssets.dropdownIcon.image
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        iconContainer.addSubview(imageView)
        textField.rightViewMode = UITextField.ViewMode.always
        textField.rightView = iconContainer
    }
    
    public func setItem(with item: PickerItem) {
        textField.text = item.name
        selectedItem = item
    }

    @objc func pickerTapped(_ sender: UITapGestureRecognizer) {
        PickerModal.show(title: pickerTitle, items: items, callBack: { [weak self] in
            guard self?.items.count ?? 0 > 0 else { return }
            self?.selectedItem = $0
            //self?.textField.text = self?.selectedItem?.name
            self?.error = ""
            self?.fieldEdited()
            
            guard let selectedItem = self?.selectedItem else { return }
            self?.itemChanged(selectedItem)
        })
    }
}
