//
//  AccountSelectorField.swift
//  AlatFramework
//
//  Created by Willi D Lax on 20/02/2023.
//

import UIKit

public class AccountSelectorField: InputField {
    
    public var parentView: UIView?
    public var accountList: [AccountModel]?
    let dummyAccountList: [AccountModel] = []
    let dummyAccount: AccountModel = AccountModel(accountId: "", currency: "", balance: 0, accountName: "", accountNo: "", accountDescription: "", accountStatus: "")
    
    public var accountNumber: String?
    public var accountName: String?
    public var accountBalance: Double?
    public var accountSelected: AccountModel?
    public var onSelected: () -> Void = {}
    
    
    public var listOfAccounts: [AccountModel] = []
    public var isMultipleSelection: Bool?
    var dummyMultple = false
    
    @IBInspectable public var useAccountNumber: Bool = false
    
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
        //parentView?.endEditing(true)
        if isMultipleSelection == true {
            AdminAccountsModal.startAccountSelection(on: parentView!, accounts: accountList ?? dummyAccountList, delegate: self, title: titleText, previousSelection: listOfAccounts , isMultiple: isMultipleSelection ?? dummyMultple, isSoleAccount: false)
        } else {
            AccountsModal.startAccountSelection(on: parentView!, accounts: accountList ?? dummyAccountList, delegate: self, title: titleText, previousSelection: accountSelected ?? dummyAccount, isMultiple: isMultipleSelection ?? dummyMultple) }
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
    
    public func clear(){
        textBlocker.isHidden = true
        coverLabel.isHidden = true
        styledLabel.isHidden = true
        coverLabel.text = ""
        styledLabel.text = ""
        accountNumber = nil
    }
    
    public func prefill(account: AccountModel) {
        error = ""
        placeHolder = ""
        textBlocker.isHidden = false
        coverLabel.isHidden = false
        styledLabel.isHidden = false
        if useAccountNumber {
            coverLabel.text = "Acct No"
            styledLabel.text = " " + account.accountNo + "   "
        }else{
            coverLabel.text = "Balance"
            if account.currency == "USD" {
                styledLabel.text = " $" + account.balance.toAmount()! + "    "
            } else if account.currency == "EUR" {
                styledLabel.text = " €" + account.balance.toAmount()! + "    "
            } else if account.currency == "GBP" {
                styledLabel.text = " £" + account.balance.toAmount()! + "    "
            } else {
                styledLabel.text = " ₦" + account.balance.toAmount()! + "    "
            }
        }
        accountName = account.accountName
        accountNumber = account.accountNo
        accountBalance = account.balance
        accountSelected = account
    }
}

extension AccountSelectorField: IAccountSelectedDelegate {
    public func listOfAccountSelected(accounts SelectedAccounts: [AccountModel]) {
        error = ""
        print("the select account is \(SelectedAccounts)")
        if SelectedAccounts == [] {
            textField.text = ""
        } else {
            for index in SelectedAccounts {
                textField.text = index.accountNo
            }
        }
       
        listOfAccounts = SelectedAccounts
        onSelected()
    }
    
    public func accountSelected(account selectedAccount: AccountModel) {
        error = ""
        placeHolder = ""
        textBlocker.isHidden = false
        coverLabel.isHidden = false
        styledLabel.isHidden = false
        if useAccountNumber {
            coverLabel.text = "Acct No"
            styledLabel.text = " " + selectedAccount.accountNo + "   "
        }else{
            coverLabel.text = "Balance"
            if selectedAccount.currency == "USD" {
                styledLabel.text = " $" + selectedAccount.balance.toAmount()! + "    "
            } else if selectedAccount.currency == "EUR" {
                styledLabel.text = " €" + selectedAccount.balance.toAmount()! + "    "
            } else if selectedAccount.currency == "GBP" {
                styledLabel.text = " £" + selectedAccount.balance.toAmount()! + "    "
            } else {
                styledLabel.text = " ₦" + selectedAccount.balance.toAmount()! + "    "
            }
        }
        accountName = selectedAccount.accountName
        accountNumber = selectedAccount.accountNo
        accountBalance = selectedAccount.balance
        accountSelected = selectedAccount
        onSelected()
    }
}

//extension AccountSelectorField: ListOfAccountSelectedDelegate {
//    public func listOfAccountSelected(accounts SelectedAccounts: [AccountModel]) {
//        error = ""
//        textField.text = SelectedAccounts[0].accountName
//    }
//
//
//}
