//
//  BeneficiaryView.swift
//  AlatFramework
//
//  Created by Willi D Lax on 04/03/2023.
//

import UIKit

public class BeneficiaryView: BaseXib {
    let nibName = "BeneficiaryView"
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var accountNameLbl: MediumLabel!
    @IBOutlet weak var aliasLbl: LightLabel!
    @IBOutlet weak var bankAndAccNumberLbl: LightLabel!
    @IBOutlet weak var optionMenu: UIImageView!
    @IBOutlet weak var icon: UIImageView!
    
    public var parentView: UIView = UIView()
    public var actions = [Action.delete]
    public var removeTapped: (_ index: Int) -> Void = {index in }
    public var index: Int = 0
    
    public override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super .init(coder: coder)
        setup()
    }
    
    override func getNibName() -> String? {
        return nibName
    }
    
    public func setValues(beneficiary: BeneficiaryModel){
        accountNameLbl.text = beneficiary.accountName
        aliasLbl.text = beneficiary.alias
        optionMenu.isHidden = false
        bankAndAccNumberLbl.text = beneficiary.bank + " | " + beneficiary.accountNo
    }
    
    public func setValues(beneficiaryGroup: BeneficiaryGroupModel){
        accountNameLbl.text = beneficiaryGroup.groupName
        aliasLbl.isHidden = true
        bankAndAccNumberLbl.text = String(beneficiaryGroup.groupCount) + " recipients"
    }
    
    public func setValues(airtimeDataBeneficiary: AirtimeDataBeneficiaryModel, forData: Bool = false) {
        accountNameLbl.text = airtimeDataBeneficiary.alias
        bankAndAccNumberLbl.text = airtimeDataBeneficiary.network + " | " + airtimeDataBeneficiary.phoneNumber
        aliasLbl.isHidden = forData
        aliasLbl.text = "₦" + (airtimeDataBeneficiary.amount.toAmount() ?? "0") 
        icon.image = forData ? AlatAssets.dataBeneficiaryIcon.image : AlatAssets.phoneMoneyIcon.image
        icon.tintColor = .alatRed
    }
    
    public func setup(){
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.background.withAlphaComponent(0.5).cgColor
        contentView.backgroundColor = .greyLight
        
        optionMenu.isUserInteractionEnabled = true
        let optionsTapped = UITapGestureRecognizer(target: self, action: #selector(handleOptionTapped))
        optionMenu.addGestureRecognizer(optionsTapped)
    }
    
    @objc func handleOptionTapped() {
        showOptions()
    }
    
    func showOptions(){
        ActionModal.showActions(on: parentView, actions: actions, onActionCalled: takeActions)
    }
    
    func takeActions(actionType: Action){
        if actionType == .delete {
            removeTapped(index)
        }
    }
}

public struct BeneficiaryModel{
    public var accountName: String
    public var alias: String
    public var bank: String
    public var accountNo: String
    
    public init(accountName: String, alias: String, bank: String, accountNo: String) {
        self.accountName = accountName
        self.alias = alias
        self.bank = bank
        self.accountNo = accountNo
    }
}

public struct BeneficiaryGroupModel{
    public var groupName: String
    public var groupCount: Int
    
    public init(groupName: String, groupCount: Int) {
        self.groupName = groupName
        self.groupCount = groupCount
    }
}

public struct AirtimeDataBeneficiaryModel {
    public var alias: String
    public var network: String
    public var phoneNumber: String
    public var amount: Double
    public var dataPlan: String
    
    public init(alias: String, network: String, phoneNumber: String, amount: Double, dataPlan: String) {
        self.alias = alias
        self.network = network
        self.phoneNumber = phoneNumber
        self.amount = amount
        self.dataPlan = dataPlan
    }
}
