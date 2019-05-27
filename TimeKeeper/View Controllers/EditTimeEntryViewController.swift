//
//  EditTimeEntryViewController.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 22/5/19.
//  Copyright © 2019 Kieran O'Brien. All rights reserved.
//

import UIKit

class EditTimeEntryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the time labels to be the time entry we are editing
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var originalStartTimeLabel: UILabel!
    @IBOutlet weak var originalFinishTimeLabel: UILabel!
    
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    @IBOutlet weak var endTimeDatePicker: UIDatePicker!
    
    var timeEntry: TimeEntry?
    
    @IBAction func startDateTimeChanged(_ sender: UIDatePicker) {
        print("User has changed the start time")
        updateTimeLabel()
    }
    
    @IBAction func endDateTimeChanged(_ sender: UIDatePicker) {
        print("User has changed the end time")
        updateTimeLabel()
    }
    
    @IBAction func UserPressedSaveButton(_ sender: UIButton) {
    }
    
    // Calculate the amount of hours and mintues betweent the start and end times
    func updateTimeLabel() {
        let calendar = Calendar.current
        
        let timeDifference = calendar.dateComponents([.minute], from: startTimeDatePicker.date, to: endTimeDatePicker.date)
        
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
        
        timeLabel.text = label
    }
}
