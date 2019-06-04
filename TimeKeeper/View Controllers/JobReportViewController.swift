//
//  JobReportViewController.swift
//  TimeKeeper
//
//  Created by Hai Nguyen on 22/5/19.
//  Coded by Hai Nguyen on 4/6/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import UIKit
import CoreCharts

class JobReportViewController: UIViewController, CoreChartViewDataSource {
    
    let date = Date()
    var job: Job?
    let calendar = NSCalendar.current
    
    
    @IBOutlet weak var weekChart: VCoreBarChart!
    
    override func viewDidLoad() {
        print(job as Any)
        super.viewDidLoad()
        weekChart.dataSource = self
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = true
        // Do any additional setup after loading the view.
    }
    
    func dayRangeOf(weekOfYear: Int, for date: Date) -> Range<Date>
    {
        let calendar = Calendar.current
        let year = calendar.component(.yearForWeekOfYear, from: date)
        let startComponents = DateComponents(weekOfYear: weekOfYear, yearForWeekOfYear: year)
        let startDate = calendar.date(from: startComponents)!
        let endComponents = DateComponents(day:7, second: -1)
        let endDate = calendar.date(byAdding: endComponents, to: startDate)!
        return startDate..<endDate
    }
    func loadCoreChartData() -> [CoreChartEntry] {
        var listTime: [String] = []
        var hoursOfWorking: [Double] = []
        
        let component = calendar.component(.weekOfYear, from: date)
        let weekRange: Range<Date> = dayRangeOf(weekOfYear: component, for: date)
        for timeEntry in job!.timeEntries {
            if weekRange.contains(timeEntry.startTime) {
                let a = DateFormatter.localizedString(from: timeEntry.startTime, dateStyle: .short, timeStyle: .none)
                if listTime.contains(a){
                    let b = hoursOfWorking.last! + timeEntry.hoursOfWork
                    hoursOfWorking.removeLast()
                    hoursOfWorking.append(b)
                }
                else {
                    listTime.append(a)
                    hoursOfWorking.append(timeEntry.hoursOfWork)
                    
                }
                
            }
        }
        
        var allJobs = [CoreChartEntry]()
        
        for i in 0..<listTime.count
        {
            let dataEntry = CoreChartEntry(id: String(i), barTitle: listTime[i], barHeight: hoursOfWorking[i], barColor: rainbowColor())
            
            allJobs.append(dataEntry)
        }
        
        return allJobs
    }
    
}
