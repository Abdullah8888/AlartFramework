//
//  NoAccountCard.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 17/03/2023.
//

public class NoAccountCard: BaseXib {
    @IBOutlet weak var titleLabel: MediumLabel!
    @IBOutlet weak var actionBtn: WhiteButton!
    @IBOutlet weak var subtitleLabel: RegularLabel!
    
    public var model: NoCardModel = NoCardModel() {
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
    
    
    @IBAction func refreshTapped(_ sender: Any) {
        model.onRefresh()
    }
    
    func setup() {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        actionBtn.setTitle(model.buttonText, for: .normal)
        
    }
}

public struct NoCardModel {
    public var title: String = "We are currently setting up your account"
    public var subtitle: String = "Complete pending action for your account number to be generated"
    public var buttonText: String = "Proceed"
    public var onRefresh: () -> Void = {}
}
