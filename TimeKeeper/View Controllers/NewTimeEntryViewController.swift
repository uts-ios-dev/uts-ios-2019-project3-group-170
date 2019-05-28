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
    var dateComponents = DateComponents()
    var SwiftTimer = Timer()
    var SwiftCounter = 0
    
    
    @IBOutlet var countingLabel: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var stopAndPause: UIStackView!
    @IBOutlet weak var startButton: UIButton!
   // @IBOutlet var gsdf:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopAndPause.isHidden = true
        countingLabel.text = String(SwiftCounter)
        SwiftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        // Make a popup asking which job they would like to log their time against
    }
    
    
    @IBAction func startButton(sender: AnyObject) {
        SwiftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        startButton.isHidden = true
        stopAndPause.isHidden = false
        
    }
    @IBAction func pauseButton(sender: AnyObject) {
        SwiftTimer.invalidate()
    }
    @IBAction func stopButton(sender: AnyObject) {
        SwiftTimer.invalidate()
        SwiftCounter = 0
        countingLabel.text = String(SwiftCounter)
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
