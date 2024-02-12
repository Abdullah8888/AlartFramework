//
//  SearchField.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 03/02/2023.
//

import UIKit

@IBDesignable public class SearchField: InputField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setup() {
        super.setup()
        setSearchImage()
        
    }
    
    func setSearchImage() {
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 12))
        let imageView = UIImageView(frame: CGRect(x: 12, y: 0, width: 12, height: 12))
        imageView.image = AlatAssets.search.image
        imageView.tintColor = .background
        imageView.contentMode = .scaleAspectFit
        iconContainer.addSubview(imageView)
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = iconContainer
    }
}
