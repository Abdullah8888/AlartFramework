//
//  AdminAccountListView.swift
//  AlatFramework
//
//  Created by Bakare Waris on 27/03/2023.
//

import UIKit

@IBDesignable public class AdminAccountListView: BaseXib {

    let nibName = "AdminAccountListView"
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak public var checkBox: UIImageView!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var numberOfUser: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var accountNoLbl: UILabel!
    @IBOutlet weak var userLbl: UILabel!
    
    public var model: SelectableAdminCardModel = SelectableAdminCardModel() {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var state: Bool = false {
        didSet { model.state = state }
    }
    
    @IBInspectable var isMapped: Bool = false {
        didSet { model.isMapped = isMapped }
    }
    
    
    public var isSelected: Bool = false
     public var account: AccountModel?
    
    @IBInspectable var forSummary: Bool = false {
         didSet {
             if forSummary {
                 setupForSummary()
             } else {
                 setup()
             }
         }
     }

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
    
    public func setValues(anAccount: AccountModel){
//        accountTypeLbl.text = anAccount.accountDescription
        if model.isMapped {
            accountName.text = anAccount.accountName
            accountNoLbl.text = "Avail.Balance"
            accountNumber.text = "\(anAccount.balance.toAmountWithCurrency(currencyCode: anAccount.currency) ?? "")"
            userLbl.text = "Account Number"
            numberOfUser.text = anAccount.accountNo
            checkBox.isHidden = true
        } else {
            print("the --- \(anAccount)")
            accountNumber.text = anAccount.accountNo
            accountName.text = anAccount.accountName
            numberOfUser.text = "\(anAccount.numberOfUsers ?? 0)"
            statusLabel.text = anAccount.accountStatus
            
        }
    }
    
    func setup(){
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.background.cgColor
        statusView.layer.cornerRadius = 8
        statusView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        contentView.isUserInteractionEnabled = true
        setValues(anAccount: account ?? AccountModel(accountId: "", currency: "", balance: 0, accountName: "", accountNo: "", accountDescription: "", accountStatus: ""))
        setState()
    }
    
    @objc func selected() {
        appearSelected()
    }
    
    func appearSelected(){
        checkBox.tintColor = .alatRed
        checkBox.image = isSelected ? AlatAssets.uncheckIcon.image : AlatAssets.checkIcon.image
        contentView.layer.borderWidth = isSelected ? 0 : 2
        contentView.layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.alatRed.cgColor
        contentView.backgroundColor = isSelected ? .white : .alatRed.withAlphaComponent(0.09)
        isSelected = !isSelected
        contentView.isUserInteractionEnabled = false
    }
    
    func disappearSelected() {
        checkBox.image = AlatAssets.uncheckIcon.image
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.backgroundColor = .white
    }
    
    func setState() {
        if model.state {
            contentView.layer.borderColor = UIColor.alatRed.cgColor
            contentView.backgroundColor = .alatRedLight
            checkBox.image = checkBox.image?.withRenderingMode(.alwaysTemplate)
            checkBox.tintColor = UIColor.alatRed
            checkBox.image = AlatAssets.checkIcon.image
        } else {
            contentView.layer.borderColor = UIColor.greyLight.darker(by: 8)?.cgColor
            contentView.backgroundColor = .greyLight
            checkBox.image = AlatAssets.uncheckIcon.image
        }
    }
    

    
    func setupForSummary(){
        checkBox.isHidden = true
        contentView.layer.cornerRadius = 8
        backgroundImage.isHidden = false
        
        statusView.layer.cornerRadius = 8
        statusView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        statusView.backgroundColor = .darkRed
        
//        statusLbl.textColor = .white
        accountNumber.textColor = .white
        accountName.textColor = .white
//        balanceLbl.textColor = .white
//        balanceHeaderLbl.textColor = .white
//        accountTypeLbl.textColor = .white
//        accTypeHeaderLbl.textColor = .white
        
        contentView.backgroundColor = .titleGrey
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.alatRed.cgColor
        contentView.isUserInteractionEnabled = false
    }
    
}

public struct SelectableAdminCardModel {
    public var state: Bool = false
    public var tapped: () -> Void = {}
    public var isMapped: Bool = false
}
