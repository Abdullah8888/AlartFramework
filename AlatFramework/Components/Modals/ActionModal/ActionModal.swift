//
//  ActionModal.swift
//  AlatFramework
//
//  Created by Willi D Lax on 14/03/2023.
//

import UIKit

public class ActionModal: BaseXib {
    let nibName = "ActionModal"

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var closeIcon: UIImageView!
    @IBOutlet weak var actionTable: UITableView!
    
    public var actions: [Action] = []
    public var actionCalled: (Action) -> Void = { _ in }
    
    public var customActions: [CustomAction] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func getNibName() -> String? {
        return nibName
    }
    
    func setup() {
        actionTable.register(DynamicTableViewCell.self, forCellReuseIdentifier: "ActionCell")
        if #available(iOS 15.0, *) {
            actionTable.sectionHeaderTopPadding = 0
        }
        actionTable.sectionHeaderHeight = 17
        
        let closeTapped = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        closeIcon.addGestureRecognizer(closeTapped)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleDismissal))
        swipeDown.direction = .down
        addGestureRecognizer(swipeDown)
    }
    
    @objc func handleDismissal() {
        dismiss()
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            self?.frame.origin.y = Helpers.screenHeight
            self?.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.superview?.removeFromSuperview()
        })
    }
    
    public static func showActions(on view: UIView? = nil, actions: [Action] = [], onActionCalled: @escaping (Action) -> Void = { _ in }, customActions: [CustomAction] = []
    ){
        
        let backDrop = UIView(frame: Helpers.screen)
        backDrop.backgroundColor = .gray.withAlphaComponent(0.5)
        
        let modal = ActionModal()
        modal.actions = actions
        modal.actionCalled = onActionCalled
        modal.customActions = customActions
        modal.layer.cornerRadius = 20
        modal.backgroundColor = .white
        modal.clipsToBounds = true
        backDrop.addSubview(modal)
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.addSubview(backDrop)
        modal.frame = CGRect(x: 0, y: Helpers.screenHeight, width: Helpers.screenWidth, height: 400)
        backDrop.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            modal.frame.origin.y = Helpers.screenHeight  - 300 + modal.layer.cornerRadius
            backDrop.layoutIfNeeded()
        }, completion: nil)
    }
}

extension ActionModal: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return actions.count > 0 ? actions.count : customActions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath) as! DynamicTableViewCell
        let view = SelectableCard(frame: cell.bounds)
        view.actionMode = true
        
        if actions.count > 0 {
            let item = actions[indexPath.section]
            view.model.tilte = item.getTitle()
            view.model.image = item.getImage()
        } else {
            let item = customActions[indexPath.section]
            view.model.tilte = item.title
            view.model.image = item.image
        }
        
        
        view.isUserInteractionEnabled = false
        cell.applyView(view: view)
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect.zero)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if actions.count > 0 {
            actionCalled(actions[indexPath.section])
        } else {
            customActions[indexPath.section].onTapped()
        }
        dismiss()
    }
}

public enum Action {
    case edit
    case delete
    case random
    
    func getImage() -> UIImage {
        switch self {
        case .delete:
            return AlatAssets.deleteIcon.image
        case .edit:
            return AlatAssets.editIcon.image
        case .random:
            return UIImage()
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .delete:
            return "Delete"
        case .edit:
            return "Edit"
        case .random:
            return "Do something"
        }
    }
}

public struct CustomAction {
    public var title: String
    public var image: UIImage
    public var onTapped: () -> Void
    
    public init(title: String, image: UIImage, onTapped: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.onTapped = onTapped
    }
}
