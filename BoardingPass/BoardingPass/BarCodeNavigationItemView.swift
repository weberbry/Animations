//
//  BarCodeNavigationItemView.swift
//  BoardingPass
//
//  Created by Bryan Weber on 12/12/15.
//  Copyright © 2015 Intrepid Pursuits. All rights reserved.
//

import UIKit

protocol BarCodeNavigationItemViewDelegate {
    func didExposeBarCode()
    func didHideBarCode()
}

class BarCodeNavigationItemView: UIView {

    let containerView : UIView = UIView(frame: CGRectMake(0, 0, 30, 40))
    
    let leftOverlayView : UIView = UIView(frame: CGRectMake(0, 0, 15, 40))
    let rightOverlayView : UIView = UIView(frame: CGRectMake(15, 0, 15, 40))
    
    let leftClosingXView : UIView = UIView(frame: CGRectMake(15, 5, 2, 30))
    let rightClosingXView : UIView = UIView(frame: CGRectMake(15, 5, 2, 30))
    
    var isBarCodeExposed: Bool = false
    
    var delegate: BarCodeNavigationItemViewDelegate?
    
    func configureViewWithColor(color: UIColor) {
        
        backgroundColor =  color
        clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapped")
        addGestureRecognizer(tapGestureRecognizer)
        
        addSubview(barCodeView())
        
        leftOverlayView.backgroundColor = color
        addSubview(leftOverlayView)
        
        rightOverlayView.backgroundColor = color
        addSubview(rightOverlayView)
        
        leftClosingXView.transform = CGAffineTransformMakeRotation(45.degreesToRadians)
        leftClosingXView.backgroundColor = UIColor.whiteColor()
        addSubview(leftClosingXView)
        
        rightClosingXView.transform = CGAffineTransformMakeRotation(-45.degreesToRadians)
        rightClosingXView.backgroundColor = UIColor.whiteColor()
        addSubview(rightClosingXView)
    }
    
    func barCodeView() -> UIView {
        
        let barCodeWidths : [CGFloat] = [4, 2, 4, 2, 8, 2, 6, 4, 2, 2]
        
        let barCodeView = UIView(frame: CGRectMake(0, 0, 30, 40))
        
        var offset : CGFloat = 0.0
        
        for barCodeWidth in barCodeWidths {
            let barView = UIView(frame: CGRectMake(offset, 10, barCodeWidth, 20))
            barView.backgroundColor = UIColor.whiteColor()
            barCodeView.addSubview(barView)
            offset = offset + 2 + CGFloat(barCodeWidth)
        }
        
        return barCodeView
    }
    
    func tapped() {
        if(isBarCodeExposed) {
            hideBarCodeAnimation()
        } else {
           collapseClosingXAnimation()
        }
    }
    
    func collapseClosingXAnimation() {
        
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.leftClosingXView.transform = CGAffineTransformMakeRotation(0)
            self.rightClosingXView.transform = CGAffineTransformMakeRotation(0)
            }, completion: {_ in
                self.leftClosingXView.hidden = true
                self.rightClosingXView.hidden = true
                self.exposeBarCodeAnimation()
        })
    }
    
    func createClosingXAnimation() {
        
        self.leftClosingXView.hidden = false
        self.rightClosingXView.hidden = false
        
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.leftClosingXView.transform = CGAffineTransformMakeRotation(45.degreesToRadians)
            self.rightClosingXView.transform = CGAffineTransformMakeRotation(-45.degreesToRadians)
            }, completion: {_ in
                self.isBarCodeExposed = false
                self.delegate?.didHideBarCode()
        })
    }
    
    func exposeBarCodeAnimation() {
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            var leftOverlayFrame = self.leftOverlayView.frame
            leftOverlayFrame.size.width = 0
            self.leftOverlayView.frame = leftOverlayFrame
            
            var rightOverlayFrame = self.rightOverlayView.frame
            rightOverlayFrame.size.width = 0
            rightOverlayFrame.origin.x = self.frame.width
            self.rightOverlayView.frame = rightOverlayFrame
            }, completion: {_ in
                self.isBarCodeExposed = true
                self.delegate?.didExposeBarCode()
        })
    }
    
    func hideBarCodeAnimation() {
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            var leftOverlayFrame = self.leftOverlayView.frame
            leftOverlayFrame.size.width = 15
            self.leftOverlayView.frame = leftOverlayFrame
            
            var rightOverlayFrame = self.rightOverlayView.frame
            rightOverlayFrame.size.width = 15
            rightOverlayFrame.origin.x = 15
            self.rightOverlayView.frame = rightOverlayFrame
            }, completion: {_ in
                self.createClosingXAnimation()
        })
    }

}

extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
}
