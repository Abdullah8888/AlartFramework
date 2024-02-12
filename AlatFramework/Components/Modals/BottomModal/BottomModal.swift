//
//  BottomModal.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 04/02/2023.
//

import UIKit

@IBDesignable public class BottomModal: BaseXib {

    @IBOutlet weak var extraViewSpacer: UIView!
    @IBOutlet weak var tetiaryStack: UIStackView!
    @IBOutlet weak var extraViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var etraViewLeading: NSLayoutConstraint!
    @IBOutlet weak var extraViewStack: UIStackView!
    @IBOutlet weak var tetiaryText: PaddedLabel!
    @IBOutlet weak var extraViewHeight: NSLayoutConstraint!
    @IBOutlet weak var subtitleHeight: NSLayoutConstraint!
    @IBOutlet weak var cancelButton: PlainButton!
    @IBOutlet weak var confirmButton: PrimaryButton!
    @IBOutlet weak var extraView: UIView!
    @IBOutlet weak var subtitle: RegularLabel!
    @IBOutlet weak var title: BoldLabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var contentStack: UIStackView!
    @IBOutlet weak var backView: UIView!

    var model: BottomMoodalModel = BottomMoodalModel() {
        didSet {
            setup(model)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup(model)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup(model)
    }
    
    @IBAction func onConfirmTapped(_ sender: Any) {
        model.onConfirm()
        if model.dismissOnConfirm {
            dismiss()
        }
    }
    
    @IBAction func onCancelTapped(_ sender: Any) {
        model.onCancel()
        dismiss()
    }
    
    func setup(_ model: BottomMoodalModel) {
       // subtitle.textAlignment = .justified
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
        swipeDown.direction = .down
        addGestureRecognizer(swipeDown)
        cancelButton.isHidden = model.secondaryText.isEmpty
        title.text = model.modalTitle
        subtitle.text = model.modalSubtitle
        tetiaryText.text = model.tetiaryTitle
        tetiaryStack.isHidden = model.tetiaryTitle.isEmpty
        cancelButton.setTitle(model.secondaryText, for: .normal)
        confirmButton.setTitle(model.primaryText, for: .normal)
        icon.image = model.modalType.getImage()
        extraViewStack.isHidden = true
    }
    
    @objc func handleSwipeDown() {
        if model.dismissable {
            print(model.dismissable)
            dismiss()
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            self?.frame.origin.y = Helpers.screenHeight
            self?.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.superview?.removeFromSuperview()
        })
    }

    func getHeight() -> CGFloat {
        var contentHeight = 120.0
        contentHeight += !icon.isHidden ? icon.bounds.height + 10.0 : 0
        contentHeight += !title.isHidden ? title.bounds.height + 10.0 : 0
        contentHeight += !subtitle.isHidden ? subtitle.bounds.height + 10.0 : 0
        contentHeight += !extraViewStack.isHidden ? extraViewStack.bounds.height + 10.0 : 0
        contentHeight += !confirmButton.isHidden ? confirmButton.bounds.height + 10.0 : 0
        contentHeight += !cancelButton.isHidden ? cancelButton.bounds.height + 10.0 : 0
        contentHeight += !tetiaryStack.isHidden ? tetiaryStack.bounds.height + 12.0 : 0
        
        return contentHeight
    }
    
    func setupSelfieView() {
        extraView.backgroundColor = .clear
        extraViewTrailing.constant = 20
        etraViewLeading.constant = 20
        extraViewStack.isHidden = false
        let selfieView = SelfieView(frame: .infinite)
        extraViewHeight.constant = selfieView.getHeight()
        extraView.addSubview(selfieView)
        selfieView.pinView(to: extraView)
    }
    
    func setupSuccessLinks() {
        if let view = model.extraView as? ButtonsView {
            extraViewStack.isHidden = false
            extraView.backgroundColor = .clear
            extraViewHeight.constant = view.getHeight()
            extraView.addSubview(view)
            extraViewTrailing.constant = 0
            etraViewLeading.constant = 0
            view.pinView(to: extraView)
        }
    }
    
