//
//  BankListModal.swift
//  AlatFramework
//
//  Created by Willi D Lax on 26/02/2023.
//

import UIKit

public protocol IBankSelectedDelegate{
    func bankSelected(selectedBank: BankModel)
}

class BankListModal: BaseXib {
    let nibName = "BankListModal"
    
    var bankDelegate: IBankSelectedDelegate?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cancelIcon: UIImageView!
    @IBOutlet weak var searchField: SearchField!
    @IBOutlet weak var bankTable: UITableView!
    
    var banks: [BankModel]?
    let dummyBank: BankModel = BankModel(bankName: "", bankCode: "")
    var previousSelection: BankModel?
    
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
        bankTable.register(DynamicTableViewCell.self, forCellReuseIdentifier: "BankCell")
        
        contentView.backgroundColor = .greyLight
        
        let cancelTapped = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        cancelIcon.addGestureRecognizer(cancelTapped)
        
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
    
    public static func startBankSelection(on view: UIView, banks bankList: [BankModel], delegate del: IBankSelectedDelegate, previousSelection selectedBank: BankModel){
        
        let backDrop = UIView(frame: Helpers.screen)
        backDrop.backgroundColor = .gray.withAlphaComponent(0.5)
        
        let modal = BankListModal()
        modal.bankDelegate = del
        modal.banks = bankList
        modal.previousSelection = selectedBank
        modal.layer.cornerRadius = 20
        modal.backgroundColor = .white
        modal.clipsToBounds = true
        backDrop.addSubview(modal)
        view.addSubview(backDrop)
        modal.frame = CGRect(x: 0, y: Helpers.screenHeight, width: Helpers.screenWidth, height: 500)
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            modal.frame.origin.y = Helpers.screenHeight  - 500 + modal.layer.cornerRadius
            view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension BankListModal: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfBanks: Int = banks?.count else{
            return 0
        }
        return numberOfBanks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankCell", for: indexPath) as! DynamicTableViewCell
        let bankView = BankView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: tableView.frame.width, height: 60.0)))
        bankView.bank = banks?[indexPath.row]
        bankView.setValues()
        if (bankView.bank == previousSelection){
            bankView.appearSelected()
        }
        
        cell.applyView(view: bankView)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bankDelegate?.bankSelected(selectedBank: banks?[indexPath.row] ?? dummyBank)
        dismiss()
    }
}
