//
//  SingleDetailView.swift
//  AlatFramework
//
//  Created by Willi D Lax on 08/04/2023.
//

import UIKit

@IBDesignable public class SingleDetailView: BaseXib {
    let nibName = "SingleDetailView"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBInspectable var titleText: String = "Title" {
        didSet{
            setup()
        }
    }
    
    @IBInspectable var valueText: String = "Value" {
        didSet{
            setup()
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
    
    public func setup() {
        titleLabel.text = titleText
        valueLabel.text = valueText
    }
    
    public func setTitleAndValue(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
    
    public func setTitle(title: String) {
        titleLabel.text = title
    }
    
    public func setValue(value: String) {
        valueLabel.text = value
    }
}

