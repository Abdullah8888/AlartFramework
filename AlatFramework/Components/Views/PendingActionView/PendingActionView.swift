//
//  PendingActionView.swift
//  AlatFramework
//
//  Created by Willi D Lax on 21/03/2023.
//

import UIKit

public class PendingActionView: BaseXib {
    let nibName = "PendingActionView"
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var countCircle: CustomView!
    @IBOutlet weak var countLbl: UILabel!
    
    public var actionToTake: () -> Void = {}
    
    public override init(frame: CGRect) {
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
        contentView.layer.cornerRadius = 8
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tap)
    }
    
    @objc func tapped(){
        actionToTake()
    }
    
    public func setAction(action: ActionModel){
        title.text = action.title
        message.text = action.message
        countLbl.text = action.actionsCount > 99 ? String(action.actionsCount) + "+" : String(action.actionsCount)
    }
}

public struct ActionModel{
    public var title: String
    public var message: String
    public var actionsCount: Int
    
    public init(title: String, message: String, actionsCount: Int) {
        self.title = title
        self.message = message
        self.actionsCount = actionsCount
    }
}
