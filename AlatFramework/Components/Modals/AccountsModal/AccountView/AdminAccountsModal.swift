//
//  AdminAccountsModal.swift
//  AlatFramework
//
//  Created by Bakare Waris on 31/03/2023.
//

import UIKit

public class AdminAccountsModal: BaseXib {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var proceedBtn: PrimaryButton!
    @IBOutlet weak var contentView: CustomView!
    
    var accountDelegate: IAccountSelectedDelegate?
    
    var accounts: [AccountModel] = []
    let dummyAccount: AccountModel = AccountModel(accountId: "", currency: "", balance: 0, accountName: "", accountNo: "", accountDescription: "", accountStatus: "")
    
    var isMultiple: Bool?
    var listOfAccount: [AccountModel] = []
    var previousSelection: [AccountModel] = []
    var soleAccount: Bool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            self?.frame.origin.y = Helpers.screenHeight
            self?.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.superview?.removeFromSuperview()
        })
    }
    
    func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 16
        flowLayout.itemSize = CGSize(width: collectionView.bounds.width, height: 114)
        collectionView.collectionViewLayout = flowLayout
        collectionView.register(DynamicCollectionViewCell.self, forCellWithReuseIdentifier: "dynamicCell")
        collectionView.allowsMultipleSelection = true
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleDismissal))
        swipeDown.direction = .down
        addGestureRecognizer(swipeDown)
        listOfAccount = previousSelection
    }
    
    @objc func handleDismissal() {
        dismiss()
    }
    
    @IBAction func proceedTapped(_ sender: Any) {
        accountDelegate?.listOfAccountSelected(accounts: listOfAccount)
        dismiss()
    }
    
    
    public static func startAccountSelection(on view: UIView, accounts accountList: [AccountModel], delegate del: IAccountSelectedDelegate, title prompt: String, previousSelection selectedAccount: [AccountModel], isMultiple multipleselection: Bool, isSoleAccount: Bool?) {
        
        let backDrop = UIView(frame: Helpers.screen)
        backDrop.backgroundColor = .gray.withAlphaComponent(0.5)
        
        let modal = AdminAccountsModal()
        modal.accountDelegate = del
        modal.accounts = accountList
        modal.previousSelection = selectedAccount
        modal.isMultiple = multipleselection
        modal.soleAccount = isSoleAccount
        modal.listOfAccount = selectedAccount
//        modal.modalTitle.text = prompt
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

extension AdminAccountsModal: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accounts.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "dynamicCell", for: indexPath) as! DynamicCollectionViewCell
        cell.isUserInteractionEnabled = true
        if soleAccount == true {
            let accountView = AccountView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: collectionView.frame.width, height: 114.0)))
            accountView.account = accounts[indexPath.item]
            
            for account in previousSelection  {
                if accountView.account == account {
                    accountView.appearSelected()
                }
            }
            accountView.setValues(anAccount: accounts[indexPath.item])
            cell.applyView(view: accountView)
        } else {
            let accountView = AdminAccountListView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: collectionView.frame.width, height: 114.0)))
            accountView.account = accounts[indexPath.item]
//            if accounts == previousSelection {
//                accountView.model.state = true
//            }
            for account in previousSelection  {
                if accountView.account == account {
                    accountView.appearSelected()
                }
            }
            accountView.setValues(anAccount: accounts[indexPath.item] )
            cell.applyView(view: accountView)
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 120)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        guard let subviews = cell?.subviews else { return }
        if soleAccount == true {
            for view in subviews {
                if view is AccountView {
                    let v = view as! AccountView
                    if previousSelection.contains(accounts[indexPath.item]) {
                        v.model.state = false
                        previousSelection.removeAll { model in
                            model.accountId == accounts[indexPath.item].accountId
                        }
                        listOfAccount = previousSelection
                    } else {
                        v.model.state = true
                        listOfAccount.append(accounts[indexPath.item])
                    }
                }
            }
        } else {
            for view in subviews {
                if view is AdminAccountListView {
                    let v = view as! AdminAccountListView
//                    if accounts == previousSelection {
//                        v.model.state = false
//                    } else {
//                        v.model.state = true
//                        listOfAccount.append(accounts[indexPath.item])
//                    }
                    if previousSelection.contains(accounts[indexPath.item]) {
                        v.model.state = false
                        previousSelection.removeAll { model in
                            model.accountId == accounts[indexPath.item].accountId
                        }
                        listOfAccount = previousSelection
                    } else {
                        v.model.state = true
                        listOfAccount.append(accounts[indexPath.item])
                    }
                }
            }
        }
        
       
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        guard let subviews = cell?.subviews else { return }
        if soleAccount == true {
            for view in subviews {
                if view is AccountView {
                    let v = view as! AccountView
                    v.model.state = false
                    listOfAccount.removeAll { model in
                        model.accountId == accounts[indexPath.item].accountId
                    }
                }
            }
        } else {
            for view in subviews {
                if view is AdminAccountListView {
                    let v = view as! AdminAccountListView
//                    v.model.state = false
                    v.model.state = false
                    listOfAccount.removeAll { model in
                        model.accountId == accounts[indexPath.item].accountId
                    }
                }
            }
        }

    }
    
}
