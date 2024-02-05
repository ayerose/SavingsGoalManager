//
//  TransferMoneyManager.swift
//  StarlingTechChallenge
//
//  Created by Soreya Koura on 02.02.24.

// this file is to transfer money into the savings goal that is created in SavingsManager.swift

import Foundation

// delegate protocol for handling transferMoneyIntoSavingsGoal
protocol TransferMoneyDelegate: AnyObject {
    func transferDidComplete(result: Result<Void, Error>)
}

struct TransferMoneyManager {
    
    let headers = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer \(ProcessInfo.processInfo.environment["ACCESS_TOKEN"] ?? "")"
        ]

    let ACCOUNT_UID = ProcessInfo.processInfo.environment["ACCOUNT_UID"] ?? ""
    let SAVINGSGOAL_UID = ProcessInfo.processInfo.environment["SAVINGSGOAL_UID"] ?? "" // "new bose headphones" saving goal
    let transferUID = UUID().uuidString // creates a random UUID
    weak var delegate: TransferMoneyDelegate?
    

// transfer the calculated round-up to savings goal with PUT requests
    func transferMoneyIntoSavingsGoal(amountToTransfer: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        
    guard let url = URL(string:  "https://api-sandbox.starlingbank.com/api/v2/account/\(ACCOUNT_UID)/savings-goals/\(SAVINGSGOAL_UID)/add-money/\(transferUID)") else { return }
      
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        for (key, value) in headers {
               request.addValue(value, forHTTPHeaderField: key)
           }
    // convert to JSON
         do {
             let jsonData = try JSONSerialization.data(withJSONObject: amountToTransfer)
             request.httpBody = jsonData
         } catch {
             print("Error creating JSON data: \(error)")
             completion(.failure(error))
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
                    completion(.success(()))
                } catch {
                    print("Error parsing JSON: \(error)")
                    print(url)
                }
            }
        }
        // start task
        task.resume()
    }
}
