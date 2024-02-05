//
//  TransactionAndSavingsData.swift
//  StarlingTechChallenge
//
//  Created by Soreya Koura on 03.02.24.

// this file is for decoding the received transactions and savings goal json data in into a struct


import Foundation

struct TransactionData: Decodable {
    let feedItems: [FeedItems]
}
// create data type FeedItems
struct FeedItems: Decodable {
    let amount: Amount
}
// create data type "Amount"
struct Amount: Decodable {
    let currency: String
    let minorUnits: Int
}
// create new transaction object that displays currenty and amount
struct TransactionModel: Decodable {
    let currency: String
    let minorUnits: Int
    // create computed property minorUnitsToString
    var minorUnitsToString: String {
        return String(format: "%.2f", Double(minorUnits) / 100.0)
}
    // property for round up feature
    var roundUpAmount: Double {
        let minorUnitsDouble = Double(minorUnits) / 100.0
        let roundedUpAmount = ceil(minorUnitsDouble) - minorUnitsDouble
        return roundedUpAmount
      }
}
// struct for SavingGoalViewController.swift
struct DisplaySavingsGoalData: Decodable {
    let name: String
    let savedPercentage: Int
    let savingsGoalUid: String
    let state: String
    let target: Amount
    let totalSaved: Amount
}

// create new transaction object that displays currency and amount
struct SavingsModel: Decodable {
    let currency: String
    let minorUnits: Int
    let name: String
    let totalSaved: Int
    
    // create computed property minorUnitsToString
    var minorUnitsToString: String {
        return String(format: "%.2f", Double(minorUnits) / 100.0)
}
}
