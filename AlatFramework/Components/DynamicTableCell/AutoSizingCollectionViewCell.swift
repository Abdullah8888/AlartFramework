//
//  AutoSizingCollectionViewCell.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 13/04/2023.
//

import UIKit
public class AutoSizingTableViewCell: UITableViewCell {
    public func applyView(view: Sizeable) {
        self.subviews.forEach({ $0.removeFromSuperview() })
        self.addSubview(view)
        view.pinView(to: self)
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: view.getHeight()).isActive = true
    }
}

public protocol Sizeable: UIView {
    func getHeight() -> CGFloat
}
