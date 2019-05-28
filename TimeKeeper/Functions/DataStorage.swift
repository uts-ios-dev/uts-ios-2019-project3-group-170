//
//  DataStorage.swift
//  BubblePop
//
//  Created by by Kieran O'Brien on 17/5/19.
//  Copyright © 2019 Kieran O'Brien. All rights reserved.
//

import Foundation

// Model struct for storing data
struct DataStorage: Codable {
    let settingsLocation: URL
    let jobsLocation: URL
    
    // Custom enum for data errors
    enum DataError: Error {
        case dataNotFound
        case dataNotSaved
    }
    
    init() {
        // Set up URLs
        let persistantStorageDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        settingsLocation = persistantStorageDirectory.appendingPathComponent("settings")
            .appendingPathExtension("json")
        jobsLocation = persistantStorageDirectory.appendingPathComponent("jobs")
            .appendingPathExtension("json")
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
    
    // Saves the settings object passed into it to persistant storage
    func saveSettings(settings: Settings) throws {
        let data = try JSONEncoder().encode(settings)
        try write(data, to: settingsLocation)
    }
    
    // Saves the jobs object passed into it to persistant storage
    func saveJobs(jobs: [Job]) throws {
        let data = try JSONEncoder().encode(jobs)
        try write(data, to: jobsLocation)
    }
    
    // Loads the settings object from persistant storage, and returns it to the calling method
    func loadSettings() throws -> Settings {
        let data = try read(from: settingsLocation)
        if let settings = try? JSONDecoder().decode(Settings.self, from: data) {
            return settings
        }
        throw DataError.dataNotFound
    }
    
    // Loads the jobs object from persistant storage, and returns it to the calling method
    func loadJobs() throws -> [Job] {
        let data = try read(from: jobsLocation)
        if let jobs = try? JSONDecoder().decode([Job].self, from: data) {
            return jobs
        }
        throw DataError.dataNotFound
    }
    
}
