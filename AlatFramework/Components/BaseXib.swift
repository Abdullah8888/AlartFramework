//
//  BaseXib.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 31/01/2023.
//
import UIKit

public class BaseXib: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
    }
    
    
    func setupXib() {
        if let nibName = getNibName() {
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: nibName, bundle: bundle)
            let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
            //guard let content = getContentView() else { return }
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            backgroundColor = .clear
            view.backgroundColor = .clear
            addSubview(view)
            view.frame = self.bounds
        }
    }
    
    func updateHeight() {
        constraints.filter({$0.firstAnchor == heightAnchor }).forEach{ $0.isActive = false }
        setNeedsDisplay()
    }
    
    func getNibName() -> String? { String(describing: Self.self) }
    func getContentView() -> UIView? { nil }
    func sizeToContent()-> Bool { false }
}
