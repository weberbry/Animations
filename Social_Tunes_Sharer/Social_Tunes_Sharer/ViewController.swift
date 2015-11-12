//
//  ViewController.swift
//  Social_Tunes_Sharer
//
//  Created by Bryan Weber on 11/8/15.
//  Copyright © 2015 Intrepid Pursuits. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRectMake(0, 0, 250, 50)
        
        let button = ExposingButton.init(frame: frame)
        buttonContainer.addSubview(button)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true 
    }
}

