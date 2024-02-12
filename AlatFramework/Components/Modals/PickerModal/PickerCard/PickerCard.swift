//
//  PickerCard.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 14/04/2023.
//

class PickerCard: UITableViewCell {
    @IBOutlet weak var checkbox: CheckboxButton!
    @IBOutlet weak var title: MediumLabel!
    
    var titleText: String = ""
    
    var state: Bool = false 
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        title.text = titleText
        setState()
    }
    
    func setState() {
        if state {
            layer.borderColor = UIColor.alatRed.cgColor
            backgroundColor = .alatRedLight
            checkbox.isChecked = true
        } else {
            layer.borderColor = UIColor.greyLight.darker(by: 8)?.cgColor
            backgroundColor = .greyLight
            checkbox.isChecked = false
        }
    }
}
