//
//  Settings.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 17/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import Foundation

// Used to store the users settings to persistant storage
struct Settings: Codable {
    var usersName: String? 
    var usersEmail: String?
    var dateFormat: Int?
    var timeFormat: Bool = true
    var firstDayOfWeek: Int?
    var notification: Bool = true
    
    init(usersName: String? = nil, usersEmail: String? = nil, dateFormat: Int? = nil,
        timeFormat: Bool, firstDayOfWeek: Int? = nil, notification:Bool) {
        self.usersName = usersName
        self.usersEmail = usersEmail
        self.dateFormat = dateFormat
        self.timeFormat = timeFormat
        self.firstDayOfWeek = firstDayOfWeek
        self.notification = notification
    }
}
