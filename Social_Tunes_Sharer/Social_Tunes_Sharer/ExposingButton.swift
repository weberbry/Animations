//
//  ExposingButton.swift
//  Social_Tunes_Sharer
//
//  Created by Bryan Weber on 11/8/15.
//  Copyright © 2015 Intrepid Pursuits. All rights reserved.
//

import UIKit

class ExposingButton: UIView {
    
    var overlay: UIButton!
    var buttonContainer: UIView!
    var tester: UIView!

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        buttonContainer = UIView(frame: CGRectMake(frame.width, 0, frame.width, 100))
        
        let button1:UIButton = UIButton(frame: CGRectMake(0, 0, 100, 100))
        button1.backgroundColor = UIColor.greenColor()
        button1.setTitle("Button", forState: UIControlState.Normal)
        button1.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonContainer.addSubview(button1)
        
        let button2:UIButton = UIButton(frame: CGRectMake(150, 0, 100, 100))
        button2.backgroundColor = UIColor.greenColor()
        button2.setTitle("Button", forState: UIControlState.Normal)
        button2.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonContainer.addSubview(button2)
        
        self.addSubview(buttonContainer)
        
        overlay = UIButton(frame: CGRectMake(0, 0, frame.width, 100))
        overlay.backgroundColor = UIColor.redColor()
        overlay.setTitle("Share", forState: UIControlState.Normal)
        overlay.addTarget(self, action: "overlayTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(overlay)
        
        let maskPath = UIBezierPath.init(roundedRect: CGRectMake(0, 0, frame.width, 100), cornerRadius: 50)
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = CGRectMake(0, 0, frame.width, 100)
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        
        self.layer.mask = maskLayer;

    }
    
    func overlayTapped(sender:UIButton) {
        UIView.animateWithDuration(0.5) { () -> Void in
            var destinationFrame = self.overlay.frame
            destinationFrame.origin.x = self.overlay.frame.width * -1
            self.overlay.frame = destinationFrame
            
            var destinationFrame2 = self.buttonContainer.frame
            destinationFrame2.origin.x = 0
            self.buttonContainer.frame = destinationFrame2
        }
    }
    
    func buttonTapped(sender:UIButton) {
        
        tester = sender
        let leftOverlay = UIView(frame: CGRectMake(sender.center.x, 0, 0, 100))
        leftOverlay.backgroundColor = UIColor.orangeColor()
        self.addSubview(leftOverlay)
        let rightOverlay = UIView(frame: CGRectMake(sender.center.x, 0, 0, 100))
        rightOverlay.backgroundColor = UIColor.orangeColor()
        self.addSubview(rightOverlay)

        UIView.animateWithDuration(0.5, animations: {
            
            var leftDestinationFrame = leftOverlay.frame
            leftDestinationFrame.size.width = leftDestinationFrame.origin.x
            leftDestinationFrame.origin.x = 0;
            leftOverlay.frame = leftDestinationFrame
            
            var rightDestinationFrame = rightOverlay.frame
            rightDestinationFrame.size.width = self.frame.width - self.tester.center.x
            rightOverlay.frame = rightDestinationFrame
            
            }, completion: {
                (value: Bool) in
                
                UIView.animateWithDuration(0.5, animations: {
                    self.bringSubviewToFront(self.overlay)
                    var destinationFrame = self.overlay.frame
                    destinationFrame.origin.x = 0
                    self.overlay.frame = destinationFrame
                    
                    }, completion: {
                        (value: Bool) in
                        
                        var buttonContainerFrame = self.buttonContainer.frame
                        buttonContainerFrame.origin.x = buttonContainerFrame.width
                        self.buttonContainer.frame = buttonContainerFrame
                        leftOverlay.removeFromSuperview()
                        rightOverlay.removeFromSuperview()

                })

        })
    }
}
