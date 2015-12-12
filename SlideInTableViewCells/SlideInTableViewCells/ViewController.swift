//
//  ViewController.swift
//  SlideInTableViewCells
//
//  Created by Bryan Weber on 11/20/15.
//  Copyright © 2015 Intrepid Pursuits. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let transition = ExpandingAnimator()
    var items: [String] = ["", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    var startColor: UIColor!
    var endColor: UIColor!
    var selectedCell: UITableViewCell?
    var transitionDuration: Double?
    var hasLoaded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (hasLoaded) {
            tableView.reloadData()
        }
        hasLoaded = true
    }
    
    func configureTableView() {
        startColor = UIColor.redColor()
        endColor = UIColor.blueColor()
        tableView.backgroundColor = UIColor.blackColor()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
        
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.backgroundColor = colorForIndexPath(indexPath)
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
       
        let delay = 0.1 * Double(indexPath.row)
        UIView.animateWithDuration(0.75, delay: delay, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                cell.transform = CGAffineTransformMakeTranslation(0, -tableView.frame.height)
            }, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let droppingCells = notSelectedVisibleCellsForSelectedRowAtIndexPath(indexPath)
        var dropCount = 0
 
        transitionDuration = (Double(droppingCells.count) * 0.1) + 0.75
        selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        tableView.bringSubviewToFront(selectedCell!)
        
        for var i = 0; i < droppingCells.count; ++i {
            let delay = 0.1 * Double(items.count - i)
            view.bringSubviewToFront(selectedCell!)
            UIView.animateWithDuration(0.75, delay: delay, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                droppingCells[i].transform = CGAffineTransformMakeTranslation(0, tableView.frame.height)
                }, completion: {_ in
                    ++dropCount
                    if (dropCount == droppingCells.count) {
                        self.presentDetailVC()
                        
                    }
                })
        }
        
    }
    
    func presentDetailVC() {
        let detailVC = DetailViewController()
        detailVC.view.backgroundColor = selectedCell?.backgroundColor
        detailVC.transitioningDelegate = self
        presentViewController(detailVC, animated: true, completion: nil)
    }
    
    func notSelectedVisibleCellsForSelectedRowAtIndexPath(indexPath: NSIndexPath) -> [UITableViewCell] {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        
        var droppingCell: [UITableViewCell] = []
        
        for cell in tableView.visibleCells {
            if (!cell.isEqual(selectedCell)) {
                droppingCell.append(cell)
            }
        }
        return droppingCell
    }
    
    func colorForIndexPath(indexPath: NSIndexPath) -> UIColor {
        let percent = CGFloat(indexPath.row) / CGFloat(items.count)
        
        let redDelta = (endColor.components.red - startColor.components.red) * percent
        let greenDelta = (endColor.components.green - startColor.components.green) * percent
        let blueDelta = (endColor.components.blue - startColor.components.blue) * percent

        let red = startColor.components.red  + redDelta
        let green = startColor.components.green  + greenDelta
        let blue = startColor.components.blue  + blueDelta
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = true
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}

extension UIColor {
    var components:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r,g,b,a)
    }
}



