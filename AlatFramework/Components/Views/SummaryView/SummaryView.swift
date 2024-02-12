//
//  SummaryView.swift
//  AlatFramework
//
//  Created by Willi D Lax on 17/02/2023.
//

import UIKit

@IBDesignable public class SummaryView: BaseXib {

    let nibName = "SummaryView"
    
    @IBOutlet weak var topLeftLbl: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomRightLbl: UILabel!
    @IBOutlet weak var topRightLbl: UILabel!
    @IBOutlet weak var bottomLeftLbl: UILabel!
    @IBOutlet weak var bottomLeftTitle: UILabel!
    @IBOutlet weak var bottomRightTitle: UILabel!
    @IBOutlet weak var topLeftTitle: UILabel!
    @IBOutlet weak var topRightTitle: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var bottomLeftStack: UIStackView!
    @IBOutlet weak var bottomRightStack: UIStackView!
    @IBOutlet weak var topLeftStack: UIStackView!
    @IBOutlet weak var topRightStack: UIStackView!
    
    public var accountNumber: String? {
        set{
            topLeftLbl.text = newValue
        }get{
            return topLeftLbl.text
        }
    }
    
    var accountName: String? {
        set{
            bottomRightLbl.text = newValue
        }get{
            return bottomRightLbl.text
        }
    }
    
    var bank: String? {
        set{
            topRightLbl.text = newValue
        }get{
            return topRightLbl.text
        }
    }
    
    override init(frame: CGRect) {
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
    
    func setup(){
        contentView.layer.cornerRadius = 8
    }
    
    public func setValues(accountNumber: String, accountName: String, bank: String){
        topLeftLbl.text = accountNumber
        bottomRightLbl.text = accountName
        topRightLbl.text = bank
    }
    
    public func setValues(summaryModel: SummaryCardModel){
        topLeftLbl.text = summaryModel.accountNumber
        bottomRightLbl.text = summaryModel.accountName
        topRightLbl.text = summaryModel.bank.bankName
    }
    
    public func setForMultipleTransfer(multipleSummary: MultipleSummaryModel) {
        icon.isHidden = true
        bottomLeftStack.isHidden = false
        
        topLeftTitle.text = "Group"
        topRightTitle.text = "No of recipients"
        bottomLeftTitle.text = "Total amount"
        bottomRightTitle.text = "Charges"
        
        //probaly change the names of these later
        topLeftLbl.text = multipleSummary.groupName ?? "New group"
        topRightLbl.text = String(multipleSummary.numOfRecipients)
        bottomLeftLbl.text = "₦" + multipleSummary.totalAmount.toAmount()!
        bottomRightLbl.text = "₦" + multipleSummary.charges.toAmount()!
    }
    
    public func setForAirtime(airtimeSummary: AirtimeDataSummaryModel) {
        icon.isHidden = false
        icon.image = AlatAssets.phoneMoneyIcon.image
        bottomLeftStack.isHidden = true
        
        topLeftTitle.text = "Phone number"
        topLeftLbl.text = airtimeSummary.phoneNumber
        
        topRightTitle.text = "Network"
        topRightLbl.text = airtimeSummary.netWork
        
        bottomRightTitle.text = "Amount"
        bottomRightLbl.text = "₦" + airtimeSummary.amount.toAmount()!
    }
    
    public func setForData(dataSummary: AirtimeDataSummaryModel) {
        icon.isHidden = true
        bottomLeftStack.isHidden = false
        
        topLeftTitle.text = "Phone number"
        topLeftLbl.text = dataSummary.phoneNumber
        
        topRightTitle.text = "Network"
        topRightLbl.text = dataSummary.netWork
        
        bottomLeftTitle.text = "Data plan"
        bottomLeftLbl.text = dataSummary.dataPlan
        
        bottomRightTitle.text = "Amount"
        bottomRightLbl.text = "₦" + dataSummary.amount.toAmount()!
    }
    
    public func setForBill(billSummary: BillModel) {
        icon.isHidden = true
        bottomLeftStack.isHidden = false
        
        topLeftTitle.text = "Transaction ID"
        topLeftLbl.text = billSummary.identifier
        
        topRightTitle.text = "Profile name"
        topRightLbl.text = billSummary.userName
        
        bottomLeftTitle.text = "Biller"
        bottomLeftLbl.text = billSummary.billerName
        
        bottomRightTitle.text = "Amount"
        bottomRightLbl.text = "₦" + billSummary.amount.toAmount()!
    }
}
