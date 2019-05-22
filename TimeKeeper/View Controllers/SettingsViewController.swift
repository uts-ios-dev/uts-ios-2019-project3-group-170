//
//  SettingsViewController.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 17/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func loadSettings() -> Settings? {
        let dataStorage = DataStorage()
        
        var settings: Settings? = nil
        
        do {
            settings = try dataStorage.loadSettings()
        } catch {
            // There were no settings found, create new ones for the user
//            let gameSettings = GameSettings()
            print("There were no settings to load.")
            return nil
        }
        return settings
    }
    
}
