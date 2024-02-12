//
//  NotificationFilterModal.swift
//  AlatFramework
//
//  Created by Bakare Waris on 21/11/2023.
//

import Foundation

public class NotificationFilterModal: BaseXib {
    
    @IBOutlet weak var allView: UIView!
    @IBOutlet weak var readView: UIView!
    @IBOutlet weak var unreadView: UIView!
    @IBOutlet weak var readLabel: SemiLabel!
    @IBOutlet weak var allLabel: SemiLabel!
    @IBOutlet weak var unReadLabel: SemiLabel!
    @IBOutlet weak var startDateField: DatePicker!
    @IBOutlet weak var endDateField: DatePicker!
    
    
    var callback: (Date, Date, Int) -> Void = { _,_,_ in}
    var filterLabel: String = ""
    var filterType: Int = 0
    
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
        
        
        [readView, unreadView].forEach {
            $0?.backgroundColor = .greyLight
            $0?.layer.cornerRadius = 8
        }
        allView.backgroundColor = .alatRedLight
        allView.layer.cornerRadius = 8
        allView.layer.borderColor = UIColor.alatRed.cgColor
        allView.layer.borderWidth = 1
        
        readView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(readViewTapped)))
        unreadView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(unreadViewTapped)))
        allView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(allViewTapped)))
        filterLabel = "All"
        filterType = 1
    }
    
    @objc func readViewTapped() {
        readView.backgroundColor = .alatRedLight
        readView.layer.cornerRadius = 8
        readView.layer.borderColor = UIColor.alatRed.cgColor
        readView.layer.borderWidth = 1
        readLabel.textColor = .alatRed
        [allView, unreadView].forEach {
            $0?.backgroundColor = .greyLight
            $0?.layer.cornerRadius = 8
            $0?.layer.borderWidth = 0
            $0?.layer.borderColor = UIColor.clear.cgColor
        }
        allLabel.textColor = .background
        unReadLabel.textColor = .background
        filterLabel = "Read"
        filterType = 2
    }
    
    @objc func unreadViewTapped() {
        unreadView.backgroundColor = .alatRedLight
        unreadView.layer.cornerRadius = 8
        unreadView.layer.borderColor = UIColor.alatRed.cgColor
        unreadView.layer.borderWidth = 1
        unReadLabel.textColor = .alatRed
        [allView, readView].forEach {
            $0?.backgroundColor = .greyLight
            $0?.layer.cornerRadius = 8
            $0?.layer.borderWidth = 0
            $0?.layer.borderColor = UIColor.clear.cgColor
        }
        allLabel.textColor = .background
        readLabel.textColor = .background
        filterLabel = "Unread"
        filterType = 3
    }
    
    @objc func allViewTapped() {
        allView.backgroundColor = .alatRedLight
        allView.layer.cornerRadius = 8
        allView.layer.borderColor = UIColor.alatRed.cgColor
        allView.layer.borderWidth = 1
        allLabel.textColor = .alatRed
        [readView, unreadView].forEach {
            $0?.backgroundColor = .greyLight
            $0?.layer.cornerRadius = 8
            $0?.layer.borderWidth = 0
            $0?.layer.borderColor = UIColor.clear.cgColor
        }
        readLabel.textColor = .background
        unReadLabel.textColor = .background
        filterLabel = "All"
        filterType = 1
    }
    
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        let start = startDateField.selectedDate ?? Date()
        let end = endDateField.selectedDate ?? Date()
        callback(start, end, filterType)
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

}


// MARK: Display Modal
extension NotificationFilterModal {
    public static func show(callback: @escaping (Date, Date, Int) -> Void = { _,_,_ in}) {
        let backDrop = NotificationFilterModalView(frame: Helpers.screen)
        backDrop.backgroundColor = .clear
        backDrop.applyDarkEffect()
        
        let modal = NotificationFilterModal()
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
                        if v is NotificationFilterModal {
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

class NotificationFilterModalView: UIView {}
