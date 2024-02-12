//
//  ActionNotifcation.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 03/04/2023.
//

@IBDesignable public class ActionNotification: BaseXib {

    @IBOutlet weak var button: UIStackView!
    @IBOutlet weak var subTitle: RegularLabel!
    @IBOutlet weak var title: SemiLabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var counterView: CustomView!
    @IBOutlet weak var notificationCount: RegularLabel!
    //@IBOutlet weak var counter: CircularProgressBar!
    
    public var model: ActionNotificationModel = ActionNotificationModel() {
        didSet { setup() }
    }
    
    @IBInspectable public var titletext: String = "" {
        didSet { model.title = titletext }
    }
    
    @IBInspectable public var subtitletext: String = "" {
        didSet { model.subtitle = subtitletext }
    }
    
    @IBInspectable public var displayImage: UIImage = UIImage() {
        didSet { model.image = displayImage }
    }
    
    @IBInspectable public var useCounter: Bool = false {
        didSet { model.useCounter = useCounter }
    }
    
    @IBInspectable public var count: Int = 0 {
        didSet { model.count = count }
    }
    
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
        subTitle.text = model.subtitle
        image.image = model.image
        
        if model.useCounter {
            image.image = AlatAssets.glitterBackground.image
            counterView.isHidden = false
            notificationCount.text = "\(model.count)"
        } else {
            counterView.isHidden = true
            image.image = AlatAssets.file.image //TODO: Should refactor to a generic image
        }
        
    }
    
    public override func layoutSubviews() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapped(_:))))
    }
    
    @objc func onTapped(_ sender: UITapGestureRecognizer) {
        model.onTapped()
    }
}

public struct ActionNotificationModel {
//    init(title: String, subtitle: String, image: UIImage, useCounter: Bool, count: CGFloat, onTapped: @escaping () -> Void) {
//        self.title = title
//        self.image = image
//        self.subtitle = subtitle
//        self.useCounter = useCounter
//        self.count = count
//        self.onTapped = onTapped
//    }
    public var title: String = ""
    public var subtitle: String = ""
    public var image: UIImage = UIImage()
    public var useCounter: Bool = false
    public var count: Int = 0
    public var onTapped: () -> Void = {}
}

