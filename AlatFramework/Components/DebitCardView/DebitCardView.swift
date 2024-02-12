//
//  DebitCardView.swift
//  AlatFramework
//
//  Created by Willi D Lax on 15/08/2023.
//

import UIKit

@IBDesignable public class DebitCardView: BaseXib {

    let nibName = "DebitCardView"
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cardNameLbl: BoldLabel!
    @IBOutlet weak var cardPanLbl: BoldLabel!
    @IBOutlet weak var expDateLbl: BoldLabel!
    
    override init(frame: CGRect) {
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
    }
    
    public func setCardDetails(card: DebitCardModel) {
        cardNameLbl.text = card.cardName
        cardPanLbl.text = card.cardPan
        expDateLbl.text = card.expDate
    }
}
