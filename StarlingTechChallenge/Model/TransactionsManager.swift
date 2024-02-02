//
//  TransactionsManager.swift
//  StarlingTechChallenge
//  Created by Soreya Koura on 01.02.24.

// MARK: this file is to retrieve transactions for the customer

import Foundation

struct TransactionsManager {
    
let headers = [
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer \(ProcessInfo.processInfo.environment["ACCESS_TOKEN"] ?? "")"
    ]

let ACCOUNT_UID = ProcessInfo.processInfo.environment["ACCOUNT_UID"] ?? ""

let categoryUID = "00994689-e73c-439a-86ab-57713e9dce91"
let minTransactionTimestamp =  "2024-01-25T12%3A34%3A56.000Z"
let maxTransactionTimestamp =  "2024-02-01T12%3A34%3A56.000Z"
    
// function to fetch all settled transactions between the two provided timestamps
func fetchTransactions() {
    
guard let url = URL(string:  "https://api-sandbox.starlingbank.com/api/v2/feed/account/\(ACCOUNT_UID)/settled-transactions-between?minTransactionTimestamp=\(minTransactionTimestamp)&maxTransactionTimestamp=\(maxTransactionTimestamp)") else { return }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    for (key, value) in headers {
           request.addValue(value, forHTTPHeaderField: key)
       }
    // create session
    let session = URLSession(configuration: .default)
    //  create task and and define what url session needs to do
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
