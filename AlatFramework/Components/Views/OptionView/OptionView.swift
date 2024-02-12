//
//  OptionView.swift
//  AlatFramework
//
//  Created by Willi D Lax on 16/02/2023.
//

import UIKit

@IBDesignable public class OptionView: BaseXib {

    let nibName = "OptionView"
    
    public var onSelect: () -> Void = {}
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var optionDescription: LightLabel!
    @IBOutlet weak var optionTitle: RegularLabel!
    @IBOutlet weak var optionImage: UIImageView!
    @IBOutlet weak var numberingText: SemiLabel!
    @IBOutlet weak var mainStack: UIStackView!
    
    @IBInspectable public var identifier: String = "" { didSet {
        self.accessibilityIdentifier = identifier
    } }
    
    @IBInspectable public var optionIcon: UIImage?{
        set{
            optionImage.image = newValue
        }get{
            return optionImage.image
        }
    }
    
    @IBInspectable public var title: String?{
        set{
            optionTitle.text = newValue
        }get{
            return optionTitle.text ?? ""
        }
    }
    
    @IBInspectable public var descriptionText: String?{
        set{
            optionDescription.text = newValue
        }get{
            return optionDescription.text ?? ""
        }
    }
    
    @IBInspectable public var number: String = "" {
        didSet {
            if !number.isEmpty {
                numberingText.isHidden = false
                numberingText.text = number
                mainStack.alignment = .top
                mainStack.spacing = 5
            }
        }
    }
    
    @IBInspectable public var noImage: Bool = false {
        didSet{
            if noImage == true {
                optionImage.isHidden = true
            }
            else{
                optionImage.isHidden = false
            }
        }
    }
    
    public override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setup()
    }
    
    override func getNibName() -> String? {
        return nibName
    }
    
    func setup(){
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.background.cgColor
        contentView.layer.cornerRadius = 10
        isUserInteractionEnabled = true
        let tapped = UITapGestureRecognizer(target: self, action: #selector(selected))
        addGestureRecognizer(tapped)
    }
    
    @objc func selected(){
        onSelect()
    }
}
