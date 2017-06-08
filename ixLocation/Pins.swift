//
//  Pins.swift
//  ixLocation
//
//  Created by Grayson Wise on 6/6/17.
//  Copyright © 2017 Grayson Wise. All rights reserved.
//

import Foundation
import Gloss

class Pins: Decodable, Glossy {
    var lat: Double
    var long: Double
    
    init(){
        self.lat = 0
        self.long = 0
    }
    
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
    }
    
    required init?(json: JSON) {
        self.lat = ("lat" <~~ json)!
        self.long = ("long" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "lat" ~~> self.lat,
            "long" ~~> self.long
            ])
    }
}
