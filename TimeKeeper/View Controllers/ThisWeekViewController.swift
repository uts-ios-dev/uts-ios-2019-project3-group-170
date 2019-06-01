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
        loadTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(loadTableView), name: NSNotification.Name(rawValue: "loadTable"), object: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! JobTableViewCell
        // Get and display the labels the row cells
        //cell.setJob(job: job)
        cell.jobName?.text = job.name
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

    @objc func loadTableView() {
        self.jobsTableView.reloadData()
    }
    @IBAction func addJob(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "New Job",
                                      message: "Add a new Job name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        [unowned self] action in
                                        
                                        guard let textField = alert.textFields?.first,
                                            let nameToSave = textField.text else {
                                                return
                                        }
                                        
                                        self.jobs.append(Job(id: 2, name: nameToSave, jobSymbol: nameToSave, timeEntries: []))
                                        do {
                                            try self.dataStorage.saveJobs(jobs: self.jobs)
                                        } catch {
                                            print("Error saving scoreboard")
                                        }
                                        self.jobsTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

