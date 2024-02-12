//
//  DetailsView.swift
//  AlatFramework
//
//  Created by Bakare Waris on 05/07/2023.
//

import Foundation

class DetailsView: BaseXib {
    
    @IBOutlet weak public var detailsLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    public var model = DetailViewModel() {
        didSet {
            setUp()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func getHeight() -> CGFloat {
        detailsLabel.bounds.height + 64
    }
    
    func setUp() {
        detailsLabel.text = model.details
    }
}

struct DetailViewModel {
    var details: String = ""
}
