//
//  Settings.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 17/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import Foundation

struct Settings: Codable {
    var usersName: String
    var usersEmail: String?
    var dateFormat: String
    var timeFormat: String
    var firstDayOfWeek: String
    
}

struct DateFormats: Codable {
    
}
