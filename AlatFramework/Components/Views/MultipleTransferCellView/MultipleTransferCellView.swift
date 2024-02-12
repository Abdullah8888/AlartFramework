//
//  MultipleTransferCellView.swift
//  AlatFramework
//
//  Created by Willi D Lax on 07/03/2023.
//

import UIKit

public class MultipleTransferCellView: BaseXib {
    let nibName = "MultipleTransferCellView"
    
    public var editTapped: (_ index: Int) -> Void = {index in }
    public var removeTapped: (_ index: Int) -> Void = {index in }
    public var index: Int = 0
    public var actions = [Action.edit, Action.delete]
    public var parentView: UIView = UIView()

    @IBOutlet weak var numberLbl: RegularLabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var memberNameLbl: RegularLabel!
    @IBOutlet weak var amountLbl: RegularLabel!
    @IBOutlet weak var bankNameLbl: RegularLabel!
    @IBOutlet weak var accountNumberLbl: RegularLabel!
    @IBOutlet weak var optionBtn: UIImageView!
    @IBOutlet weak var statusLbl: RegularLabel!
    
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
    
    public func setValues(recipient: RecipientModel, number: Int){
        memberNameLbl.text = recipient.name
        amountLbl.text = "₦" + recipient.amountToReceive.toAmount()!
        bankNameLbl.text = recipient.bank.bankName
        accountNumberLbl.text = recipient.accountNo
        numberLbl.text = String(number)
    }
    
    public func setForReview(recipient: RecipientModel, number: Int){
        memberNameLbl.text = recipient.name
        amountLbl.text = "₦" + recipient.amountToReceive.toAmount()!
        bankNameLbl.text = recipient.bank.bankName //+ " - " + recipient.accountNo
        accountNumberLbl.text = recipient.accountNo
        numberLbl.text = String(number)
        //accountNumberLbl.isHidden = true
        optionBtn.isHidden = true
    }
    
    public func setForBreakdown(recipient: RecipientModel, number: Int){
        memberNameLbl.text = recipient.name
        bankNameLbl.text = recipient.bank.bankName
        accountNumberLbl.text = recipient.accountNo
        numberLbl.text = String(number)
        optionBtn.isHidden = true
        amountLbl.isHidden = true
        statusLbl.isHidden = false
        if recipient.status == .Success {
            statusLbl.text = "Successful"
            statusLbl.textColor = .success
        }
        else{
            statusLbl.text = "Failed"
            statusLbl.textColor = .red
        }
    }
    
    func setup(){
        optionBtn.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleOptionTapped))
        optionBtn.addGestureRecognizer(tap)
    }
    
    @objc func handleOptionTapped(){
        showOptions()
    }
    
    func showOptions(){
        ActionModal.showActions(on: parentView, actions: actions, onActionCalled: takeActions)
    }
    
    func takeActions(actionType: Action){
        if actionType == .delete {
            removeTapped(index)
        }
        if actionType == .edit {
            editTapped(index)
        }
    }
}

public struct RecipientModel {
    public var name: String
    public var accountNo: String
    public var bank: BankModel
    public var amountToReceive: Double
    public var currency: String
    public var narration: String?
    public var status: Status?
    
    public init(name: String, accountNo: String, bank: BankModel, amountToReceive: Double, currency: String, narration: String? = nil, status: Status? = nil) {
        self.name = name
        self.accountNo = accountNo
        self.bank = bank
        self.amountToReceive = amountToReceive
        self.currency = currency
        self.narration = narration
        self.status = status
    }
}

public enum Status: Int, Codable{
    case Retry = 17
    case Success = 11
    case Failed = 5
    case Pending = 1
    case None = 0
}
