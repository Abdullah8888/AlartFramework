//
//  AdvertView.swift
//  AlatFramework
//
//  Created by Willi D Lax on 07/04/2023.
//

import UIKit

public class AdvertView: BaseXib {
    let nibName = "AdvertView"
    
    @IBOutlet weak var contentView: CustomView!
    @IBOutlet weak var image: UIImageView!
    
    public var advertTapped: (AdvertType) -> Void = { _ in }
    
    public var type: AdvertType? {
        didSet{
            setup()
        }
    }
    
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
    
    func setup() {
        image.image = type?.image
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tap)
    }
    
    @objc func tapped(){
        advertTapped(type ?? .defaultAd)
    }
}

public enum AdvertType {
    case token, multipleTransfer, limited, defaultAd
    
    var image: UIImage {
        switch self {
            
        case .token:
            return AlatAssets.tokenAdvert.image
        case .multipleTransfer:
            return AlatAssets.multipleTransferAdvert.image
        case .limited:
            return AlatAssets.limitedAdvert.image
        case .defaultAd:
            return UIImage()
        }
    }
}
