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
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var startingFrame: CGRect?
    
    var users: [User] = []
    var userIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: "respondToSwipeGesture:")
        swipeGestureRecognizer.direction = .Up
        view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        createUsers()
        
        lowerContainerView.frame = view.frame
        
        photoImageView.layer.borderWidth = 4.0
        photoImageView.layer.borderColor = UIColor.whiteColor().CGColor
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
        
        configureWithUser(users[userIndex])
    }
    
    func configureWithUser(user: User) {
        photoImageView.image = UIImage(named: user.imageTitle)
        messageLabel.text = user.quote
        usernameLabel.text = user.name
        twitterLabel.text = "Tweet This"
    }
    
    func respondToSwipeGesture(gesture: UISwipeGestureRecognizer) {
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.usernameLabel.alpha = 0
            self.usernameLabel.transform = CGAffineTransformMakeTranslation(0, 20)

            self.twitterLabel.alpha = 0
            self.twitterLabel.transform = CGAffineTransformMakeTranslation(0, 20)
        }
        
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
                
                if (self.userIndex < self.users.count - 1) {
                    self.userIndex++
                } else {
                    self.userIndex = 0
                }
                self.configureWithUser(self.users[self.userIndex])
                
                self.photoImageView.transform = CGAffineTransformIdentity
                
                self.usernameLabel.alpha = 1
                self.messageLabel.transform = CGAffineTransformIdentity
                
                self.twitterLabel.alpha = 1
                self.messageLabel.transform = CGAffineTransformIdentity

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
    
    func createUsers() {
        let han = User(name: "Han Solo", imageTitle: "han.jpeg", quote: "Chewie We're Home")
        users.append(han)
        let yoda = User(name: "Yoda", imageTitle: "yoda.jpeg", quote: "Do. Or do not. There is no try")
        users.append(yoda)
        let leia = User(name: "Leia", imageTitle: "leia.jpeg", quote: "I hope you know what you're doing")
        users.append(leia)
    }
}

