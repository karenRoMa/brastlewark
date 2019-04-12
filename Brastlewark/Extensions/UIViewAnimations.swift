//
//  UIViewAnimations.swift
//
//  Created by Karen Rodriguez on 30/05/18.
//  Copyright © 2018 Karen Rodriguez. All rights reserved.
//

import Foundation
import UIKit
import pop

extension UIView {

    func animatedTransparencyChange(withInitialAlpha fromAlpha: Float, toFinalAlpha toAlpha: Float, andDuration duration: CGFloat = 0.75, completionBlock: @escaping(POPAnimation?, Bool) -> Void) {
        let popTAnimation: POPBasicAnimation = POPBasicAnimation.init(propertyNamed: kPOPViewAlpha)
        popTAnimation.duration = CFTimeInterval(duration)
        popTAnimation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
        popTAnimation.fromValue = fromAlpha
        popTAnimation.toValue = toAlpha
        popTAnimation.delegate = self
        self.pop_add(popTAnimation, forKey: "alphaChange")
        popTAnimation.completionBlock = {(animation, finished) in
            completionBlock(animation, finished)
        }
    }

    func rotateView(toRadians radians: Double) {
        let popAnimation: POPBasicAnimation = POPBasicAnimation.init(propertyNamed: kPOPLayerRotation)
        popAnimation.duration = 0.75
        popAnimation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
        popAnimation.toValue = radians
        popAnimation.delegate = self
        self.layer.pop_add(popAnimation, forKey: "rotateLayer")
    }

    func animateShadowTiltEffect(withInitialRadius fromRadius: Int, toFinalRadius toRadius: Int) {
        let popAnimation: POPBasicAnimation = POPBasicAnimation.init(propertyNamed: kPOPLayerShadowRadius)
        popAnimation.duration = 0.75
        popAnimation.autoreverses = true
        popAnimation.repeatForever = true
        popAnimation.fromValue = fromRadius
        popAnimation.toValue = toRadius
        popAnimation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)

        popAnimation.delegate = self
        self.layer.pop_add(popAnimation, forKey: "shadowOpacity")
    }

    func moveIn(axisX isX: Bool, toX xcoordinate: CGFloat, withTiming timing: String, andDuration duration: Double, completionBlock: @escaping(POPAnimation?, Bool) -> Void) {
        let popAnimation: POPBasicAnimation = (isX) ? POPBasicAnimation.init(propertyNamed: kPOPLayerPositionX) : POPBasicAnimation.init(propertyNamed: kPOPLayerPositionY)
        popAnimation.duration = duration
        popAnimation.toValue = xcoordinate
        popAnimation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName(rawValue: timing))
        popAnimation.delegate = self
        self.layer.pop_add(popAnimation, forKey: "moveInAxis")
        popAnimation.completionBlock = {(animation, finished) in
            completionBlock(animation, finished)
        }
    }

    func moveBackAndForthInX(axisX isX: Bool, toX xcoordinate: Int, andDuration duration: Double) {
        let popAnimation: POPBasicAnimation = (isX) ? POPBasicAnimation.init(propertyNamed: kPOPLayerPositionX) : POPBasicAnimation.init(propertyNamed: kPOPLayerPositionY)
        popAnimation.duration = duration
        popAnimation.toValue = xcoordinate
        popAnimation.autoreverses = true
        popAnimation.repeatForever = true
        popAnimation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut)
        popAnimation.delegate = self
        self.layer.pop_add(popAnimation, forKey: "moveInX")
    }

    func contract(withDuration duration: Double, completionBlock: @escaping(POPAnimation?, Bool) -> Void) {
        let contractAnimation: POPBasicAnimation = POPBasicAnimation.init(propertyNamed: kPOPViewScaleXY)
        contractAnimation.duration = duration
        contractAnimation.toValue = NSValue(cgPoint: CGPoint(x: 0.95, y: 0.95))
        self.pop_add(contractAnimation, forKey: "scaleAnimation")
        contractAnimation.completionBlock = {(animation, finished) in
            completionBlock(animation, finished)
        }
    }

    func expand(withBounce bounciness: CGFloat) {
        let expandAnimation: POPSpringAnimation = POPSpringAnimation.init(propertyNamed: kPOPViewScaleXY)
        expandAnimation.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
        expandAnimation.velocity = NSValue(cgPoint: CGPoint(x: 2, y: 2))
        expandAnimation.springBounciness = bounciness
        self.pop_add(expandAnimation, forKey: "scaleAnimation")
    }

    func dismissWithAnimation() {
        let contractAnimation: POPBasicAnimation = POPBasicAnimation.init(propertyNamed: kPOPViewScaleXY)
        contractAnimation.duration = 0.1
        contractAnimation.toValue = NSValue(cgPoint: CGPoint(x: 0.5, y: 0.5))
        self.pop_add(contractAnimation, forKey: "scaleAnimation")
        contractAnimation.completionBlock = {(animation, finished) in
            self.animatedTransparencyChange(withInitialAlpha: 1, toFinalAlpha: 0, completionBlock: { _, _ in
                self.removeFromSuperview()
            })
        }
    }
}
