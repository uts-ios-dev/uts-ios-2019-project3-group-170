//
//  JobViewController.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 22/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//
import UIKit

class JobsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load the jobs from storage and list them in the table
        jobs = loadJobs()
        
        jobsTable.delegate = self
        jobsTable.dataSource = self
        
        jobsTable.reloadData()
    }
    
    var jobs: [Job]?
    var selectedJob: Job?
    let dataStorage: DataStorage = DataStorage()
    
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
            //emptyMessage(message: "You don't have any jobs yet.\nYou can create up to 10.", viewController: jobsTable)
            return 0
        }
    }
    
    // Format the row cells with the prototype cell class ScoreTableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = jobsTable.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobTableViewCell
        
        let job = jobs?[indexPath.row]
        
        cell.jobName?.text = job?.name
        // set the job icon
        cell.jobIcon?.image = UIImage(named: job?.jobSymbol ?? "Jobs Icon")
        if job?.totalMinutesWorkingThisWeek() != nil {
            cell.jobHours?.text = String(job!.totalMinutesWorkingThisWeek())
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(jobs![indexPath.row])")
        selectedJob = jobs![indexPath.row]
        performSegue(withIdentifier: "Show Job", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detail = segue.destination as! NewTimeEntryViewController
        detail.job = selectedJob
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
                                        
                                        self.jobs!.append(Job(id: 2, name: nameToSave, jobSymbol: nameToSave, timeEntries: []))
                                        do {
                                            try self.dataStorage.saveJobs(jobs: self.jobs!)
                                        } catch {
                                            print("Error saving scoreboard")
                                        }
        }
        
        self.jobsTable.reloadData()
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)

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
        do {
            return try dataStorage.loadJobs()
        } catch {
            print("There were no jobs to load.")
            return nil
        }
    }
    
}
