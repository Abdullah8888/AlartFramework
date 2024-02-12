//
//  BankDropDown.swift
//  AlatFramework
//
//  Created by Willi D Lax on 26/02/2023.
//

import UIKit

public class BankDropDown: InputField {

    public var parentView: UIView?
    public var bankList: [BankModel]?
    let dummyBankList: [BankModel] = []
    let dummyBank: BankModel = BankModel(bankName: "", bankCode: "")
    
    public var bankName: String?
    public var bankCode: String?
    public var bankSelected: BankModel?
    public var onSelected: () -> Void = {}
    
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
        textField.isEnabled = false
        let tapped = UITapGestureRecognizer(target: self, action: #selector(handleTapped))
        addGestureRecognizer(tapped)
    }
    
    @objc func handleTapped() {
        BankListModal.startBankSelection(on: parentView!, banks: bankList ?? dummyBankList, delegate: self, previousSelection: bankSelected ?? dummyBank)
    }
    
    func setLeftImage() {
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 12))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
        imageView.tintColor = .alatRed
        imageView.image = AlatAssets.dropdownIcon.image
        imageView.tintColor = .background
        imageView.contentMode = .scaleAspectFit
        iconContainer.addSubview(imageView)
        textField.rightViewMode = UITextField.ViewMode.always
        textField.rightView = iconContainer
    }
}

extension BankDropDown: IBankSelectedDelegate{
    public func bankSelected(selectedBank: BankModel) {
        textField.text = selectedBank.bankName
        bankName = selectedBank.bankName
        bankCode = selectedBank.bankCode
        bankSelected = selectedBank
        onSelected()
    }
}
