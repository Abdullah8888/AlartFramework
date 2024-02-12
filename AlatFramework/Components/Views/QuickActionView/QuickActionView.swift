//
//  QuickActionView.swift
//  AlatFramework
//
//  Created by Willi D Lax on 06/04/2023.
//

import UIKit

@IBDesignable public class QuickActionView: BaseXib {
    let nibName = "QuickActionView"
    
    @IBOutlet weak var contentView: CustomView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    public var actionTapped: (QuickActionType) -> Void = { _ in }
    
    public var type: QuickActionType? {
        didSet{
            setup()
        }
    }
    
    public override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setup()
    }
    
    override func getNibName() -> String? {
        return nibName
    }
    
    func setup() {
        if let actionType = type { setStyleForAction(type: actionType) }
        icon.image = type?.image
        title.text = type?.title
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tap)
    }
    
    @objc func tapped(){
        actionTapped(type ?? .defaultAction)
    }
    
    func setStyleForAction(type: QuickActionType) {
        switch type {
            
        case .sendMoney, .accountStatement, .settings, .defaultAction:
            print("nothing")
        case .createNewAccount, .registerOnAfb, .reactivateAccount:
            contentView.borderWidth = 1
            contentView.borderColor = UIColor.background
        
        }
    }
}

public enum QuickActionType {
    case sendMoney, accountStatement, settings, createNewAccount, registerOnAfb, reactivateAccount, defaultAction
    
    var title: String {
        switch self {
        case .sendMoney:
            return "Send money"
        case .accountStatement:
            return "Account statement"
        case .settings:
            return "Settings"
        case .createNewAccount:
            return "Open a corporate account"
        case .registerOnAfb:
            return "Register for internet banking"
        case .reactivateAccount:
            return "Reactivate your account"
        case .defaultAction:
            return ""
        }
    }
    
    var image: UIImage {
        switch self {
        case .sendMoney:
            return AlatAssets.moneyIcon.image
        case .accountStatement:
            return AlatAssets.statementIcon.image
        case .settings:
            return AlatAssets.settingsIconRed.image
        case .createNewAccount:
            return AlatAssets.createNewAccountIcon.image
        case .registerOnAfb:
            return AlatAssets.registerForMobileBanking.image
        case .reactivateAccount:
            return AlatAssets.reactivateAccountIcon.image
        case .defaultAction:
            return UIImage()
        }
    }
}
