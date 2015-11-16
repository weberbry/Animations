//
//  ExposingButton.swift
//  Social_Tunes_Sharer
//
//  Created by Bryan Weber on 11/8/15.
//  Copyright © 2015 Intrepid Pursuits. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

protocol ExposingButtonDelegate {
    func exposingButtonDidSelect(button: UIButton)
}

class ExposingButton: UIView {
    
    let overlayButtonColor = "#DCCA7A"
    let overlayButtonTextColor = "#59302A"
    let individualButtonColor = "#DED6D7"
    let buttonContainerColor = "#59302A"
    let expandingOverlayColor = "#C2B1BD"
    
    var overlayButton: UIButton!
    var buttonContainer: UIView!
    var expandingOverlay: UIView!
    var delegate: ExposingButtonDelegate?
    
    convenience init(buttonImages: [UIImage]) {
        let width = (CGFloat(buttonImages.count) * 60) + 30
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: 50))
        
        backgroundColor = UIColor(rgba: buttonContainerColor)
        
        configureButtonContainer(buttonImages)
        self.addSubview(buttonContainer)
        
        configureOverlayButton()
        self.addSubview(overlayButton)
        
        configureViewMask()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
//MARK: Configuration
    
    func configureButtonContainer(buttonImages: [UIImage]) {
        buttonContainer = UIView(frame: CGRectMake(frame.width, 0, frame.width, frame.height))
        
        for var index = 0; index < buttonImages.count; ++index {
            
            let button  = UIButton(type: UIButtonType.System) as UIButton
            button.frame = CGRectMake(30 + (60 * CGFloat(index)), 10, 30, 30)
            button.setImage(buttonImages[index], forState: .Normal)
            button.addTarget(self, action: "buttonTapped:", forControlEvents:.TouchUpInside)
            button.tintColor = UIColor(rgba: individualButtonColor)
            buttonContainer.addSubview(button)
        }
    }
    
    func configureOverlayButton() {
        let ovalPath = UIBezierPath.init(roundedRect: CGRectMake(0, 0, frame.width, frame.height), cornerRadius: 50)
        
        overlayButton = UIButton(frame: CGRectMake(0, 0, frame.width, frame.height))
        overlayButton.backgroundColor = UIColor(rgba: overlayButtonColor)
        overlayButton.setTitle("SHARE", forState: UIControlState.Normal)
        overlayButton.addTarget(self, action: "overlayTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        overlayButton.setTitleColor(UIColor(rgba: overlayButtonTextColor), forState: UIControlState.Normal)
        overlayButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-Bold", size: 20)
        
        let overlayButtonMask = CAShapeLayer.init()
        overlayButtonMask.frame = CGRectMake(0, 0, frame.width, frame.height)
        overlayButtonMask.frame = self.bounds;
        overlayButtonMask.path = ovalPath.CGPath;
        
        overlayButton.layer.mask = overlayButtonMask;
    }
    
    func configureViewMask() {
        let ovalPath = UIBezierPath.init(roundedRect: CGRectMake(0, 0, frame.width, frame.height), cornerRadius: 50)
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = CGRectMake(0, 0, frame.width, frame.height)
        maskLayer.frame = self.bounds;
        maskLayer.path = ovalPath.CGPath;
        
        self.layer.mask = maskLayer;
    }
    
//MARK: Button Actions
    
    func overlayTapped(sender:UIButton) {
        exposeButtonsAnimation()
    }
    
    func buttonTapped(sender:UIButton) {
        expandingOutAnimation(sender)
        if let delegate = self.delegate {
            delegate.exposingButtonDidSelect(sender)
        }
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
    
    func expandingOutAnimation(sender:UIButton) {
        let expandingOverlayStartingFrame = CGRectMake(sender.center.x, 0, 0, self.frame.height)
        
        expandingOverlay = UIView(frame: expandingOverlayStartingFrame)
        expandingOverlay.backgroundColor = UIColor(rgba: expandingOverlayColor)
        expandingOverlay.alpha = 0.5
        self.addSubview(expandingOverlay)
        
        UIView.animateWithDuration(0.5, animations: {
            
            let maxDistance = max(sender.center.x, self.frame.width - sender.center.x)
            
            var expandingOverlayDestinationFrame = self.expandingOverlay.frame
            expandingOverlayDestinationFrame.size.width = maxDistance * 2
            expandingOverlayDestinationFrame.origin.x =  sender.center.x - maxDistance;
            self.expandingOverlay.frame = expandingOverlayDestinationFrame
            
            }, completion: {
                (value: Bool) in
                self.hideButtonsAnimation()
        })
        
    }
    
    func hideButtonsAnimation() {
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
    
}
