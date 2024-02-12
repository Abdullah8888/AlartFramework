//
//  HorizontalCellView.swift
//  AlatFramework
//
//  Created by Bakare Waris on 30/03/2023.
//

import Foundation

import UIKit

@IBDesignable public class HorizontalCellView: BaseXib {
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var accountName: RegularLabel!
    @IBOutlet weak var accountNo: RegularLabel!
    
    public var account: AccountModel?
    
    public override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super .init(coder: coder)
        setup()
    }

    
    public func setValues(anAccount: AccountModel){
        accountNo.text = anAccount.accountNo
        accountName.text = anAccount.accountName
    }
    
    func setup(){
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .background
        setValues(anAccount: account ?? AccountModel(accountId: "", currency: "", balance: 0, accountName: "", accountNo: "", accountDescription: "", accountStatus: ""))
    }
    
}
