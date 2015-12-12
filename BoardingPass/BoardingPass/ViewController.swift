//
//  ViewController.swift
//  BoardingPass
//
//  Created by Bryan Weber on 12/9/15.
//  Copyright © 2015 Intrepid Pursuits. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let boardingPassBlue : UIColor = UIColor(red:0.4, green:0.83, blue:0.95, alpha:1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barCodeNavigationItemView = BarCodeNavigationItemView(frame: CGRectMake(0, 0, 30, 40))
        barCodeNavigationItemView.configureViewWithColor(boardingPassBlue)
        view.addSubview(barCodeNavigationItemView)
    }

}

