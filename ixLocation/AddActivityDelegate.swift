//
//  AddActivityDelegate.swift
//  ixLocation
//
//  Created by Grayson Wise on 6/6/17.
//  Copyright © 2017 Grayson Wise. All rights reserved.
//

import Foundation

protocol AddActivityDelegate {
    func didSaveActivity(activity: Activity)
    func didCancelActivity()
}
