//
//  AccountView.swift
//  AlatFramework
//
//  Created by Willi D Lax on 17/02/2023.
//

import UIKit

@IBDesignable public class AccountView: BaseXib {
    
    let nibName = "AccountView"

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var accountTypeLbl: UILabel!
    @IBOutlet weak var accountNumberLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var checkIcon: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var balanceHeaderLbl: UILabel!
    @IBOutlet weak var accNumberHeaderLbl: UILabel!
    @IBOutlet weak var accTypeHeaderLbl: UILabel!
    @IBOutlet weak var backgroundCard: UIImageView!
    @IBOutlet weak var accountNameLbl: MediumLabel!
    @IBOutlet weak var typeStack: UIStackView!
    @IBOutlet weak var accountManagerView: UIView!
    
    var isSelected: Bool = false
    public var account: AccountModel?
    var doubleAccount: [AccountModel]?
    public var onTapped: () -> Void = {}
    
    public var model: SelectableAdminCardModel = SelectableAdminCardModel() {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var forSummary: Bool = false {
         didSet {
             if forSummary {
                 setupForSummary()
             } else {
                 setup()
             }
         }
     }
    
    @IBInspectable public var identifier: String = "" { didSet {
        self.accessibilityIdentifier = identifier
    } }
    
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
        accountTypeLbl.text = anAccount.accountDescription
        accountNameLbl.text = anAccount.accountName
        accountNumberLbl.text = anAccount.accountNo
        if anAccount.currency == "USD" {
            balanceLbl.text = "$" + anAccount.balance.toAmount()!
        } else if anAccount.currency == "EUR" {
            balanceLbl.text = "€" + anAccount.balance.toAmount()!
        } else if anAccount.currency == "GBP" {
            balanceLbl.text = "£" + anAccount.balance.toAmount()!
        } else {
            balanceLbl.text = "₦" + anAccount.balance.toAmount()!
        }
       
//        balanceLbl.text = "₦" + anAccount.balance.toAmount()!
        statusLbl.text = anAccount.accountStatus
    }
    
    public func useForAllAccounts() {
        accountNameLbl.isHidden = false
        typeStack.isHidden = true
        checkIcon.isHidden = true
        accountManagerView.backgroundColor = UIColor(red: 0.663, green: 0.031, blue: 0.212, alpha: 0.08).withAlphaComponent(0.08)
        accountManagerView.layer.cornerRadius = 4
        accountManagerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(seeManagerClicked)))
        accountManagerView.isHidden = false
    }
    
    
    @objc func seeManagerClicked() {
        onTapped()
    }
    
    func setup(){
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.background.cgColor
        statusView.layer.cornerRadius = 8
        statusView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        contentView.isUserInteractionEnabled = true
//        let tapped = UITapGestureRecognizer(target: self, action: #selector(selected))
//        contentView.addGestureRecognizer(tapped)
        setValues(anAccount: account ?? AccountModel(accountId: "", currency: "", balance: 0, accountName: "", accountNo: "", accountDescription: "", accountStatus: ""))
        setState()
    }
    
    func setState() {
        if model.state {
            contentView.layer.borderColor = UIColor.alatRed.cgColor
            contentView.backgroundColor = .alatRedLight
            checkIcon.image = checkIcon.image?.withRenderingMode(.alwaysTemplate)
            checkIcon.tintColor = UIColor.alatRed
            checkIcon.image = AlatAssets.checkIcon.image
        } else {
            contentView.layer.borderColor = UIColor.greyLight.darker(by: 8)?.cgColor
            contentView.backgroundColor = .greyLight
            checkIcon.image = AlatAssets.uncheckIcon.image
        }
    }
    
    @objc func selected(){
        appearSelected()
    }
    
    func appearSelected(){
        checkIcon.tintColor = .alatRed
        checkIcon.image = isSelected ? AlatAssets.uncheckIcon.image : AlatAssets.checkIcon.image
        contentView.layer.borderWidth = isSelected ? 0 : 2
        contentView.layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.alatRed.cgColor
        contentView.backgroundColor = isSelected ? .white : .alatRed.withAlphaComponent(0.09)
        isSelected = !isSelected
        contentView.isUserInteractionEnabled = false
    }
    
    func setupForSummary(){
        checkIcon.isHidden = true
        contentView.layer.cornerRadius = 8
        backgroundCard.isHidden = false
        
        statusView.layer.cornerRadius = 8
        statusView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        statusView.backgroundColor = .darkRed
        
        statusLbl.textColor = .white
        accountNumberLbl.textColor = .white
        accNumberHeaderLbl.textColor = .white
        balanceLbl.textColor = .white
        balanceHeaderLbl.textColor = .white
        accountTypeLbl.textColor = .white
        accTypeHeaderLbl.textColor = .white
        
        contentView.backgroundColor = .titleGrey
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.alatRed.cgColor
        contentView.isUserInteractionEnabled = false
    }
}
