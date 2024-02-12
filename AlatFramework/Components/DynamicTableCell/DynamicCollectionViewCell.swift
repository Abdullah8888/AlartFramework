//
//  DynamicCell.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 28/02/2023.
//

import UIKit
public class DynamicCollectionViewCell: UICollectionViewCell {
    public func applyView(view: UIView) {
        self.subviews.forEach({ $0.removeFromSuperview() })
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
