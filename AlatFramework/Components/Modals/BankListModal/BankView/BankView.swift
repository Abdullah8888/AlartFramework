//
//  BankView.swift
//  AlatFramework
//
//  Created by Willi D Lax on 26/02/2023.
//

import UIKit

public class BankView: BaseXib {
    
    let nibName = "BankView"

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bankNameLbl: UILabel!
    @IBOutlet weak var checkBox: UIImageView!
    
    var isSelected: Bool = false
    var bank: BankModel?
    
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
    
    func setValues(){
        bankNameLbl.text = bank?.bankName
    }
    
    func setup(){
        contentView.layer.cornerRadius = 8
        setValues()
    }
    
    func appearSelected(){
        checkBox.image = isSelected ? AlatAssets.uncheckIcon.image : AlatAssets.greenCheckIcon.image
        contentView.layer.borderWidth = isSelected ? 0 : 2
        contentView.layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.alatRed.cgColor
        contentView.backgroundColor = isSelected ? .white : .alatRed.withAlphaComponent(0.09)
        isSelected = !isSelected
        contentView.isUserInteractionEnabled = false
    }
}
