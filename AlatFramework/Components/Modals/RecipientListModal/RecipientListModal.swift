//
//  RecipientListModal.swift
//  AlatFramework
//
//  Created by Willi D Lax on 25/03/2023.
//

import UIKit

public class RecipientListModal: BaseXib {
    let nibName = "RecipientListModal"

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cancelIcon: UIImageView!
    @IBOutlet weak var recipientTable: UITableView!
    
    public var recipients: [RecipientModel] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func getNibName() -> String? {
        return nibName
    }
    
    func setup(){
        recipientTable.register(DynamicTableViewCell.self, forCellReuseIdentifier: "RecipientCell")
        
        let closeTapped = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        cancelIcon.addGestureRecognizer(closeTapped)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleDismissal))
        swipeDown.direction = .down
        addGestureRecognizer(swipeDown)
    }
    
    @objc func handleDismissal() {
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
    
    public static func showRecipients(on view: UIView, recipients: [RecipientModel]){
        
        let backDrop = UIView(frame: Helpers.screen)
        backDrop.backgroundColor = .gray.withAlphaComponent(0.5)
        
        let modal = RecipientListModal()
        modal.recipients = recipients
        modal.layer.cornerRadius = 20
        modal.backgroundColor = .white
        modal.clipsToBounds = true
        backDrop.addSubview(modal)
        view.addSubview(backDrop)
        modal.frame = CGRect(x: 0, y: Helpers.screenHeight, width: Helpers.screenWidth, height: Helpers.screenHeight - 200)
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            modal.frame.origin.y = Helpers.screenHeight  - (Helpers.screenHeight - 200) + modal.layer.cornerRadius
            view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension RecipientListModal: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipients.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipientCell", for: indexPath) as! DynamicTableViewCell
        let recipientView = MultipleTransferCellView(frame: cell.bounds)
        recipientView.setForReview(recipient: recipients[indexPath.row], number: indexPath.row + 1)
        if(indexPath.row % 2 == 0){
            recipientView.backgroundColor = .greyLight
        }
        cell.applyView(view: recipientView)
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
