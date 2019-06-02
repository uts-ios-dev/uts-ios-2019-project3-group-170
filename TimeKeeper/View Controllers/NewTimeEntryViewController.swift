//
//  NewTimeEntryViewController.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 22/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import UIKit

class NewTimeEntryViewController: UIViewController {
    
    let dataStorage = DataStorage()
    let date = Date()
    let calendar = Calendar.current
    var job: Job?
    
    var dateComponents = DateComponents()
    var SwiftTimer = Timer()
    var SwiftCounter = 0
    
    var timeStart: Date!
    var timeEnd: Date!
    var timeStartBreak: Date!
    var timeEndBreak: Date!
    var hoursWorking: Double = 0.0
    
    @IBOutlet var countingLabel: UILabel!
    @IBOutlet weak var currentTime: UILabel!
   // @IBOutlet var gsdf:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countingLabel.text = String(SwiftCounter)
        SwiftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)

        // Make a popup asking which job they would like to log their time against
    }
    
    
    @IBAction func stopButton(sender: AnyObject) {
        hoursWorking = Double(SwiftCounter) / 3600
        SwiftTimer.invalidate()
        SwiftCounter = 0
        countingLabel.text = String(SwiftCounter)
        
        let entry = TimeEntry(id: nil,startTime: timeStart, endTime: timeEnd, breakStartTime: timeStartBreak, breakEndTime: timeEndBreak, hasBeenEdited: false, originalStartTime: nil, originalEndTime: nil, hoursOfWork: hoursWorking)
        do {
            try dataStorage.saveTimeEntry(entry: [entry])
        } catch {
            print(error)
        }
    }
    
    @objc func updateCounter() {
        SwiftCounter += 1
        countingLabel.text = String(SwiftCounter)
    }
    
    @objc func tick() {
        currentTime.text = DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .medium)
    }
    func intToTime(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
    
}
