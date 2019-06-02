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
        saveSettings(settings: getSetting()!)
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
            print("BBBAM")
        }
    }
    
    func getSetting() -> Settings?{
        var setting = Settings(usersName: nil, usersEmail: nil,
                               dateFormat: nil, timeFormat: true,
                               firstDayOfWeek: nil, notification: true)
        setting.usersName = nameTextField.text!
        setting.usersEmail = emailTextField.text!
        setting.dateFormat = dayFormatSegmentControl.selectedSegmentIndex
        setting.timeFormat = timeFormatSwitch.isOn
        setting.firstDayOfWeek = firstDaySegmentControl.selectedSegmentIndex
        setting.notification = notificationSwtich.isOn
        return setting
    }
    
    @IBAction func updateName(_ sender: Any) {
        let alert = UIAlertController(title: "Update Name",
                                      message: "Update your name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        [unowned self] action in
                                    guard let textField = alert.textFields?.first,
                                            let nameToSave = textField.text else {
                                                return
                                        }
                                  
                                        self.nameTextField.text = nameToSave
                                        self.saveSettings(settings: self.getSetting()!)

        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
    @IBAction func updateEmail(_ sender: Any) {
        let alert = UIAlertController(title: "Update Email",
                                      message: "Update your email",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        [unowned self] action in
                                        guard let textField = alert.textFields?.first,
                                            let emailToSave = textField.text else {
                                                return
                                        }
                                        
                                        self.emailTextField.text = emailToSave
                                        self.saveSettings(settings: self.getSetting()!)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}
