//
//  DisplaySavingsGoalManager.swift
//  StarlingTechChallenge
//
//  Created by Soreya Koura on 04.02.24.

// This file is to retrieve the saving goal for the customer that was created in SavingsManager.swift

import Foundation
import UIKit


protocol DisplaySavingsGoalManagerDelegate {
    func showSavingsGoal(data: DisplaySavingsGoalData)
    func didFailWithError(error: Error)
}

struct DisplaySavingsGoalManager {
       let headers = [
           "Accept": "application/json",
           "Content-Type": "application/json",
           "Authorization": "Bearer \(ProcessInfo.processInfo.environment["ACCESS_TOKEN"] ?? "")"
       ]
       
       let ACCOUNT_UID = ProcessInfo.processInfo.environment["ACCOUNT_UID"] ?? ""
       let SAVINGSGOAL_UID = ProcessInfo.processInfo.environment["SAVINGSGOAL_UID"] ?? ""
       var delegate: DisplaySavingsGoalManagerDelegate?
       var viewController: UIViewController?
    
    // MARK: retrieve saving goal "New Bose headphones"
    func fetchSavingsGoal() {
            
            guard let url = URL(string: "https://api-sandbox.starlingbank.com/api/v2/account/\(ACCOUNT_UID)/savings-goals/\(SAVINGSGOAL_UID)") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
            
            let session = URLSession(configuration: .default)
            // create task and define what url session needs to do
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error)
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                // ensure that the received HTTP response is a success
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid response")
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let savingsGoalData = try decoder.decode(DisplaySavingsGoalData.self, from: data)
                        self.delegate?.showSavingsGoal(data: savingsGoalData)
                    } catch {
                        print(error)
                        self.delegate?.didFailWithError(error: error)
                    }
                }
            }
            // start task
            task.resume()
        }
    }
