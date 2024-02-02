//
//  ViewController.swift
//  StarlingTechChallenge
//
//  Created by Soreya Koura on 01.02.24.
//


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var roundUpLabel: UILabel!
    @IBOutlet weak var transferBtn: UIButton!
    
    var accountsManager = AccountsManager()
    var transactionsManager = TransactionsManager()
    var savingsManager = SavingsManager()
    var transferMoneyManager = TransferMoneyManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //accountsManager.fetchAccount()
       // transactionsManager.fetchTransactions()
        //savingsManager.createSavingsGoal()
        transferMoneyManager.transferMoneyIntoSavingsGoal()
    }


}

