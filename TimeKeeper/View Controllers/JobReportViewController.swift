//
//  JobReportViewController.swift
//  TimeKeeper
//
//  Created by Kieran O'Brien on 22/5/19.
//  Coded by Hai Nguyen on 4/6/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import UIKit
import Charts

class JobReportViewController: UIViewController {
    
    var months: [String]!
    @IBOutlet weak var weekChart: BarChartView!
    @IBOutlet weak var monthChart: BarChartView!
    @IBOutlet weak var yearChart: BarChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        // Do any additional setup after loading the view.
    }
    
}
