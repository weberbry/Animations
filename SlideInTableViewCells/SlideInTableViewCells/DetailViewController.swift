//
//  DetailViewController.swift
//  SlideInTableViewCells
//
//  Created by Bryan Weber on 11/21/15.
//  Copyright © 2015 Intrepid Pursuits. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: "didTapView")
        view.addGestureRecognizer(tapGesture)
    }
    
    func didTapView() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
