//
//  ViewController.swift
//  Social_Tunes_Sharer
//
//  Created by Bryan Weber on 11/8/15.
//  Copyright © 2015 Intrepid Pursuits. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ExposingButtonDelegate {

    @IBOutlet weak var buttonContainer: UIView!
    var exposingButton: ExposingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let images: [UIImage] = [UIImage(named: "socialMediaTwitter")!, UIImage(named: "socialMediaGoogle")!, UIImage(named: "socialMediaFacebook")!]
        
        exposingButton = ExposingButton(buttonImages: images)
        exposingButton.delegate = self
        buttonContainer.addSubview(exposingButton)
        addConstraints()
    }
    
    func addConstraints () {
        view.translatesAutoresizingMaskIntoConstraints = false
        let xCenterConstraint = NSLayoutConstraint(item: exposingButton, attribute: .CenterX, relatedBy: .Equal, toItem: buttonContainer, attribute: .CenterX, multiplier: 1, constant: 0)
        view.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: exposingButton, attribute: .CenterY, relatedBy: .Equal, toItem: buttonContainer, attribute: .CenterY, multiplier: 1, constant: 0)
        view.addConstraint(yCenterConstraint)
    
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true 
    }
    
    func exposingButtonDidSelect(button: UIButton) {
        print("Did Select \(button)")
    }
}

