//
//  TransactionHistoryCard.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 08/04/2023.
//

public class TransactionHistoryCard: BaseXib {
    
    @IBOutlet weak private var date: LightLabel!
    @IBOutlet weak private var amount: MediumLabel!
    @IBOutlet weak private var subtitle: LightLabel!
    @IBOutlet weak private var title: MediumLabel!
    
    public var model: TransactionHistoryCardModel = TransactionHistoryCardModel() {
        didSet { setup() }
    }
    
    @IBInspectable var titleText: String = "" { didSet { model.title = titleText }}
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        title.text = model.title
        subtitle.text = model.subtitle
        amount.text = "\(model.type == .credit ? "+" : "-")\(model.amount)"
        date.text = model.date
        amount.textColor = model.type == .credit ? .success : .error
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapped)))
    }
    
    @objc func onTapped() {
        model.onTapped()
    }
}

public struct TransactionHistoryCardModel {
    public var title: String = ""
    public var subtitle: String = ""
    public var amount: String = ""
    public var date: String = ""
    public var type: CreditType = .credit
    public var onTapped: () -> Void = {}
}

public enum CreditType: String {
    case credit = "Credit"
    case debit = "Debit"
}
