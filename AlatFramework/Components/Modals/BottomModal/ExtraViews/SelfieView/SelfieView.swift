//
//  SelfieView.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 12/03/2023.
//

class SelfieView: BaseXib {
    @IBOutlet weak var stackView: UIStackView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func getHeight() -> CGFloat {
        stackView.bounds.height + 64
    }
}
