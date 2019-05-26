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
    var timeFormat: Bool
    var firstDayOfWeek: Int?
    var notification: Bool
}
