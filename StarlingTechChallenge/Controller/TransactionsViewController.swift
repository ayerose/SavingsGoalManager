//
//  TransactionsViewController.swift
//  StarlingTechChallenge
//
//  Created by Soreya Koura on 03.02.24.

// VC for transaction screen

import Foundation
import UIKit

class TransactionsViewController: UIViewController, TransactionManagerDelegate {
    
    @IBOutlet weak var transactionLabel: UILabel!
    @IBOutlet weak var roundUpLabel: UILabel!
    
    var transactionsManager = TransactionsManager()
    var transferMoneyManager = TransferMoneyManager()
    var selectedStartDate: Date?
    var selectedEndDate: Date?
    var totalRoundUpAmount: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactionsManager.delegate = self
        if let startDate = selectedStartDate, let endDate = selectedEndDate {
            transactionsManager.fetchTransactions(startDate: startDate, endDate: endDate)
            transactionsManager.viewController = self
        }
    }
    func showTransactions(transactions: [TransactionModel]) {
        var transactionText = ""
        for transaction in transactions {
            transactionText += " Amount: \(transaction.minorUnitsToString) \(transaction.currency) \n"
            // ppdate total round-up amount
            let minorUnitsDouble = Double(transaction.minorUnits) / 100.0
            let roundedUpAmount = ceil(minorUnitsDouble) - minorUnitsDouble
            totalRoundUpAmount += roundedUpAmount
        }
        // calculate the time difference in days as no more than 7 days are allowed
        let daysDifference = Calendar.current.dateComponents([.day], from: selectedStartDate ?? Date(), to: selectedEndDate ?? Date()).day ?? 0
        // check if the selected date range is no more than 7 days
        guard daysDifference <= 7 else {
            print("please choose a maximum of 7 days")
            DispatchQueue.main.async {
                self.showAlert(message: "Please choose a date range of up to 7 days.")
            }
            return
        }
        
        DispatchQueue.main.async {
            self.transactionLabel.text = transactionText
            if transactions.isEmpty {
                self.showAlert(message: "No transactions found in the given timeframe.")
            }
        }
    }
    // Alert -  go back to inital window after clicking OK
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Important Note", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            if let navigationController = self?.navigationController {
                // pop the view controller from the navigation stack
                navigationController.popViewController(animated: true)
            } else {
                // dismiss the view controller if it's presented modally
                self?.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // Alert -  stay on same screen after clicking OK
    func showAlertStay(message: String) {
        let alert = UIAlertController(title: "Important Note", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
    }
    func didFailWithError(error: Error) {
        print("Error while fetching transactions: \(error)")
    }
    
    // MARK: calculate round up
    @IBAction func calculateTotalRoundUp(_ sender: Any) {
        let roundedTotalRoundUpAmount = String(format: "%.2f", totalRoundUpAmount)
        self.roundUpLabel.text = "Total Round-Up Amount: \(roundedTotalRoundUpAmount) GBP"
        print("Total Round-Up Amount: \(roundedTotalRoundUpAmount) " )
    }
    
    // MARK: get the calculated round-up to transfer into savings goal
    @IBAction func transferToSavingsGoal(_ sender: Any) {
        
        // Check if the totalRoundUpAmount has been calculated first
          guard totalRoundUpAmount > 0 else {
              showAlertStay(message: "The round-up amount must be greater than 0. There might not be a round-up possible or please calculate it first.")
              return
          }
        let amountToTransfer: [String: Any] = [
            "amount": [
                "currency": "GBP",
                "minorUnits": Int(totalRoundUpAmount * 100) // convert to minor units
            ]
        ] // call completion handler after the transfer has been successfully completed
        transferMoneyManager.transferMoneyIntoSavingsGoal(amountToTransfer: amountToTransfer) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.showAlertStay(message: "Transfer to savings goal successful!")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(message: "Error transferring to savings goal: \(error.localizedDescription)")
                }
            }
        }
    }
    // show "saving goal" screen
    @IBAction func showSavingGoal(_ sender: Any) {
        performSegue(withIdentifier: "displaySavingsGoal", sender: nil)
    }

}
