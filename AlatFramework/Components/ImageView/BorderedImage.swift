//
//  BorderedImage.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 19/02/2023.
//

import UIKit

public class BorderedImage: UIImageView {
    
    public override func awakeFromNib() {
        setup()
    }
    
    func setup() {
        layer.cornerRadius = bounds.height / 2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }
}
