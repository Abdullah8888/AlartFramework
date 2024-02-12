//
//  HistoryFilterModal.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 08/04/2023.
//

public class HistoryFilterModal: BaseXib {
    
    @IBOutlet weak var endDateField: DatePicker!
    @IBOutlet weak var startDateField: DatePicker!
    @IBOutlet weak var transactionTypeField: DropDown!
    @IBOutlet weak var doneButton: PrimaryButton!
    
    var callback: (Date, Date, String) -> Void = { _,_,_ in}
    
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
        
        transactionTypeField.items = [
        PickerItem(name: "All", value: "All"),
        PickerItem(name: "Credit", value: "Credit"),
        PickerItem(name: "Debit", value: "Debit")
        ]
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        if validateFields(), let start = startDateField.selectedDate, let end = endDateField.selectedDate, let type = transactionTypeField.selectedItem?.name {
            callback(start, end, type.lowercased())
            dismiss()
        }
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss()
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
    
    func validateFields() -> Bool {
        let startDateValidity = startDateField.validate(rules: [Rule(.isEmpty, "Select Start Date")])
        let endDateValidity = endDateField.validate(rules: [Rule(.isEmpty, "Select End Date"), Rule(.isLessThan, "Cannot be lower than start date")], v1: startDateField.selectedDate ?? Date(), v2:  endDateField.selectedDate ?? Date())
        let typeValidity = transactionTypeField.validate(rules: [Rule(.isEmpty, "Select Transaction Type")])
        
        
        return startDateValidity && endDateValidity && typeValidity
    }
}

// MARK: Display Modal
extension HistoryFilterModal {
    public static func show(callback: @escaping (Date, Date, String) -> Void = { _,_,_ in}) {
        let backDrop = HistoryFilterModalView(frame: Helpers.screen)
        backDrop.backgroundColor = .clear
        backDrop.applyDarkEffect()
        
        let modal = HistoryFilterModal()
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
                        if v is HistoryFilterModal {
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

class HistoryFilterModalView: UIView {}

