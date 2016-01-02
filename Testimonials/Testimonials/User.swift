//
//  User.swift
//  Testimonials
//
//  Created by Bryan Weber on 1/1/16.
//  Copyright © 2016 Intrepid Pursuits. All rights reserved.
//

import UIKit

class User: NSObject {
    
    let name: String
    let imageTitle: String
    let quote: String
    
    init(name: String, imageTitle: String, quote: String) {
        self.name = name
        self.imageTitle = imageTitle
        self.quote = quote
    }
}
