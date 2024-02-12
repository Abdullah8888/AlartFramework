//
//  AdminAccountCardView.swift
//  AlatFramework
//
//  Created by Bakare Waris on 18/03/2023.
//

import UIKit

public class AdminAccountCardView: BaseXib {
    
    @IBOutlet weak var accountNamelbl: MediumLabel!
    @IBOutlet weak var accountNumberlbl: SemiLabel!
    @IBOutlet weak var tapToCopyBtn: UIButton!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var usersLabel: SemiLabel!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var cardBgback: UIImageView!
    @IBOutlet weak var cardBg: UIImageView!
    @IBOutlet weak var state: SemiLabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
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
    
    @IBAction func copyTapped(_ sender: Any) {
        UIPasteboard.general.string = model.accountNo
        Toast.show(message: "Account number copied")
    }
    
    func setup() {
        let image = UIImage(named: "users")?.withRenderingMode(.alwaysTemplate)
        userImage.image = image
        userImage.tintColor = .white
//        state.text = model.state
        accountNumberlbl.text = model.accountNo
//        accountBalance.text = model.accountBalance
        accountNamelbl.text = model.accountName
        cardBg.image = model.backImage
        cardBgback.image = model.backImageSwitch
        yesBtn.layer.cornerRadius = 4
        imageContainerView.layer.cornerRadius = 5
        imageContainerView.backgroundColor = .clear
    }
    
    func switchBG(_ isPrimary: Bool = true) {
        cardBg.isHidden = false
        cardBg.alpha = 1.0
        cardBg.image = isPrimary ? AlatAssets.cardBg2.image : AlatAssets.cardBg.image
        cardBgback.image = isPrimary ? AlatAssets.cardBg.image : AlatAssets.cardBg2.image
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.cardBg.alpha = 0.0
        }, completion: { [weak self] finished in
            if finished {
                self?.cardBg.isHidden = true
            }
        })
    }
    
}
