//
//  FontLoader.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 02/02/2023.
//

import UIKit
import Foundation

enum FontError: Error {
  case invalidFontFile
  case fontPathNotFound
  case initFontError
  case registerFailed
}

class GetBundle {}

extension UIFont {
    
    public static func loadAllFonts() {
        register(fileNameString: "Inter-Bold", type: ".ttf")
        register(fileNameString: "Inter-Light", type: ".ttf")
        register(fileNameString: "Inter-Medium", type: ".ttf")
        register(fileNameString: "Inter-Regular", type: ".ttf")
        register(fileNameString: "Inter-SemiBold", type: ".ttf")
    }
    
    static func register( fileNameString: String, type: String) {
        let frameworkBundle = Bundle(for: GetBundle.self)
        guard let resourceBundleURL = frameworkBundle.path(forResource: fileNameString, ofType: type) else { return }
        guard let fontData = NSData(contentsOfFile: resourceBundleURL),let dataProvider = CGDataProvider.init(data: fontData) else { return }
        guard let fontRef = CGFont.init(dataProvider) else { return }
        var errorRef: Unmanaged<CFError>? = nil
        guard CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) else { return }
     }
}
