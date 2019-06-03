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
        jobHours?.text = String(job.totalTimeWorking())
    }
}
