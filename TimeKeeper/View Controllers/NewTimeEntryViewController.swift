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
    var date: Date { return Date() }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)

        // Make a popup asking which job they would like to log their time against
    }
    
    @IBAction func startShift(_ sender: UIButton) {
        
    }
    
    @IBAction func startBreak(_ sender: UIButton) {
    }
    
    @IBAction func stopBreak(_ sender: UIButton) {
    }
    
    @IBAction func stopShift(_ sender: UIButton) {
    }
    
    @objc func updateCounter() {
        SwiftCounter += 1
       // countingLabel.text = String(SwiftCounter)
    }
    
    @objc func tick() {
        clockLabel.text = DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .short)
    }
    func intToTime(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
    
}
