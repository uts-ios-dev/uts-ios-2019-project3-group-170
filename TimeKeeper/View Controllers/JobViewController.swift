//
//  JobViewController.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 22/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//
import UIKit

class JobViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load the jobs from storage and list them in the table
        jobs = loadJobs()
        
        jobsTable.delegate = self
        jobsTable.dataSource = self
        
        jobsTable.reloadData()
    }
    
    var jobs: [Job]?
    
    @IBOutlet weak var jobsTable: UITableView!
    
    // Set the number of sections to be 1
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Set the number of rows to be the amount of jobs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if jobs!.count > 0 {
            return jobs!.count
        } else {
            emptyMessage(message: "You don't have any jobs yet.\nYou can create up to 10.", viewController: jobsTable)
            return 0
        }
    }
    
    // Format the row cells with the prototype cell class ScoreTableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = jobsTable.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobTableViewCell
        
        let job = jobs![indexPath.row]
        
        cell.jobName?.text = job.name
        // set the job icon
        //cell.jobIcon?.image. = job.jobSymbol
        cell.jobHours?.text = String( job.totalMinutesWorkingThisWeek())
        
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = UIColor.init(red: 225.0/255.0, green: 220.0/255.0, blue: 23.0/255.0, alpha: 1.0)
        }
        else {
            cell.backgroundColor = .clear
        }

        return cell
    }
    
    func emptyMessage(message:String, viewController:UITableView) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        viewController.backgroundView = messageLabel;
        viewController.separatorStyle = .none;
    }
    
    func loadJobs() -> [Job]? {
        let dataStorage = DataStorage()
        
        do {
            return try dataStorage.loadJobs()
        } catch {
            print("There were no jobs to load.")
            return nil
        }
    }
    
}
