//
//  SavingGoalViewController.swift
//  StarlingTechChallenge
//
//  Created by Soreya Koura on 04.02.24.

// ViewController for Savings Goal Screen

import Foundation

import UIKit

class SavingGoalViewController: UIViewController, DisplaySavingsGoalManagerDelegate {

    @IBOutlet weak var savingGoalLabel: UILabel!
    
    var savingGoalData: DisplaySavingsGoalData?
    var displaySavingsGoalManager = DisplaySavingsGoalManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displaySavingsGoalManager.delegate = self
        displaySavingsGoalManager.fetchSavingsGoal()
    }
    // MARK: display the Savings goal
    func showSavingsGoal(data: DisplaySavingsGoalData) {
        DispatchQueue.main.async {
            self.savingGoalLabel.text = """
            Name: \(data.name)
            Saved Percentage: \(data.savedPercentage)%
            Goal: \(data.target.minorUnits / 100) GBP
            Total Saved: \(data.totalSaved.minorUnits / 100) GBP
            """
        }
    }
    
    func didFailWithError(error: Error) {
        print("Error while fetching saving goal: \(error)")
    }
}
