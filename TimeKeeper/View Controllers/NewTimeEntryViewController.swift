//
//  NewTimeEntryViewController.swift
//  TimeKeeper
//
//  Created by Hai Nguyen on 22/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import UIKit

class NewTimeEntryViewController: UIViewController {
    
    
    let dataStorage = DataStorage()
    var date: Date { return Date() }
    let calendar = Calendar.current
    var job: Job?
    var jobs: [Job] = []
    
    var dateComponents = DateComponents()
    var SwiftTimer = Timer()
    var jobTimer = Timer()
    var SwiftCounter = 0
    var timeBreak = 0
    
    var timeStart: Date!
    var timeEnd: Date!
    var timeStartBreak: Date?
    var timeEndBreak: Date?
    var hoursWorking: Double = 0.0
    
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var hoursOfWorkingLabel: UILabel!
    @IBOutlet weak var jobNameLabel: UILabel!
    @IBOutlet weak var startBreakLabel: UIStackView!
    @IBOutlet weak var endShiftLabel: UIStackView!
    // @IBOutlet var gsdf:
    @IBOutlet weak var stopLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var startShiftLabel: UILabel!
    
    @IBOutlet weak var startShift: UIButton!
    @IBOutlet weak var stopAndStartBreak: UIStackView!
    @IBOutlet weak var stopBreakButton: UIButton!
    
    @IBOutlet weak var breakEnd: UIStackView!
    
    override func viewDidLoad() {
        loadJob()
        stopAndStartBreak.isHidden = true
        stopBreakButton.isHidden = true
        stopLabel.isHidden = true
        startBreakLabel.isHidden = true
        endShiftLabel.isHidden = true
        startLabel.isHidden = true
        breakEnd.isHidden = true
        super.viewDidLoad()
        jobNameLabel.text = job?.name
        SwiftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)

        // Make a popup asking which job they would like to log their time against
    }
    
    @IBAction func startShift(_ sender: UIButton) {
        startShift.isHidden = true
        startShiftLabel.isHidden = true
        stopAndStartBreak.isHidden = false
        startBreakLabel.isHidden = false
        endShiftLabel.isHidden = false
        stopLabel.isHidden = false
        startLabel.isHidden = false
        jobTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        timeStart = date
        statusLabel.text = "You have clocked in to work"
    }
    
    @IBAction func startBreak(_ sender: UIButton) {
        stopAndStartBreak.isHidden = true
        stopBreakButton.isHidden = false
        stopLabel.isHidden = true
        startLabel.isHidden = true
        startBreakLabel.isHidden = true
        endShiftLabel.isHidden = true
        breakEnd.isHidden = false
        startShiftLabel.text = "End Break"
        startShiftLabel.isHidden = false
        jobTimer.invalidate()
        jobTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeBreak), userInfo: nil, repeats: true)
        jobNameLabel.text = "Enjoy your break! :)"
        timeStartBreak = date
    }
    
    @IBAction func stopBreak(_ sender: UIButton) {
        stopAndStartBreak.isHidden = false
        stopBreakButton.isHidden = true
        stopLabel.isHidden = false
        startLabel.isHidden = false
        startBreakLabel.isHidden = false
        endShiftLabel.isHidden = false
        breakEnd.isHidden = true
        startShiftLabel.isHidden = true
        jobTimer.invalidate()
        jobTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        jobNameLabel.text = job?.name
        timeBreak = 0
        timeEndBreak = date
    }
    
    @IBAction func stopShift(_ sender: UIButton) {
        alert()
        
    }
    
    @objc func updateCounter() {
        SwiftCounter += 1
        hoursOfWorkingLabel.text = intToTime(SwiftCounter)
    }
    
    @objc func updateTimeBreak() {
        timeBreak += 1
        hoursOfWorkingLabel.text = intToTime(timeBreak)
    }
    
    @objc func tick() {
        clockLabel.text = DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .short)
    }
    func intToTime(_ totalSeconds: Int) -> String {
        if totalSeconds > 60 {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
            return String(format: "%01dm%02ds", minutes, seconds)
            
        }
        else if totalSeconds > 3600 {
            let minutes: Int = totalSeconds % 3600
            let hours: Int = (totalSeconds / 3600) % 3600
            return String(format: "%01dh%02dm", hours, minutes)
            
        }
        return String(totalSeconds)
    }
    
    func alert() {
        let alert = UIAlertController(title: "Your shift is finished?", message: "All of time working will be save!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { action in self.actionStopShift()})
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func actionStopShift() {
        timeEnd = date
        hoursWorking = (Double(SwiftCounter) / 3600)
        job?.timeEntries.append(TimeEntry(id: nil, startTime: timeStart, endTime: timeEnd, breakStartTime: timeStartBreak, breakEndTime: timeEndBreak, hasBeenEdited: false, originalStartTime: nil, originalEndTime: nil, hoursOfWork: hoursWorking))
        jobs[(job?.id)!] = job!
        do {
            try self.dataStorage.saveJobs(jobs: jobs)
        } catch {
            print("Error saving scoreboard")
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "MainStoryBoard")
        self.present(vc, animated: true, completion: nil);
    }
    func loadJob() {
        do {
            jobs = try dataStorage.loadJobs()
        }
        catch{
            let alert = UIAlertController(title: "Error", message: "Not able to load jobs", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        
    }
}
