//
//  SettingsViewController.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 17/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //var settings: Settings = loadSettings()
    
    func loadSettings() {
        let dataStorage = DataStorage()
        
        do {
            let settings = try dataStorage.loadSettings()
        } catch {
            // There were no settings found, create new ones for the user
//            let gameSettings = GameSettings()
        }
    }
    
}
