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
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var hoursLable: UILabel!
    
    var jobName: String?
    var jobIcon: String!
    var entryTime: [TimeEntry]?
    
    let dataStorage: DataStorage = DataStorage()
    var jobs: [Job] = []
    let maxRowsToShow: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJob()
        jobsTableView.dataSource = self
        jobsTableView.delegate = self
        
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
        let job = jobs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! JobTableViewCell
        // Get and display the labels the row cells
        cell.setJob(job: job)
        
        return cell
        /*let nameLabelCell: UILabel = cell.viewWithTag(1) as! UILabel
        let jobIconCell: UIImageView = cell.viewWithTag(2) as! UIImageView
        
        nameLabelCell.text = "\(indexPath.row + 1). \(jobs[indexPath.row].name)"
        jobIcon = jobs[indexPath.row].jobSymbol
        jobIconCell.image = UIImage(named: (jobs[indexPath.row].jobSymbol))
        
        // Alternate the cell background color
        if indexPath.row % 2 == 1 {
            let lightCyan = UIColor(red: 224/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
            cell.backgroundColor = lightCyan
        }
        else {
            cell.backgroundColor = .clear
        }
        
        return cell*/
    }
    
    /// Set the title for table section's header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Top Jobs"
    }
    
    func loadJob() {
        do {
            jobs = try dataStorage.loadJobs()
        }
        catch{
            statusLabel.text = "You have not done any job"
        }
        
    }

}
