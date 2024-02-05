//
//  SavingsManager.swift
//  StarlingTechChallenge
//
//  Created by Soreya Koura on 01.02.24.

// This file is to create a savings goals

import Foundation

struct SavingsManager {

let headers = [
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer \(ProcessInfo.processInfo.environment["ACCESS_TOKEN"] ?? "")"
    ]
let ACCOUNT_UID = ProcessInfo.processInfo.environment["ACCOUNT_UID"] ?? ""
// define new savings goal
let newSavingsGoal: [String: Any] = [
           "name": "New Bose headphones",
           "currency": "GBP",
           "target": [
               "currency": "GBP",
               "minorUnits": 58000
           ]
       ]
// create the defined savings goal with PUT request
func createSavingsGoal() {

    guard let url = URL(string:  "https://api-sandbox.starlingbank.com/api/v2/account/\(ACCOUNT_UID)/savings-goals") else { return }
      
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        for (key, value) in headers {
               request.addValue(value, forHTTPHeaderField: key)
           }
        // convert to JSON
         do {
             let jsonData = try JSONSerialization.data(withJSONObject: newSavingsGoal)
             request.httpBody = jsonData
         } catch {
             print("Error creating JSON data: \(error)")
             return
         }
    // create session
        let session = URLSession(configuration: .default)
    // create task and and define what url session needs to do
        let task = session.dataTask(with: request) { data, URLResponse, error in
            if error != nil {
                print(error!)
                return
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Response JSON: \(json)")
                } catch {
                    print("Error parsing JSON: \(error)")
                    print(url)
                }}
        }
        // start task
        task.resume()
    }
    }
