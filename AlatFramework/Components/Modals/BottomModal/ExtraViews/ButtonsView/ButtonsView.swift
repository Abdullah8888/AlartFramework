//
//  ButtonsView.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 13/03/2023.
//

public class ButtonsView: BaseXib {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var recieptButton: RegularLabel!
    @IBOutlet weak var beneficiaryButton: RegularLabel!
    @IBOutlet weak var shareButton: RegularLabel!
    @IBOutlet weak var schedulebutton: RegularLabel!
    @IBOutlet weak var breakdownButton: RegularLabel!
    @IBOutlet weak var groupButton: RegularLabel!
    @IBOutlet weak var twoLinkStack: UIStackView!
    @IBOutlet weak var normalStack: UIStackView!
    
    public var onButtonTapped: (Buttontype) -> Void = { _ in }
    
    public enum Buttontype {
        case reciept, beneficiary, share, schedule, breakdown, group
    }
    
    public override func layoutSubviews() {
        recieptButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(recieptTapped(_:))))
        beneficiaryButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(beneficiaryTapped(_:))))
        shareButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareTapped(_:))))
        schedulebutton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scheduleTapped(_:))))
        breakdownButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(breakdownTapped(_:))))
        groupButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(groupTapped(_:))))
    }
    
    @objc func recieptTapped(_ sender: UITapGestureRecognizer) {
        onButtonTapped(.reciept)
    }
    
    @objc func beneficiaryTapped(_ sender: UITapGestureRecognizer) {
        onButtonTapped(.beneficiary)
    }
    
    @objc func shareTapped(_ sender: UITapGestureRecognizer) {
        onButtonTapped(.share)
    }
    
    @objc func scheduleTapped(_ sender: UITapGestureRecognizer) {
        onButtonTapped(.schedule)
    }
    
    @objc func breakdownTapped(_ sender: UITapGestureRecognizer) {
        onButtonTapped(.breakdown)
    }
    
    @objc func groupTapped(_ sender: UITapGestureRecognizer) {
        onButtonTapped(.group)
    }
    
    func getHeight() -> CGFloat {
        stackView.bounds.height
    }
    
    public func setupTwoLink(link1: String? = nil, link2: String? = nil){
        normalStack.isHidden = true
        twoLinkStack.isHidden = false
        if let link1Text = link1 { breakdownButton.text = link1Text }
        if let link2Text = link2 { groupButton.text = link2Text }
    }
    
    public func setupReceiptLinks() {
        beneficiaryButton.isHidden = true
        schedulebutton.isHidden = true
    }
}


