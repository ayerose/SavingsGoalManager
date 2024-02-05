//
//  TransactionsManager.swift
//  StarlingTechChallenge
//  Created by Soreya Koura on 01.02.24.

// MARK: this file is to retrieve transactions for the customer

import Foundation
import UIKit

protocol TransactionManagerDelegate {
    func showTransactions(transactions: [TransactionModel])
    func didFailWithError(error: Error)
}

struct TransactionsManager {
    
let headers = [
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer \(ProcessInfo.processInfo.environment["ACCESS_TOKEN"] ?? "")"
    ]
let ACCOUNT_UID = ProcessInfo.processInfo.environment["ACCOUNT_UID"] ?? ""
let categoryUID = "00994689-e73c-439a-86ab-57713e9dce91"
    
var delegate: TransactionManagerDelegate?
var viewController: UIViewController?
    
// MARK: function to fetch all settled transactions between the two provided timestamps
    
    func fetchTransactions(startDate: Date, endDate: Date) {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let minTransactionTimestamp = dateFormatter.string(from: startDate)
        let maxTransactionTimestamp = dateFormatter.string(from: endDate)

        guard let url = URL(string: "https://api-sandbox.starlingbank.com/api/v2/feed/account/\(ACCOUNT_UID)/settled-transactions-between?minTransactionTimestamp=\(minTransactionTimestamp)&maxTransactionTimestamp=\(maxTransactionTimestamp)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        // create session
        let session = URLSession(configuration: .default)
        //  create task and define what url session needs to do
        let task = session.dataTask(with: request) { data, URLResponse, error in
            if error != nil {
                print(error!)
                return
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    //print("Response JSON: \(json)")
                    if let transactions = parseJSON(transactionData: data) {
                        // send transaction object to the view controller
                        self.delegate?.showTransactions(transactions: transactions)
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
        }
        // start task
        task.resume()
    }
        // MARK: translate received JSON data to swift
        func parseJSON(transactionData: Data) -> [TransactionModel]? {
            let decoder = JSONDecoder()
            var transactions: [TransactionModel] = []
            
            do {
                let decodeData = try decoder.decode(TransactionData.self, from: transactionData)
                // iterate over each FeedItems in the feedItems array
                for FeedItems in decodeData.feedItems {
                    // access the amount property witin each FeedItems
                    let minorUnits = FeedItems.amount.minorUnits
                    let currency = FeedItems.amount.currency
                    print("Transaction Amount: \(Double(minorUnits) / 100.0) \(currency)")
                    
                    let transaction = TransactionModel(currency: currency, minorUnits: Int(minorUnits))
                    transactions.append(transaction)
                }
            } catch {
                print(error)
            }
            return transactions
        }

    }

