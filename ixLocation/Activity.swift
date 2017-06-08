//
//  Activity.swift
//  ixLocation
//
//  Created by Grayson Wise on 6/6/17.
//  Copyright © 2017 Grayson Wise. All rights reserved.
//

import Foundation
import UIKit
import Gloss

class Activity: Decodable, Glossy {
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
    
    required init?(json: JSON) {
        self.name = "name" <~~ json
        self.description = "description" <~~ json
        self.location = ("location" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "description" ~~> self.description,
            "location" ~~> self.location
            ])
    }
    
}
