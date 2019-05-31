//
//  AddNewJobViewController.swift
//  TimeKeeper
//
//  Created by Hai Nguyen on 31/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import UIKit

class AddNewJobViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    let dataStorage: DataStorage = DataStorage()
    var jobs: [Job] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func save(_ sender: UIButton) {
        let jobName: String? = jobTextField.text!
        if let name = jobName{
            
        let newJob = Job(id: 1, name: name, jobSymbol: name, timeEntries: [])
        jobs.append(newJob)
        
        do {
            try dataStorage.saveJobs(jobs: jobs)
        }
        catch{
            let alertController = UIAlertController(title: "iOScreator", message:
                "Error saving job", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        dismiss(animated: true)
            //do some thing here after dissmiss to reload the board
        }
    }
}
