//
//  Activity.swift
//  ixLocation
//
//  Created by Grayson Wise on 6/6/17.
//  Copyright © 2017 Grayson Wise. All rights reserved.
//

import Foundation
import UIKit

class Activity {
    var name: String!
    var description: String!
    var image: UIImage?
    var location: Pins
    
    init?() {
        self.name = ""
        self.description = ""
        self.image = nil
        self.location = Pins(lat: 0.0, long: 0.0)
    }
    
}
