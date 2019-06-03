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
    var hoursOfWork: Double
    // Returns the amount of hours between the start and finish time
    func HoursBetweenStartAndFinish() -> Int {
        let calendar = Calendar.current
        
        let timeDifference = calendar.dateComponents([.minute], from: startTime, to: endTime)
        
        return timeDifference.minute! / 60
    }
    
    // Returns the amount of minutes between the start and finish time
    func MinutesBetweenStartAndFinish() -> Int {
        let calendar = Calendar.current
        
        let timeDifference = calendar.dateComponents([.minute], from: startTime, to: endTime)
        
        return timeDifference.minute! % 60
    }
    
    // Returns the amount of hours between the start and finish break time
    func HoursBetweenBreatStartAndFinish() -> Int? {
        let calendar = Calendar.current
        
        if (breakStartTime != nil) && (breakEndTime != nil) {
            let timeDifference = calendar.dateComponents([.minute], from: breakStartTime!, to: breakEndTime!)
            
            return timeDifference.minute! / 60
        }
        
        return nil
    }
    
    // Returns the amount of minutes between the start and finish break time
    func MinutesBetweenBreatStartAndFinish() -> Int? {
        let calendar = Calendar.current
        
        if (breakStartTime != nil) && (breakEndTime != nil) {
            let timeDifference = calendar.dateComponents([.minute], from: breakStartTime!, to: breakEndTime!)
            
            return timeDifference.minute! % 60
        }
        
        return nil
    }
    
    // Returns the total amount of minutes spent working for this time entry
    func totalAmountOfMinutesWorking() -> Int {
        let calendar = Calendar.current
        
        let timeDifference = calendar.dateComponents([.minute], from: startTime, to: endTime)
        
        return timeDifference.minute!
    }
    
    // Sets the original times and indicated the time entry has been edited
    mutating func SetOriginalTimes() {
        self.originalStartTime = startTime
        self.originalEndTime = endTime
        self.hasBeenEdited = true
    }
    func total() {
        
    }
}
