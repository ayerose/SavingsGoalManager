//
//  ViewController.swift
//  StarlingTechChallenge
//
//  Created by Soreya Koura on 01.02.24.
//



//    To make this work, the key parts from our public API you will need are:
//    1. Accounts - To retrieve accounts for the customer
//    2. Transaction feed - To retrieve transactions for the customer
//    3. Savings Goals - Create a savings goals and transfer money to savings goals

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var roundUpLabel: UILabel!
    @IBOutlet weak var transferBtn: UIButton!
    
    var accountsManager = AccountsManager()
    var transactionsManager = TransactionsManager()
    var savingsManager = SavingsManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //accountsManager.fetchAccount()
       // transactionsManager.fetchTransactions()
       // savingsManager.createSavingsGoal()
    }


}

