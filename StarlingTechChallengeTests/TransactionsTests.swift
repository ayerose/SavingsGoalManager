//
//  TransactionsTests.swift
//  StarlingTechChallengeTests
//
//  Created by Soreya Koura on 04.02.24.
//

import XCTest
@testable import StarlingTechChallenge

final class TransactionsTests: XCTestCase {
  // MARK: - Transactions Tests
    func testFetchTransactions() {
        let transactionsManager = TransactionsManager()
        let startDate = Date()
        let endDate = Date()
        XCTAssertNoThrow(transactionsManager.fetchTransactions(startDate: startDate, endDate: endDate))
    }
    // parsing
    func testParseJSON() {
            let transactionsManager = TransactionsManager()
            let sampleJSONData = """
                {
                    "feedItems": [
                        {
                            "amount": {
                                "currency": "GBP",
                                "minorUnits": 5000
                            }
                        }
                    ]
                }
                """.data(using: .utf8)!

            // test if parseJSON correctly decodes the sample JSON data
            let transactions = transactionsManager.parseJSON(transactionData: sampleJSONData)
            XCTAssertEqual(transactions?.count, 1)
            XCTAssertEqual(transactions?.first?.currency, "GBP")
            XCTAssertEqual(transactions?.first?.minorUnits, 5000)
        }

    
    func testFetchTransactionsVCForGivenDates() {
        let transactionsViewController = TransactionsViewController()
        transactionsViewController.selectedStartDate = Date()
        transactionsViewController.selectedEndDate = Date()
      
        XCTAssertNoThrow(transactionsViewController.viewDidLoad())
    }
    
   
    }
