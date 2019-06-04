//
//  ViewController.swift
//  TimeKeeper
//
//  Created by Hai Nguyen on 15/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import UIKit
import CoreCharts


class ThisWeekViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CoreChartViewDataSource {
    
    
    
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var barChart: VCoreBarChart!
    
    
    
    var jobName: String?
    var jobIcon: String!
    var entryTime: [TimeEntry]?
    var selectedJob: Job?
    
    let dataStorage: DataStorage = DataStorage()
    var jobs: [Job] = []
    let maxRowsToShow: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJob()
        jobsTableView.dataSource = self
        jobsTableView.delegate = self
        loadTableView()
        barChart.dataSource = self
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
        let cell = jobsTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! JobTableViewCell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(jobs[indexPath.row])")
        selectedJob = jobs[indexPath.row]
        self.performSegue(withIdentifier: "NewEntry", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detail = segue.destination as! NewTimeEntryViewController
        detail.job = selectedJob
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
                                        
                                        self.jobs.append(Job(id: self.jobs.count, name: nameToSave, jobSymbol: nameToSave, timeEntries: []))
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
    
    func loadCoreChartData() -> [CoreChartEntry] {
        var listJob: [String] = []
        var hoursOfWorking: [Double] = []
        
        for job in jobs {
            listJob.append(job.name)
            hoursOfWorking.append(job.totalTimeWorking())
        }
        
        var allJobs = [CoreChartEntry]()
        
        for i in 0..<listJob.count
        {
            let dataEntry = CoreChartEntry(id: String(i), barTitle: listJob[i], barHeight: hoursOfWorking[i], barColor: rainbowColor())
            
            allJobs.append(dataEntry)
        }
        
        return allJobs
    }
    
    
}

