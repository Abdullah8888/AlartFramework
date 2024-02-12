//
//  CircularProgressBar.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 04/02/2023.
//
import Foundation
import UIKit

@IBDesignable public class CircularProgressBar: UIView {
    @IBInspectable public var maxValue: CGFloat = 0
    @IBInspectable public var currentValue: CGFloat = 0
    @IBInspectable public var startValue: CGFloat = 0
    
    @IBInspectable var barColor: UIColor = .alatRed
    
    public override func layoutSubviews() {
        setup()
    }
    
    func setup() {
        backgroundColor = .white
        layer.cornerRadius = bounds.height / 2
        //Label
        let label = BoldLabel()
        label.size = 13
        label.textColor = barColor
        label.text = "\(Int(currentValue))/\(Int(maxValue))"
        label.sizeToFit()
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraints([centerXConstraint, centerYConstraint])
        
        //Path Layer
        let pathLayer = CAShapeLayer()
        let lineWidth = 5.69
        let radius = min(bounds.width, bounds.height) / 2 - lineWidth
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi/2, endAngle: 3 * CGFloat.pi/2, clockwise: true).cgPath
        pathLayer.path = circularPath
        pathLayer.strokeColor = UIColor.background.lighter(by: 10)?.cgColor
        pathLayer.lineWidth = lineWidth
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.lineCap = .round
        layer.addSublayer(pathLayer)
        
        //Stroke Layer
        let circleLayer = CAShapeLayer()
        circleLayer.path = circularPath
        circleLayer.strokeColor = barColor.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        layer.addSublayer(circleLayer)
        
        guard currentValue <= maxValue, startValue <= maxValue else { return }
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = startValue/maxValue
        basicAnimation.toValue = currentValue/maxValue
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.duration = 0.8
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        circleLayer.add(basicAnimation, forKey: "circleProgressAnimation")
    }
}
