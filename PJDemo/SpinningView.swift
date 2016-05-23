//
//  SpinningView.swift
//  TearDownCircle
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

protocol SpinningViewDataSource:class{
    func percentForSpinningView(sender: SpinningView)->Double?
}

class SpinningView: UIView {
    
    let circleLayer = CAShapeLayer()
    
    var percentageLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup()
    {
        circleLayer.removeAllAnimations()
        circleLayer.bounds = bounds
        circleLayer.lineWidth = 10
        circleLayer.fillColor = UIColor(red: 238/255, green: 232/255, blue: 170/255, alpha: 0.2).CGColor//(238,232,170)
        tintColorDidChange()
        circleLayer.strokeColor = UIColor(red: 0, green: 250/255, blue: 154/255, alpha: 0.5).CGColor//(0,250,154)
        layer.addSublayer(circleLayer)
        
        updateAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let path = UIBezierPath(ovalInRect: circleLayer.bounds)
        circleLayer.position = center
        circleLayer.path = path.CGPath
        
    }
    //    override func prepareForInterfaceBuilder() {
    //        super.prepareForInterfaceBuilder()
    //        setup()
    //    }
    
    //    override func tintColorDidChange() {
    //        super.tintColorDidChange()
    //        circleLayer.strokeColor = tintColor.CGColor
    //    }
    
    let strokeEndAnimation : CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 4
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let group = CAAnimationGroup()
        group.duration = 4
        group.repeatCount = HUGE
        group.animations = [animation]
        animation.repeatCount = 2
        return group
        }()
    
    let strokeStartAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.9
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 4
        animation.fillMode = kCAFillRuleNonZero
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let group = CAAnimationGroup()
        group.duration = 4
        group.repeatCount = HUGE
        group.animations = [animation]
        
        return group
        }()
    
    let rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = M_PI * 2
        animation.duration = 4
        animation.repeatCount = HUGE
        return animation
        }()
    
    weak var dataSource : SpinningViewDataSource?
    
    func updateAnimation() {
        //print(dataSource?.percentForSpinningView(self))
        circleLayer.addAnimation(strokeEndAnimation, forKey: "strokeEnd")
        circleLayer.addAnimation(strokeStartAnimation, forKey: "strokeStart")
        circleLayer.addAnimation(rotationAnimation , forKey: "rotation")
        circleLayer.strokeStart = 0
        var percentage = dataSource?.percentForSpinningView(self) ?? 0.0
        circleLayer.strokeEnd =  CGFloat(percentage)
        
    }
    
    
}
