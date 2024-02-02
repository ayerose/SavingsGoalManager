//
//  TransferMoneyManager.swift
//  StarlingTechChallenge
//
//  Created by Soreya Koura on 02.02.24.
// MARK: this file is to transfer money to savings goals

import Foundation

struct TransferMoneyManager {
    
    
    let headers = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer \(ProcessInfo.processInfo.environment["ACCESS_TOKEN"] ?? "")"
        ]

    let ACCOUNT_UID = ProcessInfo.processInfo.environment["ACCOUNT_UID"] ?? ""
    
    let savingsGoalUID = "16bc62b8-dc89-47d2-953d-cc7e33fabe65"
    let transferUID = UUID().uuidString
    
    // define amount of money to transfer into a savings goal
    let amountToTransferIntoSavingsGoal: [String: Any] = [
      "amount": [
        "currency": "GBP",
        "minorUnits": 12345
      ]
        ]
    
    
    // create new savings goal
    func transferMoneyIntoSavingsGoal() {
        
    guard let url = URL(string:  "https://api-sandbox.starlingbank.com/api/v2/account/\(ACCOUNT_UID)/savings-goals/\(savingsGoalUID)/add-money/\(transferUID)") else { return }
      
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        for (key, value) in headers {
               request.addValue(value, forHTTPHeaderField: key)
           }
        

    // convert to JSON
         do {
             let jsonData = try JSONSerialization.data(withJSONObject: amountToTransferIntoSavingsGoal)
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
                }
            }
        }
        // start task
        task.resume()
        
    }
    
}
