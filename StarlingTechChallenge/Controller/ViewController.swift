//
//  ViewController.swift
//  StarlingTechChallenge
//
//  Created by Soreya Koura on 01.02.24.

// ViewController for the initial main screen


import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var transferBtn: UIButton!
    @IBOutlet weak var minTransactionTimestampDate: UIDatePicker!
    @IBOutlet weak var maxTransactionTimestampDate: UIDatePicker!
    
    var accountsManager = AccountsManager()
    var savingsManager = SavingsManager()
    var transferMoneyManager = TransferMoneyManager()
    var displaySavingsGoalManager = DisplaySavingsGoalManager()
    var selectedStartDate: Date?
    var selectedEndDate: Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //accountsManager.fetchAccount()
       // savingsManager.createSavingsGoal()
      //  displaySavingsGoalManager.fetchSavingsGoal()

    }
    
    @IBAction func showTransactionWindow(_ sender: Any) {
        selectedStartDate = minTransactionTimestampDate.date
        selectedEndDate = maxTransactionTimestampDate.date
        performSegue(withIdentifier: "showTransactionWindow", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTransactionWindow" {
            if let destinationVC = segue.destination as? TransactionsViewController {
                // set the selected dates
                destinationVC.selectedStartDate = minTransactionTimestampDate.date
                destinationVC.selectedEndDate = maxTransactionTimestampDate.date
                
                //set transactionsManager delegate
                destinationVC.transactionsManager.delegate = destinationVC
            }
        }
    }
}
