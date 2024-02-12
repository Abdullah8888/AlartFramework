//
//  AlatPayView.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 16/03/2023.
//

class AlatPayView: BaseXib {
    
    @IBOutlet weak var contentStack: UIStackView!
    @IBOutlet weak var copyStack: UIStackView!
    @IBOutlet weak var accountLabel: SemiLabel!
    @IBOutlet weak var amountLabel: SemiLabel!
    
    public var model = AlatPayViewModel() {
        didSet {
            setup()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        copyStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(copyTapped(_:))))
    }
    
    @objc func copyTapped(_ sender: UITapGestureRecognizer) {
        UIPasteboard.general.string = model.account
        Toast.show(message: "Account number copied")
    }
    
    func setup() {
        amountLabel.text = model.amount
        accountLabel.text = model.account
    }
    
    func getHeight() -> CGFloat {
        contentStack.bounds.height
    }
}

struct AlatPayViewModel {
    var amount: String = ""
    var account: String = ""
}