    func setupSuccessDetails(_ view: DetailsView?) {
        if let view = view {
            extraView.backgroundColor = .clear
            extraViewTrailing.constant = 20
            etraViewLeading.constant = 20
            extraViewStack.isHidden = false
            extraViewHeight.constant = view.getHeight()
            extraView.addSubview(view)
            view.pinView(to: extraView)
        }
//        extraView.backgroundColor = .clear
//        extraViewTrailing.constant = 20
//        etraViewLeading.constant = 20
//        extraViewStack.isHidden = false
//        let selfieView = DetailsView(frame: .infinite)
//        selfieView.detailsLabel.text = "Your transaction will be processed within 24 hours, kindly confirm status with the reference no below"
//        extraViewHeight.constant = selfieView.getHeight()
//        extraView.addSubview(selfieView)
//        selfieView.pinView(to: extraView)
    }
    
    func setupAlatPay(_ view: AlatPayView?) {
        if let view = view {
            extraView.backgroundColor = .clear
            extraViewTrailing.constant = 20
            etraViewLeading.constant = 20
            extraViewStack.isHidden = false
            extraViewSpacer.isHidden = true
            extraViewHeight.constant = view.getHeight()
            extraView.addSubview(view)
            view.pinView(to: extraView)
        }
    }
    
    func showSecurity(_ view: SecurityView?) {
        if let view = view {
            extraView.backgroundColor = .clear
            extraViewTrailing.constant = 20
            etraViewLeading.constant = 20
            extraViewStack.isHidden = false
            extraViewSpacer.isHidden = true
            extraViewHeight.constant = view.getHeight()
            extraView.addSubview(view)
            view.pinView(to: extraView)
        }
    }
    
    func setupSoftToken(_ view: PasswordField?) {
        if let view = view {
            extraView.backgroundColor = .clear
            extraViewTrailing.constant = 20
            etraViewLeading.constant = 20
            extraViewStack.isHidden = false
//            extraViewSpacer.isHidden = true
            icon.isHidden = true
            extraViewHeight.constant = 75
            extraView.addSubview(view)
            view.pinView(to: extraView)
        }
    }
    
    public static func show(
        title: String = "",
        subtitle: String = "",
        tetiaryTitle: String = "",
        extraView: UIView? = nil,
        type: ModalType = .caution,
        icon: UIImage = UIImage(),
        primaryText: String = "Okay",
        secondaryText: String = "",
        dismissable: Bool = true,
        dismissOnConfirm: Bool = true,
        onConfirm: @escaping () -> Void = {},
        onCancel: @escaping () -> Void = {})
    {
        _ = handleShow(title: title, subtitle: subtitle, tetiaryTitle: tetiaryTitle, extraView: extraView, type: type, icon: icon, primaryText: primaryText, secondaryText: secondaryText, dismissable: dismissable, dismissOnConfirm: dismissOnConfirm, onConfirm: onConfirm, onCancel: onCancel)
    }
    
    public static func showV2 (
        title: String = "",
        subtitle: String = "",
        tetiaryTitle: String = "",
        extraView: UIView? = nil,
        type: ModalType = .caution,
        icon: UIImage = UIImage(),
        primaryText: String = "Okay",
        secondaryText: String = "",
        dismissable: Bool = true,
        dismissOnConfirm: Bool = true,
        onConfirm: @escaping () -> Void = {},
        onCancel: @escaping () -> Void = {})  -> UIView
    {
        return handleShow(title: title, subtitle: subtitle, tetiaryTitle: tetiaryTitle, extraView: extraView, type: type, icon: icon, primaryText: primaryText, secondaryText: secondaryText, dismissable: dismissable, dismissOnConfirm: dismissOnConfirm, onConfirm: onConfirm, onCancel: onCancel)
    }
    
