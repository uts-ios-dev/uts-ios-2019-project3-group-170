//
//  JobsViewController.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 17/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import UIKit

class JobViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNavigationBar()
    }
    
    var job: Job?
    @IBOutlet weak var jobTabel: UITableView!
    @IBOutlet weak var nativationBar: UINavigationItem!
    
    func updateNavigationBar(){
        self.nativationBar.title = job?.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = jobTabel.dequeueReusableCell(withIdentifier: "Job Detail View Cell", for: indexPath) as! JobDetailTableViewCell
        
        let timeEntry = job?.timeEntries[indexPath.row]
        
        
        cell.dateLabel.text = "11/11/11" // To be implemented
        cell.startEndLabel.text = setStartEndLabel(startDate: timeEntry!.startTime, endDate: timeEntry!.endTime)
        cell.timeLabel.text = setTimeLabel(amountOfMinutes: (timeEntry?.totalAmountOfMinutesWorking())!)
        
        return JobTableViewCell()
    }
    
    func setStartEndLabel(startDate: Date, endDate: Date) -> String {
        // To be implemented
        return ""
    }
    
    func setTimeLabel(amountOfMinutes: Int) -> String {
        // To be implemented
        
        return ""
    }
    
    @IBAction func addTimeEntry(_ sender: UIButton) {
    }
}
