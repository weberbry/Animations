//
//  ExposingButton.swift
//  Social_Tunes_Sharer
//
//  Created by Bryan Weber on 11/8/15.
//  Copyright © 2015 Intrepid Pursuits. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class ExposingButton: UIView {
    
    var overlayButton: UIButton!
    var buttonContainer: UIView!
    var expandingOverlay: UIView!

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        backgroundColor = UIColor(rgba: "#59302A")
        
        buttonContainer = UIView(frame: CGRectMake(frame.width, 0, frame.width, frame.height))
        
        let buttonNames : [String] = ["socialMediaGoogle", "socialMediaTwitter", "socialMediaFacebook"]
        
        for var index = 0; index < buttonNames.count; ++index {
            
            let buttonName = buttonNames[index]
            let image = UIImage(named: buttonName) as UIImage?
            let button  = UIButton(type: UIButtonType.System) as UIButton
            
            let x = (CGFloat(index + 1) / CGFloat(buttonNames.count)) * frame.width
            button.frame = CGRectMake(x - frame.height, 10, frame.height - 20, frame.height - 20)
            button.setImage(image, forState: .Normal)
            button.addTarget(self, action: "buttonTapped:", forControlEvents:.TouchUpInside)
            button.tintColor = UIColor(rgba: "#DED6D7")
            buttonContainer.addSubview(button)
        }
        
        self.addSubview(buttonContainer)
        
        overlayButton = UIButton(frame: CGRectMake(0, 0, frame.width, frame.height))
        overlayButton.backgroundColor = UIColor(rgba: "#DCCA7A")
        overlayButton.setTitle("SHARE", forState: UIControlState.Normal)
        overlayButton.addTarget(self, action: "overlayTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        overlayButton.setTitleColor(UIColor(rgba: "#59302A"), forState: UIControlState.Normal)
        overlayButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-Bold", size: 20)
        self.addSubview(overlayButton)
        

        
        let maskPath = UIBezierPath.init(roundedRect: CGRectMake(0, 0, frame.width, frame.height), cornerRadius: 50)
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = CGRectMake(0, 0, frame.width, frame.height)
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        
        self.layer.mask = maskLayer;

    }
    
//MARK: Button Actions
    
    func overlayTapped(sender:UIButton) {
        exposeButtonsAnimation()
    }
    
    func buttonTapped(sender:UIButton) {
        expandingOutAnimation(sender)
    }
    
//MARK: Animations
    
    func exposeButtonsAnimation() {
        UIView.animateWithDuration(0.5) { () -> Void in
            var overlayButtonFrame = self.overlayButton.frame
            overlayButtonFrame.origin.x = self.overlayButton.frame.width * -1
            self.overlayButton.frame = overlayButtonFrame
            
            var buttonContainerFrame = self.buttonContainer.frame
            buttonContainerFrame.origin.x = 0
            self.buttonContainer.frame = buttonContainerFrame
        }
    }
    
    func hideButtonsAnimaiotn() {
        UIView.animateWithDuration(0.5, animations: {
            self.bringSubviewToFront(self.overlayButton)
            var destinationFrame = self.overlayButton.frame
            destinationFrame.origin.x = 0
            self.overlayButton.frame = destinationFrame
            
            }, completion: {
                (value: Bool) in
                
                var buttonContainerFrame = self.buttonContainer.frame
                buttonContainerFrame.origin.x = buttonContainerFrame.width
                self.buttonContainer.frame = buttonContainerFrame
                self.expandingOverlay.removeFromSuperview()
                
        })
    }
    
    func expandingOutAnimation(sender:UIButton) {
        let expandingOverlayStartingFrame = CGRectMake(sender.center.x, 0, 0, self.frame.height)
        
        expandingOverlay = UIView(frame: expandingOverlayStartingFrame)
        expandingOverlay.backgroundColor = UIColor(rgba: "#C2B1BD")
        expandingOverlay.alpha = 0.5
        self.addSubview(expandingOverlay)
        
        UIView.animateWithDuration(0.5, animations: {
            
            var expandingOverlayDestinationFrame = self.expandingOverlay.frame
            expandingOverlayDestinationFrame.size.width = self.frame.width
            expandingOverlayDestinationFrame.origin.x = 0;
            self.expandingOverlay.frame = expandingOverlayDestinationFrame
            
            }, completion: {
                (value: Bool) in
                self.hideButtonsAnimaiotn()
        })

    }
}
