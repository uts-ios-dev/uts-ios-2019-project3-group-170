//
//  Jobs.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 17/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import Foundation

struct Job: Codable {
    var id: Int8?
    var name: String
    var jobSymbol: String
    var timeEntries: [TimeEntry]
    
    // Loops over the time entry array and adds all the working minutes, then returns the total to the calling function.
    func totalMinutesWorking() -> Int {
        var totalTime = 0
        
        for timeEntry in timeEntries {
            totalTime += timeEntry.totalAmountOfMinutesWorking()
        }
        
        return totalTime
    }
    
    // Loop over the array and if the time entry was within the current week, add it to the total. Once all values have been checked return the total to the calling function.
    func totalMinutesWorkingThisWeek() -> Int {
        var totalTime = 0
        
        for timeEntry in timeEntries {
            // if timeEntry.endTime > dateAtStartOfWeek {
            //     totalTime += timeEntry.hours
            // }
        }
        
        return totalTime
    }
}
