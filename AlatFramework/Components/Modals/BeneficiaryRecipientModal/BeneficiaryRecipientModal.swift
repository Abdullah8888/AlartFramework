//
//  BeneficiaryRecipientModal.swift
//  AlatFramework
//
//  Created by Willi D Lax on 08/03/2023.
//

import UIKit

public class BeneficiaryRecipientModal: BaseXib {
    let nibName = "BeneficiaryRecipientModal"
    
    @IBOutlet weak var backView: CustomView!
    @IBOutlet weak var summaryCard: SummaryView!
    @IBOutlet weak var amountField: MoneyField!
    @IBOutlet weak var closeIcon: UIImageView!
    @IBOutlet weak var addBtn: PrimaryButton!
    @IBOutlet weak var title: BoldLabel!
    
    public var finishedEnteringAmount: () -> Void = {}
    public static var amountEntered: Double = 0
    
    @IBAction func addBtnTapped(_ sender: Any) {
        BeneficiaryRecipientModal.self.amountEntered = GeneralFormatter.moneyStringToDouble(amountString: amountField.text, currency: amountField.currency)
        if (amountField.text == "") || (BeneficiaryRecipientModal.self.amountEntered <= 0) {
            amountField.error = "Please enter a valid amount"
        }
        else{
            dismiss()
            finishedEnteringAmount()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func getNibName() -> String? {
        return nibName
    }
    
    func setup() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
        swipeDown.direction = .down
        addGestureRecognizer(swipeDown)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSwipeDown))
        closeIcon.isUserInteractionEnabled = true
        closeIcon.addGestureRecognizer(tap)
    }
    
    @objc func handleSwipeDown() {
        dismiss()
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            self?.frame.origin.y = Helpers.screenHeight
            self?.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.superview?.removeFromSuperview()
        })
    }
    
    public static func promptForAmount(on view: UIView, beneficiarySummary: SummaryCardModel, forEdit: Bool? = false, onAmountEntered: @escaping () -> Void = {}){
        
        let backDrop = UIView(frame: Helpers.screen)
        backDrop.backgroundColor = .gray.withAlphaComponent(0.5)
        
        let modal = BeneficiaryRecipientModal()
        modal.layer.cornerRadius = 20
        modal.backgroundColor = .white
        modal.clipsToBounds = true
        backDrop.addSubview(modal)
        view.addSubview(backDrop)
        modal.frame = CGRect(x: 0, y: Helpers.screenHeight, width: Helpers.screenWidth, height: 500)
        view.layoutIfNeeded()
        
        if forEdit! {
            modal.title.text = "Edit amount"
            modal.addBtn.setTitle("save changes", for: .normal)
        }
        
        modal.summaryCard.setValues(summaryModel: beneficiarySummary)
        modal.finishedEnteringAmount = onAmountEntered
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            modal.frame.origin.y = Helpers.screenHeight  - 500 + modal.layer.cornerRadius
            view.layoutIfNeeded()
        }, completion: nil)
    }

}
