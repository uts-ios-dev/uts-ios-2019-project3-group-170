//
//  UIViewController.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 17/5/19.
//  Copyright © 2019 Kieran O'Brien. All rights reserved.
//

import UIKit

class ManualTimeEntryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var timeTextLabel: UILabel!
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    @IBOutlet weak var finishTimeDatePicker: UIDatePicker!
    
    
    @IBAction func startTimeValueChanged(_ sender: UIDatePicker) {
        // update the time label on the screen
    }
    
    @IBAction func endTimeValueChanged(_ sender: UIDatePicker) {
        // update the time label on the screen
    }
    
    @IBAction func userPressedSaveButton(_ sender: UIButton) {
        // save this time entry
    }
    
    // Calculate the amount of hours and mintues betweent the start and end times
    func updateTimeLabel() {
        let calendar = Calendar.current
        
        let timeDifference = calendar.dateComponents([.minute], from: startTimeDatePicker.date, to: finishTimeDatePicker.date)
        
        let hours = timeDifference.minute! / 60
        let minutes = timeDifference.minute!
        
        formatTimeLabel(hours: hours, minutes: minutes)
    }
    
    // Format the amount of hours and minutes into a string
    func formatTimeLabel(hours: Int, minutes: Int) {
        var label: String = ""
        if hours > 99 {
            label += "<99h "
        } else {
            label += "\(hours)h "
        }
        
        label += "\(minutes % 60)min"
        
        timeTextLabel.text = label
    }
}
