//
//  SegmentOptionView.swift
//  AlatFramework
//
//  Created by Willi D Lax on 04/03/2023.
//

import UIKit

@IBDesignable public class SegmentOptionView: BaseXib {
    let nibName = "SegmentOptionView"
    
    public var onSelect: () -> Void = {}

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak public var segmentImage: UIImageView!
    @IBOutlet weak var titleLbl: SemiLabel!
    @IBOutlet weak var indicatorView: UIView!
    
    @IBInspectable public var identifier: String = "" { didSet {
        self.accessibilityIdentifier = identifier
    } }
    
    @IBInspectable var segmentIcon: UIImage?{
        set{
            segmentImage.isHidden = false
            segmentImage.image = newValue
        }get{
            return segmentImage.image
        }
    }
    
    @IBInspectable public var title: String?{
        set{
            titleLbl.text = newValue
        }get{
            return titleLbl.text ?? ""
        }
    }
    
    @IBInspectable public var isSelected: Bool = false {
         didSet {
             if isSelected {
                 indicatorView.backgroundColor = .alatRed
             } else {
                 indicatorView.backgroundColor = .greyLight
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
        isUserInteractionEnabled = true
        let tapped = UITapGestureRecognizer(target: self, action: #selector(selected))
        addGestureRecognizer(tapped)
    }
    
    @objc func selected(){
        if(!isSelected){
            appearSelected()
            onSelect()
        }
    }
    
    public func appearSelected(){
        indicatorView.backgroundColor = .alatRed
    }
}
