//
//  ReportsViewController.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 17/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import UIKit

class ReportsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var jobsTableView: UITableView!
    
    let dataStorage: DataStorage = DataStorage()
    var jobs: [Job] = []
    var selectedJob: Job?
    let maxRowsToShow: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJob()
        jobsTableView.dataSource = self
        jobsTableView.delegate = self
        jobsTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(jobs.count, maxRowsToShow)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let job = jobs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobsTableCell") as! JobTableViewCell
        // Get and display the labels the row cells
        cell.setJob(job: job)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(jobs[indexPath.row])")
        //selectedJob = jobs[indexPath.row]
        //self.performSegue(withIdentifier: "JobDetail", sender: nil)
    }
    
    func loadJob() {
        do {
            jobs = try dataStorage.loadJobs()
        }
        catch{
            let alert = UIAlertController(title: "No Job",
                                          message: "Please add more jobs",
                                          preferredStyle: .alert)
            present(alert, animated: true)
        }
        
    }
}
