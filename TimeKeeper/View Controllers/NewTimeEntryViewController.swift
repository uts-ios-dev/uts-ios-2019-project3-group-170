//
//  NewTimeEntryViewController.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 22/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import UIKit

class NewTimeEntryViewController: UIViewController {
    
    var SwiftTimer = Timer()
    var SwiftCounter = 0
    
    @IBOutlet var countingLabel: UILabel!
    @IBOutlet weak var stopAndPause: UIStackView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopAndPause.isHidden = true
        countingLabel.text = String(SwiftCounter)
        // Make a popup asking which job they would like to log their time against
    }
    
    
    @IBAction func startButton(sender: AnyObject) {
        SwiftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:Selector(("updateCounter")), userInfo: nil, repeats: true)
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
    
    func updateCounter() {
        SwiftCounter += 1
        countingLabel.text = String(SwiftCounter)
    }
}
