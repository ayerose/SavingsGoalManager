//
//  AccountTests.swift
//  StarlingTechChallengeTests
//
//  Created by Soreya Koura on 04.02.24.
//

import XCTest
@testable import StarlingTechChallenge

final class AccountTests: XCTestCase {
    //  AccountsManager Test
    func testFetchAccount() {
        
        let accountsManager = AccountsManager()
        XCTAssertNoThrow(accountsManager.fetchAccount())
    }

}
