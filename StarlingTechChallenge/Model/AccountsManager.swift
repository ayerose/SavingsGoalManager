//
//  AccountsManager.swift
//  StarlingTechChallenge
//
//  Created by Soreya Koura on 01.02.24.

// This file is to retrieve accounts for the customer
import Foundation

struct AccountsManager {
    
let headers = [
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer \(ProcessInfo.processInfo.environment["ACCESS_TOKEN"] ?? "")"
    ]
   
    let ACCOUNT_UID = ProcessInfo.processInfo.environment["ACCOUNT_UID"] ?? ""

func fetchAccount() {
    
    guard let url = URL(string:  "https://api-sandbox.starlingbank.com/api/v2/accounts/\(ACCOUNT_UID)/balance") else { return }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    for (key, value) in headers {
           request.addValue(value, forHTTPHeaderField: key)
       }
    // create session
    let session = URLSession(configuration: .default)
    // create task
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
            }
        }
    }
    // start task
    task.resume()
}
}
