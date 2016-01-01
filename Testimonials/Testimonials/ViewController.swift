//
//  ViewController.swift
//  Testimonials
//
//  Created by Bryan Weber on 12/30/15.
//  Copyright © 2015 Intrepid Pursuits. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lowerContainerView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var startingFrame: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: "respondToSwipeGesture:")
        swipeGestureRecognizer.direction = .Up
        view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        startingFrame = lowerContainerView.frame
        
        photoImageView.layer.borderWidth = 4.0
        photoImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        var frame = view.frame
        frame.origin.y = view.frame.height / 2
        lowerContainerView.frame = frame
        
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
    }
    
    func respondToSwipeGesture(gesture: UISwipeGestureRecognizer) {
        UIView.animateWithDuration(0.5, delay:0, options: .CurveEaseIn, animations: { () -> Void in
            self.photoImageView.transform = CGAffineTransformMakeScale(0.001, 0.001)
        }, completion: {_ in
            self.messageLabel.alpha = 0
            self.messageLabel.transform = CGAffineTransformMakeTranslation(0, 20)

        })
    
        UIView.animateWithDuration(1.0, delay:0, options: .CurveEaseIn, animations: { () -> Void in
            self.lowerContainerView.transform = CGAffineTransformMakeTranslation(0, -(self.view.frame.height + self.view.frame.height / 2))
            }, completion: {_ in
            self.lowerContainerView.transform = CGAffineTransformIdentity
            self.lowerContainerView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.height / 2)
                
            UIView.animateWithDuration(0.2, delay:0.3, options: .CurveEaseIn, animations: { () -> Void in
                self.photoImageView.transform = CGAffineTransformIdentity
                    }, completion: {_ in
                        
            })
                
            UIView.animateWithDuration(0.5, delay:0, options: .CurveEaseIn, animations: { () -> Void in
                    self.lowerContainerView.transform = CGAffineTransformIdentity
                    self.messageLabel.alpha = 1
                    self.messageLabel.transform = CGAffineTransformIdentity
            }, completion: {_ in
                
            })
        })

    }
}

