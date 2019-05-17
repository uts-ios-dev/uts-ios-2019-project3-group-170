//
//  Jobs.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 17/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import Foundation

struct Job: Codable {
    var ID: Int8
    var name: String
    var timeEntries: [TimeEntry]
    
}
