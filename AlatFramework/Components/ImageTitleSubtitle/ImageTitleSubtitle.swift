//
//  ImageTitleSubtitle.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 26/02/2023.
//

import UIKit

@IBDesignable public class ImageTitleSubtitle: BaseXib {
    
    @IBOutlet weak var subtitle: LightLabel!
    @IBOutlet weak var title: MediumLabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBInspectable var titleText: String = "" {
        didSet { model.tilte = titleText }
    }
    
    @IBInspectable var subtitleText: String = "" {
        didSet { model.subtitle = subtitleText }
    }
    
    @IBInspectable var displayImage: UIImage = UIImage() {
        didSet { model.image = displayImage }
    }
    
    var model: ImageTitleSubtitleModel = ImageTitleSubtitleModel() {
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
    
    public override  func awakeFromNib() {
        updateHeight()
    }
    
    func setup() {
        backgroundColor = .clear
        title.text = model.tilte
        subtitle.text = model.subtitle
        image.image = model.image
        updateHeight()
    }
}

public struct ImageTitleSubtitleModel {
    var tilte: String = ""
    var subtitle: String = ""
    var image: UIImage = UIImage()
}
