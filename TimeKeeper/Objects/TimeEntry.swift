//
//  TimeEntry.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 17/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import Foundation

struct TimeEntry: Codable {
    var ID: Int
    var date: String?
    var startTime: String
    var endTime: String
}
