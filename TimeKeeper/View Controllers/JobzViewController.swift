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
        // Do any additional setup after loading the view.
    }
    
    var job: Job?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}
