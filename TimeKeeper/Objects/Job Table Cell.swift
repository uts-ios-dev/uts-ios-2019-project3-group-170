//
//  Job Table Cell.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 27/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {
    @IBOutlet weak var jobIcon: UIImageView?
    @IBOutlet weak var jobName: UILabel?
    @IBOutlet weak var jobHours: UILabel?
    
    func setJob(job: Job) {
        jobIcon?.image = UIImage(named: job.jobSymbol)
        jobName?.text = job.name
        let total = job.totalTimeWorking()*3600
        jobHours?.text = convertTime(Int(total))
        
    }
    func convertTime(_ totalSeconds: Int) -> String {
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
}
