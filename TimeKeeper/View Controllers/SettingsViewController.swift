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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var setting: Settings? = loadSettings()
        if(setting != nil){
            nameTextField.text = setting!.usersName!
            emailTextField.text = setting!.usersEmail!
            dayFormatSegmentControl.selectedSegmentIndex = setting!.dateFormat!
            timeFormatSwitch.setOn(setting!.timeFormat, animated: true)
            //firstDaySegmentControl.selectedSegmentIndex = setting!.firstDaySegmentControl! // Please make sure this exists!
            notificationSwtich.setOn(setting!.notification, animated:true)
        }
//        else {
//            setting = Settings() // Are you trying to create a new Settings object?
//            let alert = UIAlertController(title: "Input", message: "Please enter your name and email address.", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "Enter", style: UIAlertActionStyle.default. handler: {(action: UIAlertAction) in
//                nameTextField.text = alert.nameInputTextField?.text
//                emailTextField.text = alert.emailInputTextField?.text
//                }))
//            alert.addTextFieldWithConfigurationHandler({(nameInputTextField: UITextField!) in
//                nameInputTextField.placeholder = "Enter your name:"
//            })
//            alert.addTextFieldWithConfigurationHandler({(emailInputTextField: UITextField!) in
//                emailInputTextField.placeholder = "Enter your email:"
//            })
//            self.presentViewController(alert, animated: true, completion: nil)
//        }
    }
    
//    func updateSettings() {
//        Settings setting  = Settings() // Are you trying to create a new Settings object?
//        setting.usersName = nameTextField.text
//        setting.usersEmail = emailTextField.text
//        setting.dateFormat = dayFormatSegmentControl.selectedSegmentIndex
//        setting.timeFormat = timeFormatSwitch.isOn()
//        setting.firstDaySegmentControl = firstDaySegmentControl.selectedSegmentIndex
//        setting.notification = notificationSwtich.isOn();
//    }
    
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
            try dataStorage.saveSettings(settings: settings)
        } catch {
            // The save didnt work, please do something here
        }
    }
}
