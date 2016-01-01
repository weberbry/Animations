//
//  ViewController.swift
//  BoardingPass
//
//  Created by Bryan Weber on 12/9/15.
//  Copyright © 2015 Intrepid Pursuits. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BarCodeNavigationItemViewDelegate {
    
    let boardingPassBlue : UIColor = UIColor(red:0.4, green:0.83, blue:0.95, alpha:1)
    
    var boardingPassView : UIView!
    var airportMapView : UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        airportMapView = UIView(frame: view.frame)
        airportMapView.backgroundColor = UIColor.redColor()
        airportMapView.transform = CGAffineTransformMakeScale(0.75, 0.75)
        
        view.addSubview(airportMapView)
        
        boardingPassView = UIView(frame: view.frame)
        boardingPassView.backgroundColor = UIColor.yellowColor()
        view.addSubview(boardingPassView)
        
        navigationController!.navigationBar.translucent = false;
        navigationController!.navigationBar.barTintColor = boardingPassBlue
        
        
        let barCodeNavigationItemView = BarCodeNavigationItemView(frame: CGRectMake(0, 0, 30, 40))
        barCodeNavigationItemView.configureViewWithColor(boardingPassBlue)
        barCodeNavigationItemView.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: barCodeNavigationItemView)
    }
    
    func didExposeBarCode() {
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseIn, animations: { () -> Void in
                self.boardingPassView.transform = CGAffineTransformMakeTranslation(0, -(self.view.frame.height + 64))
                self.airportMapView.transform = CGAffineTransformMakeScale(1, 1)

            }, completion: {_ in
                
        })
    }
    
    func didHideBarCode() {
        
        UIView.animateWithDuration(0.5, delay: 0.15, options: .CurveEaseIn, animations: { () -> Void in
            self.boardingPassView.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: {_ in
                
        })
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseIn, animations: { () -> Void in
            self.airportMapView.transform = CGAffineTransformMakeScale(0.75, 0.75)
            self.airportMapView.transform = CGAffineTransformTranslate(self.airportMapView.transform, 0, -60)
            }, completion: {_ in
                
        })
    }
}

