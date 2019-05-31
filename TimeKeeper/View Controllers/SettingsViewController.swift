//
//  SettingsViewController.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 17/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dayFormatSegmentControl: UISegmentedControl!
    @IBOutlet weak var timeFormatSwitch: UISwitch!
    @IBOutlet weak var firstDaySegmentControl: UISegmentedControl!
    @IBOutlet weak var notificationSwtich: UISwitch!
    
    override func viewDidDisappear(_ animated: Bool) {
        var setting = Settings(usersName: nil, usersEmail: nil,
                               dateFormat: nil, timeFormat: true,
                               firstDayOfWeek: nil, notification: true)
        setting.usersName = nameTextField.text!
        setting.usersEmail = emailTextField.text!
        setting.dateFormat = dayFormatSegmentControl.selectedSegmentIndex
        setting.timeFormat = timeFormatSwitch.isOn
        setting.firstDayOfWeek = firstDaySegmentControl.selectedSegmentIndex
        setting.notification = notificationSwtich.isOn
        saveSettings(settings: setting)
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        var setting: Settings? = loadSettings()
        if(setting != nil){
            nameTextField.text = setting!.usersName!
            emailTextField.text = setting!.usersEmail!
            dayFormatSegmentControl.selectedSegmentIndex = setting!.dateFormat!
            timeFormatSwitch.setOn(setting!.timeFormat, animated: true)
            firstDaySegmentControl.selectedSegmentIndex = setting!.firstDayOfWeek!
            notificationSwtich.setOn(setting!.notification, animated:true)
        }
        else {
            var setting: Settings?
            setting?.timeFormat = false
            setting?.notification = false
            if(setting != nil){
                saveSettings(settings: setting!)
            }
        }
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
    
    func saveSettings(settings: Settings) {
        let dataStorage = DataStorage()
        
        do {
            print("do")
            try dataStorage.saveSettings(settings: settings)
        } catch {
            // The save didnt work, please do something here
        }
    }
}
