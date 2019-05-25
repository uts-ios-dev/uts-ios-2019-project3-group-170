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
        // Do any additional setup after loading the view.
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
    
    // Calculate the amount of hours and mintues betweent the start and end times
    func updateTimeLabel() {
        let dateString1 = startTimeDatePicker.date
        let dateString2 = endTimeDatePicker.date
        
        let calendar = Calendar.current
        
        let timeDifference = calendar.dateComponents([.minute], from: dateString1, to: dateString2)
        
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
