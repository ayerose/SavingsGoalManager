//
//  SavingsTests.swift
//  StarlingTechChallengeTests
//
//  Created by Soreya Koura on 04.02.24.
//

import XCTest
@testable import StarlingTechChallenge

final class SavingsTests: XCTestCase {
    // MARK: - Savings Tests
    
       func testCreateSavingsGoal() {
           let savingsManager = SavingsManager()
           XCTAssertNoThrow(savingsManager.createSavingsGoal())
       }
    
        func testFetchSavingsGoal() {
            let displaySavingsGoalManager = DisplaySavingsGoalManager()
            XCTAssertNoThrow(displaySavingsGoalManager.fetchSavingsGoal())
        }
    // transfer RoundUp to Saving Goal Test
    func testSavingsGoalTransfer() {
           let transactionsViewController = TransactionsViewController()
           transactionsViewController.totalRoundUpAmount = 10.0
           XCTAssertNoThrow(transactionsViewController.transferToSavingsGoal(UIButton()))
       }
    
    }
