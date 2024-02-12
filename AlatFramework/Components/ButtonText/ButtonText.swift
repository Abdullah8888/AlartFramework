//
//  ButtonText.swift
//  AlatFramework
//
//  Created by Willi D Lax on 15/06/2023.
//

import UIKit

@IBDesignable public class ButtonText: BaseXib {
    
    let nibName = "ButtonText"

    @IBOutlet weak var tagLabel: RegularLabel!
    
    @IBInspectable public var tagText: String?{
        set{
            tagLabel.text = newValue
            setup()
        }get{
            return tagLabel.text ?? ""
        }
    }
    @IBInspectable public var identifier: String = "" { didSet {
        self.accessibilityIdentifier = identifier
    } }
    public var onTapped: () -> Void = {}
    
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
        isUserInteractionEnabled = true
        let tapped = UITapGestureRecognizer(target: self, action: #selector(selected))
        addGestureRecognizer(tapped)
    }
    
    @objc func selected(){
        onTapped()
    }
}
