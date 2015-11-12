//
//  ViewController.swift
//  Social_Tunes_Sharer
//
//  Created by Bryan Weber on 11/8/15.
//  Copyright © 2015 Intrepid Pursuits. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = ExposingButton.init(frame: self.view.frame)
        self.view.addSubview(button)
    }
}

