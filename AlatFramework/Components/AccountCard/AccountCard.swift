//
//  AccountCard.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 18/02/2023.
//

import UIKit

public class AccountCard: BaseXib {
    
    @IBOutlet weak var cardBgBack: UIImageView!
    @IBOutlet private weak var state: SemiLabel!
    @IBOutlet private weak var accountNo: SemiLabel!
    @IBOutlet private weak var accountBalance: BoldLabel!
    @IBOutlet private weak var accountName: MediumLabel!
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var cardBg: UIImageView!
    @IBOutlet weak var normalButtonsStack: UIStackView!
    @IBOutlet weak var reactivateBtn: WhiteButton!
    @IBOutlet weak var ledgerBalance: RegularLabel!
    
    public var model: AccountCardModel = AccountCardModel() {
        didSet {
            setup()
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
    
    @IBAction func historyTapped(_ sender: Any) {
        model.historyTapped()
    }
    
    @IBAction func hideTapped(_ sender: Any) {
        let hideText = "*******"
        if accountBalance.text == hideText {
            UserDefaults.standard.set(false, forKey: model.accountNo)
            hideButton.setImage(AlatAssets.eyeOff.image, for: .normal)
            accountBalance.text = model.accountBalance
            ledgerBalance.text = model.ledgerBalance
        } else {
            UserDefaults.standard.set(true, forKey: model.accountNo)
            hideButton.setImage(AlatAssets.eyeOn.image, for: .normal)
            accountBalance.text = hideText
            ledgerBalance.text = hideText
        }
    }
    
    @IBAction func reactivateTapped(_ sender: Any) {
        model.reactivateTapped()
    }
    
    @IBAction func fundTapped(_ sender: Any) {
        model.fundTapped()
    }
    
    @IBAction func copyTapped(_ sender: Any) {
        UIPasteboard.general.string = model.accountNo
        Toast.show(message: "Account number copied")
    }
    
    func setup() {
        state.text = model.state
        accountNo.text = model.accountNo
        accountBalance.text = model.accountBalance
        accountName.text = model.accountName
        cardBg.image = model.backImage
        cardBgBack.image = model.backImageSwitch
        let isHidden = UserDefaults.standard.bool(forKey: model.accountNo)
        if !isHidden {
            hideButton.setImage(AlatAssets.eyeOff.image, for: .normal)
            accountBalance.text = model.accountBalance
            ledgerBalance.text = model.ledgerBalance
        } else {
            hideButton.setImage(AlatAssets.eyeOn.image, for: .normal)
            accountBalance.text = "*****"
            ledgerBalance.text = "*****"
        }
        setState(state: model.state)
    }
    
    func switchBG(_ isPrimary: Bool = true) {
        cardBg.isHidden = false
        cardBg.alpha = 1.0
        cardBg.image = isPrimary ? AlatAssets.cardBg2.image : AlatAssets.cardBg.image
        cardBgBack.image = isPrimary ? AlatAssets.cardBg.image : AlatAssets.cardBg2.image
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.cardBg.alpha = 0.0
        }, completion: { [weak self] finished in
            if finished {
                self?.cardBg.isHidden = true
            }
        })
    }
    
    func setState(state: String) {
        if state.caseInsensitiveCompare("inactive") == .orderedSame || state.caseInsensitiveCompare("dormant") == .orderedSame {
            reactivateBtn.isHidden = false
            normalButtonsStack.isHidden = true
        }
        else if state.caseInsensitiveCompare("deactivated") == .orderedSame {
            reactivateBtn.isHidden = true
            normalButtonsStack.isHidden = true
        }
    }
}

public struct AccountCardModel {
    public var accountNo: String = ""
    public var accountBalance: String = ""
    public var ledgerBalance: String = ""
    public var accountName: String = ""
    public var state: String = ""
    public var backImage: UIImage = AlatAssets.cardBg.image
    public var backImageSwitch: UIImage = AlatAssets.cardBg.image
    public var fundTapped: () -> Void = {}
    public var historyTapped: () -> Void = {}
    public var reactivateTapped: () -> Void = {}
}
