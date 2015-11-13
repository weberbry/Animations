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
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let images: [UIImage] = [UIImage(named: "socialMediaGoogle")!, UIImage(named: "socialMediaTwitter")!, UIImage(named: "socialMediaFacebook")!]
        
        let exposingButton = ExposingButton(buttonImages: images, height: 50, margin: 10, spacing: 50)
        exposingButton.delegate = self
        buttonContainer.addSubview(exposingButton)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true 
    }
    
    func exposingButtonDidSelect(button: UIButton) {
        print("Did Selected \(button)")
    }
}