    public static func handleShow (
        title: String = "",
        subtitle: String = "",
        tetiaryTitle: String = "",
        extraView: UIView? = nil,
        type: ModalType = .caution,
        icon: UIImage = UIImage(),
        primaryText: String = "Okay",
        secondaryText: String = "",
        dismissable: Bool = true,
        dismissOnConfirm: Bool = true,
        onConfirm: @escaping () -> Void = {},
        onCancel: @escaping () -> Void = {}) -> UIView
    {
        let backDrop = BottomModalView(frame: Helpers.screen)
        backDrop.backgroundColor = .clear
        
        backDrop.applyDarkEffect()
        let modal = BottomModal(frame: CGRect(x: 0, y: 0, width: Helpers.screenWidth, height: 500))
        modal.model = BottomMoodalModel(
            modalTitle: title,
            modalSubtitle: subtitle,
            tetiaryTitle: tetiaryTitle,
            extraView: extraView,
            primaryText: primaryText,
            secondaryText: secondaryText,
            modalType: type,
            dismissable: dismissable,
            dismissOnConfirm: dismissOnConfirm,
            onConfirm: onConfirm,
            onCancel: onCancel)
        modal.icon.image = type == .defaultModal ? icon : type.getImage()
        modal.layer.cornerRadius = 12
        modal.backgroundColor = .white
        modal.clipsToBounds = true
        
        switch type {
        case .selfie:
            modal.setupSelfieView()
        case .successWithLinks:
            modal.setupSuccessLinks()
        case .alatPay:
            modal.setupAlatPay(extraView as? AlatPayView)
        case .securiy:
            modal.showSecurity(extraView as? SecurityView)
        case .successWithDetails:
            modal.setupSuccessDetails(extraView as? DetailsView)
        case .softoken:
            modal.setupSoftToken(extraView as? PasswordField)
        default:
            break
        }
        
        backDrop.addSubview(modal)
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.addSubview(backDrop)
        modal.frame = CGRect(x: 0, y: Helpers.screenHeight, width: Helpers.screenWidth, height: modal.getHeight())
        modal.subtitleHeight.isActive = false
        backDrop.layoutIfNeeded()
        modal.frame = CGRect(x: 0, y: Helpers.screenHeight, width: Helpers.screenWidth, height: modal.getHeight())
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            modal.frame.origin.y = Helpers.screenHeight  - modal.getHeight() + modal.layer.cornerRadius
            backDrop.layoutIfNeeded()
        }, completion: nil)
        
        return backDrop
    }
    
    public static func showSelfie(onProceed: @escaping () -> Void = {}) {
        show(title: "Take a Selfie", subtitle: "We will use your selfie to validate your Identity", type: .selfie, primaryText: "Proceed to camera", onConfirm: onProceed)
    }
    
    public static func showAlatPay(amount: String, account: String, onSent: @escaping () -> Void = {}) {
        let alatPayView = AlatPayView(frame: .infinite)
        alatPayView.model.amount = amount
        alatPayView.model.account = account
        show(extraView: alatPayView,  type: .alatPay, primaryText: "I’ve sent the money", dismissable: false, dismissOnConfirm: false, onConfirm: onSent)
    }
    
    public static func showSoftToken(titleText: String, onProceed: @escaping () -> Void = {}) {
        let softTokenView = PasswordField(frame: .infinite)
        softTokenView.titleText = "\(titleText)"
        show(title: "Enter Token", extraView: softTokenView, type: .softoken, primaryText: "Proceed", dismissable: true, dismissOnConfirm: true, onConfirm: onProceed)
    }
    
    
    public static func showSecurity(businessType: String, secondDetails: String, thirdDetails: String ,onProceed: @escaping () -> Void = {}, onCancel: @escaping () -> Void = {}) {
        let alatPayView = SecurityView(frame: .infinite)
        alatPayView.model.details = businessType
        alatPayView.model.secondDetails = secondDetails
        alatPayView.model.thirdDetails = thirdDetails
        show(extraView: alatPayView,  type: .securiy, primaryText: "Proceed", secondaryText: "Cancel", dismissable: false, dismissOnConfirm: false, onConfirm: onProceed, onCancel: onCancel)
    }
    
    public static func showDetails(details: String,onProceed: @escaping () -> Void = {}, onCancel: @escaping () -> Void = {}) {
        let detailsView = DetailsView(frame: .infinite)
        detailsView.model.details = details
            show(title: "Transaction submitted!", subtitle: "Your transaction is being processed" ,extraView: detailsView ,type: .successWithDetails, primaryText: "Done", onConfirm: onProceed)
    }
    

    
    public static func showSuccesswithButtons(
        title: String = "Thank you",
        subtitle: String = "Your transaction was completed",
        confirmText: String = "Done", onConfirm: @escaping () -> Void = {},
        onButtonTapped: @escaping (ButtonsView.Buttontype) -> Void = { _ in },
        useTwoLinks: Bool = false, useReceiptLinks: Bool = false, link1Text: String? = nil, link2Text: String? = nil)
    {
        let view = ButtonsView(frame: .infinite)
        view.onButtonTapped = onButtonTapped
        if useTwoLinks {view.setupTwoLink(link1: link1Text, link2: link2Text)}
        if useReceiptLinks {view.setupReceiptLinks()}
        BottomModal.show(title: title, subtitle: subtitle, extraView: view, type: .successWithLinks, primaryText: confirmText, dismissable: false, onConfirm: onConfirm)
    }
    
    public static func showProcessing(
        title: String = "Thank you",
        subtitle: String = "Your transaction is being processed",
        tetiaryText: String = "If you are not redirected in 30 seconds, use the refresh button below to manually check your transaction status",
        dismissable: Bool = false,
        confirmText: String = "Refresh",
        cancelText: String = "",
        onConfirm: @escaping () -> Void = {},
        onCancel: @escaping () -> Void = {})
    {
        BottomModal.show(title: title, subtitle: subtitle, tetiaryTitle: tetiaryText, type: .pending, primaryText: confirmText, secondaryText: cancelText, dismissable: dismissable, dismissOnConfirm: false, onConfirm: onConfirm, onCancel: onCancel)
    }
    
    public static func showAwaiting(
        title: String = "Transaction request sent",
        subtitle: String = "Your transaction request has been sent for approval",
        tetiaryText: String = "We will send you a notification as soon as the request is approved",
        confirmText: String = "Return to dashboard",
        cancelText: String = "",
        onConfirm: @escaping () -> Void = {},
        onCancel: @escaping () -> Void = {})
    {
        BottomModal.show(title: title, subtitle: subtitle, tetiaryTitle: tetiaryText, type: .success, primaryText: confirmText, secondaryText: cancelText, dismissable: false, dismissOnConfirm: true, onConfirm: onConfirm, onCancel: onCancel)
    }
    
    public static func dismiss() {
        if let subviews = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.subviews {
            for view in subviews {
                if view is BottomModalView {
                    for v in view.subviews {
                        if v is BottomModal {
                            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                                v.frame.origin.y = Helpers.screenHeight
                                view.layoutIfNeeded()
                            }, completion: { _ in
                                view.removeFromSuperview()
                            })
                        }
                    }
               }
            }
        }
    }
}

class BottomModalView: UIView {}

public enum ModalType {
    case success, successWithLinks, successWithDetails ,error, caution, face, touch, lock, pending, selfie, alatPay, redSuccess, switchDevice, securiy ,loading, softoken ,defaultModal

    func getImage() -> UIImage {
        switch self {
        case .success, .successWithLinks, .successWithDetails:
            return AlatAssets.modalSuccess.image
        case .error:
            return AlatAssets.modalError.image
        case .caution:
            return AlatAssets.modalCaution.image
        case .face:
            return AlatAssets.faceid2.image
        case .lock:
            return AlatAssets.lockIcon.image
        case .touch:
            return AlatAssets.touchid.image
        case .pending:
            return AlatAssets.modalPending.image
        case .selfie:
            return AlatAssets.selfie.image
        case .alatPay:
            return AlatAssets.alatPayLogo.image
        case .redSuccess:
            return AlatAssets.modalRedSuccess.image
        case .switchDevice:
            return AlatAssets.modalSwitchDevice.image
        case .securiy:
            return AlatAssets.security.image
        case .loading:
            return AlatAssets.pendingIcon.image
        case .softoken:
            return UIImage()
        case .defaultModal:
            return UIImage()
        }
    }
}


