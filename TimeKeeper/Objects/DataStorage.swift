//
//  DataStorage.swift
//  TimeKeeper
//
//  Created by Hai Nguyen on 22/5/19.
//  Copyright © 2019 Trent Diamond. All rights reserved.
//

import Foundation

struct DataStorage: Codable {
    let reportArchiveURL: URL
    
    enum DataError: Error {
        case dataNotFound
        case dataNotSaved
    }
    
    init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        reportArchiveURL = documentsDirectory.appendingPathComponent("jobs_report").appendingPathExtension("json")
    }
    
    func read(from archive: URL) throws -> Data {
        if let data = try? Data(contentsOf: archive) {
            return data
        }
        throw DataError.dataNotFound
    }
    
    func write(_ data: Data, to archive: URL) throws {
        do {
            try data.write(to: archive, options: .noFileProtection)
        }
        catch {
            throw DataError.dataNotSaved
        }
    }
    
    func saveData(reports: Job) throws {
        let data = try JSONEncoder().encode(reports)
        try write(data, to: reportArchiveURL)
    }
    
    func loadReports() throws -> Job {
        let data = try read(from: reportArchiveURL)
        if let reports = try? JSONDecoder().decode(Job.self, from: data) {
                return reports
        }
        throw DataError.dataNotFound
    }
}
