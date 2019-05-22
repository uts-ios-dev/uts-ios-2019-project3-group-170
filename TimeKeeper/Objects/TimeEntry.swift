//
//  TimeEntry.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 17/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import Foundation

struct TimeEntry: Codable {
    var id: Int?
    var date: String?
    var startTime: String
    var endTime: String
    var breakStartTime: String?
    var breakEndTime: String?
    var hasBeenEdited: Bool = false
    var originalStartTime: String?
    var originalEndTime: String?
}
