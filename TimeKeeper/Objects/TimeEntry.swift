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
    var startTime: Date
    var endTime: Date
    var breakStartTime: Date?
    var breakEndTime: Date?
    var hasBeenEdited: Bool = false
    var originalStartTime: Date?
    var originalEndTime: Date?
    
    func hoursBetweenStartAndFinish() -> Int {
        let calendar = Calendar.current
        
        let timeDifference = calendar.dateComponents([.minute], from: startTime, to: endTime)
        
        return timeDifference.minute! / 60
    }
}
