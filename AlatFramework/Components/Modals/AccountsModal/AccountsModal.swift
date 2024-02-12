//
//  AccountsModal.swift
//  AlatFramework
//
//  Created by Willi D Lax on 20/02/2023.
//

import UIKit

public protocol IAccountSelectedDelegate{
    func accountSelected(account selectedAccount: AccountModel)
    func listOfAccountSelected(accounts SelectedAccounts: [AccountModel])
}


public class AccountsModal: BaseXib {
    let nibName = "AccountsModal"
    
    var accountDelegate: IAccountSelectedDelegate?
//    var listOfAccountDelegate: ListOfAccountSelectedDelegate?
    
    @IBOutlet weak var modalTitle: BoldLabel!
    @IBOutlet weak var cancelIcon: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var accountTable: UITableView!
    var accounts: [AccountModel]?
    let dummyAccount: AccountModel = AccountModel(accountId: "", currency: "", balance: 0, accountName: "", accountNo: "", accountDescription: "", accountStatus: "")
    var previousSelection: AccountModel?
    var isMultiple: Bool?

    var listOfAccount: [AccountModel] = []
    override init(frame: CGRect) {
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
    
    func setup(){
        accountTable.register(DynamicTableViewCell.self, forCellReuseIdentifier: "AccountCell")
        if #available(iOS 15.0, *) {
            accountTable.sectionHeaderTopPadding = 0
        }
        accountTable.sectionHeaderHeight = 20
        
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
    
    public static func startAccountSelection(on view: UIView, accounts accountList: [AccountModel], delegate del: IAccountSelectedDelegate, title prompt: String, previousSelection selectedAccount: AccountModel, isMultiple multipleselection: Bool){
        
        let backDrop = UIView(frame: Helpers.screen)
        backDrop.backgroundColor = .gray.withAlphaComponent(0.5)
        
        let modal = AccountsModal()
        modal.accountDelegate = del
        modal.accounts = accountList
        modal.previousSelection = selectedAccount
        modal.isMultiple = multipleselection
        modal.modalTitle.text = prompt
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

extension AccountsModal: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let numberOfAccounts: Int = accounts?.count else{
            return 0
        }
       
        return numberOfAccounts
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! DynamicTableViewCell
        
        let accountView = AccountView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: tableView.frame.width, height: 114.0)))
        accountView.identifier = "Account cell " + indexPath.description
        accountView.account = accounts?[indexPath.section]
        accountView.setValues(anAccount: accountView.account ?? dummyAccount)
        if (accountView.account == previousSelection){
            accountView.appearSelected()
        }
        cell.applyView(view: accountView)
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect.zero)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentCell = tableView.cellForRow(at: indexPath) as! DynamicTableViewCell
        accountDelegate?.accountSelected(account: accounts?[indexPath.section] ?? dummyAccount)
        dismiss()
    }
    
}

