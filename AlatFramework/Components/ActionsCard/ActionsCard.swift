//
//  ActionsCard.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 04/04/2023.
//

@IBDesignable public class ActionsCard: BaseXib {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: MediumLabel!
    @IBOutlet weak var subtitle: RegularLabel!
    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var stateIndicator: PaddedLabel!
    
    public var model: ActionCardModel = ActionCardModel() {
        didSet { setup() }
    }
    
    public enum State {
        case accepted, pending, error, none
    }
    
    @IBInspectable var titleText: String = "" { didSet{ model.title = titleText} }
    @IBInspectable var subtitleText: String = "" { didSet{ model.subtitle = subtitleText} }
    @IBInspectable var iconImage: UIImage = UIImage() { didSet{ model.icon = iconImage} }
    @IBInspectable var showDots: Bool = true { didSet{ model.hasActions = showDots } }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func optionButtonTapped(_ sender: Any) {
        ActionModal.showActions(customActions: model.customActions)
    }
    
    func setup() {
        title.text = model.title
        subtitle.text = model.subtitle
        icon.image = model.icon
        optionButton.setTitle("", for: .normal)
        optionButton.isHidden = !model.hasActions
        
        switch model.state {
        case .accepted:
            stateIndicator.colorType = .success
            stateIndicator.text = "ACCEPTED"
            stateIndicator.isHidden = false
        case .pending:
            stateIndicator.colorType = .pending
            stateIndicator.text = "PENDING REVIEW"
            stateIndicator.isHidden = false
        case .error:
            stateIndicator.colorType = .red
            stateIndicator.text = model.error
            stateIndicator.isHidden = false
        default:
            stateIndicator.isHidden = true
        }
        
        updateHeight()
    }
}

public struct ActionCardModel {
    public var title: String = ""
    public var subtitle: String = ""
    public var icon: UIImage = UIImage()
    public var hasActions: Bool = true
    public var state: ActionsCard.State = .none
    public var customActions: [CustomAction] = []
    public var error: String = ""
}
