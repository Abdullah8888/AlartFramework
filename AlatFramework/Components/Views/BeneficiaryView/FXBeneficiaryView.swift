//
//  FXBeneficiaryView.swift
//  AlatFramework
//
//  Created by Bakare Waris on 24/07/2023.
//

import UIKit

public class FXBeneficiaryView: BaseXib {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var accountNameLbl: MediumLabel!
    @IBOutlet weak var optionMenu: UIImageView!
    
    @IBOutlet weak var bankAndAccNumberLbl: LightLabel!
    
    @IBOutlet weak var aliasLbl: LightLabel!
    public var parentView: UIView = UIView()
    public var actions = [Action.edit, Action.delete]
    
    public override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super .init(coder: coder)
        setup()
    }
    
    public func setValues(beneficiary: BeneficiaryModel){
        accountNameLbl.text = beneficiary.accountName
        aliasLbl.text = beneficiary.alias
        bankAndAccNumberLbl.text = beneficiary.accountNo + " | " + beneficiary.bank
    }
    
    public func setValues(beneficiaryGroup: BeneficiaryGroupModel){
        accountNameLbl.text = beneficiaryGroup.groupName
        aliasLbl.isHidden = true
        bankAndAccNumberLbl.text = String(beneficiaryGroup.groupCount) + " recipients"
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
        ActionModal.showActions(on: parentView, actions: actions)
    }
}


