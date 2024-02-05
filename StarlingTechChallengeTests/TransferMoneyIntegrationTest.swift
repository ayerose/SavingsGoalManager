//
//  TransferMoneyIntegrationTest.swift
//  StarlingTechChallengeTests
//
//  Created by Soreya Koura on 05.02.24.
//

import XCTest
@testable import StarlingTechChallenge

final class TransferMoneyIntegrationTest: XCTestCase {
    // test APi call in transfer money file
        func testTransferMoneyIntoSavingsGoalIntegration() {
            let manager = TransferMoneyManager()
            let expectation = self.expectation(description: "Transfer API call expectation")
            let amountToTransfer: [String: Any] = ["amount": 10.0]

            manager.transferMoneyIntoSavingsGoal(amountToTransfer: amountToTransfer) { result in
                
                switch result {
                case .success:
                    break
                case .failure(let error):
                    XCTFail("Transfer API call failed with error: \(error)")
                }

                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 10.0)
        }
    }



