//
//  FailedNotificationModal.swift
//  AlatFramework
//
//  Created by Bakare Waris on 28/11/2023.
//

import Foundation


public class FailedNotificationModal: BaseXib {
    
    @IBOutlet weak public var contentDataView: UIView!
    @IBOutlet weak public var dateLabel: MediumLabel!
    @IBOutlet weak var referenceLabel: MediumLabel!
    @IBOutlet weak var transactionStatus: MediumLabel!
    @IBOutlet weak var currencyLabel: MediumLabel!
    @IBOutlet weak var amountLabel: MediumLabel!
    
    var callback: () -> Void = { }
    
    public var model: FailedNotificationModalModel = FailedNotificationModalModel() {
        didSet {
            setupUI()
        }
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
        swipeDown.direction = .down
        addGestureRecognizer(swipeDown)
        contentDataView.layer.cornerRadius = 12
        contentDataView.layer.borderWidth = 1
        contentDataView.layer.borderColor = UIColor.background.cgColor
        setupUI()
    }
    
    func setupUI() {
        dateLabel.text = model.date
        referenceLabel.text = model.reference
        transactionStatus.text = model.transactionStatus
        currencyLabel.text = model.currency
        amountLabel.text = model.amount.toAmountWithCurrency()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        callback()
        dismiss()
    }
    
    
    @objc func handleSwipeDown() {
        callback()
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
   
}

// MARK: Display Modal
extension FailedNotificationModal {
    public static func show(date: String, referenceNumber: String, status: String, currency: String, amount: Double, callback: @escaping () -> Void = {}) {
        let backDrop = FailedNotificationModalView(frame: Helpers.screen)
        backDrop.backgroundColor = .clear
        backDrop.applyDarkEffect()
        
        let modal = FailedNotificationModal()
        modal.model.amount = amount
        modal.model.date = date
        modal.model.reference = referenceNumber
        modal.model.transactionStatus = status
        modal.model.currency = currency
        modal.callback = callback
       
        modal.clipsToBounds = true
        backDrop.addSubview(modal)
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.addSubview(backDrop)
        let height = 485.0
        modal.frame = CGRect(x: 0, y: Helpers.screenHeight, width: Helpers.screenWidth, height: height)
        backDrop.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            modal.frame.origin.y = Helpers.screenHeight - height
            backDrop.layoutIfNeeded()
        }, completion: nil)
    }
    
    public static func dismiss() {
        if let subviews = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.subviews {
            for view in subviews {
                if view is HistoryFilterModalView {
                    for v in view.subviews {
                        if v is FailedNotificationModal {
                            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                                v.frame.origin.y = Helpers.screenHeight
                                view.layoutIfNeeded()
                            }, completion: { _ in
                                view.removeFromSuperview()
                            })
                        }
                    }
               }
            }
        }
    }
}

public struct FailedNotificationModalModel {
    var amount: Double = 0
    var reference: String = ""
    var currency: String = ""
    var date: String = ""
    var transactionStatus: String = ""

}

class FailedNotificationModalView: UIView {}


