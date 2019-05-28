//
//  ViewController.swift
//  TimeKeeper
//
//  Created by Trent Diamond on 15/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import UIKit

class ThisWeekViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var jobIconImage: UIImageView!
    @IBOutlet weak var jobNameLabel: UILabel!
    @IBOutlet weak var jobHoursWorkingLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var jobsTableView: UITableView!
    
    var jobName: String!
    var jobIcon: String!
    var hoursWorking: Double!
    
    let dataStorage: DataStorage = DataStorage()
    var jobs: [Job] = []
    let maxRowsToShow: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            jobs = try dataStorage.loadJobs()
        }
        catch{
            statusLabel.text = "You have not done any job"
        }
        jobsTableView.dataSource = self
        jobsTableView.delegate = self
        
        if let name = jobName {
            jobNameLabel.text = name
            
            jobHoursWorkingLabel.text = "\(hoursWorking!) h"
            
            let newEntry = Job(id: nil, name: name, jobSymbol: jobIcon, timeEntries: <#T##[TimeEntry]#>)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Set the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(jobs.count, maxRowsToShow)
    }
    
    /// Format the row cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameScoreCell", for: indexPath)
        
        // Get and display the labels the row cells
        let nameLabelCell: UILabel = cell.viewWithTag(1) as! UILabel
        let scoreLabelCell: UILabel = cell.viewWithTag(2) as! UILabel
        
        nameLabelCell.text = "\(indexPath.row + 1). \(jobs[indexPath.row].name)"
        scoreLabelCell.text = ": \(jobs[indexPath.row].score) points"
        
        // Alternate the cell background color
        if indexPath.row % 2 == 1 {
            let lightCyan = UIColor(red: 224/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
            cell.backgroundColor = lightCyan
        }
        else {
            cell.backgroundColor = .clear
        }
        
        return cell
    }
    
    /// Set the title for table section's header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Top 10 Ranks"
    }

}

