//
//  BottomModalModel.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 15/02/2023.
//

import Foundation

public struct BottomMoodalModel {
    var modalTitle: String = ""
    var modalSubtitle: String = ""
    var tetiaryTitle: String = ""
    var extraView: UIView?
    var primaryText: String = "Okay"
    var secondaryText: String = ""
    var modalType: ModalType = .success
    var dismissable: Bool = true
    var dismissOnConfirm: Bool = true
    var onConfirm: () -> Void = {}
    var onCancel: () -> Void = {}
}
