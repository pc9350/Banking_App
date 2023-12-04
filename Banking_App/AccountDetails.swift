//
//  AccountDetails.swift
//  Banking_App
//
//  Created by Pranav Chhabra on 12/2/23.
//

import Foundation

struct AccountDetails: Codable {
    var accountNumber: String
    var xpAmount: Float
    var level: Int
    var checkingAmount: Int
    var savingsAmount: Int
    var miles: Int
    var walmartCredits: Int
    var amazonCredits: Int
    var targetCredits: Int
    var joinDate: Date?
    var id: String

    private enum CodingKeys: String, CodingKey {
        case accountNumber, xpAmount, level, checkingAmount, savingsAmount, miles, walmartCredits, amazonCredits, targetCredits
        case joinDate
        case id = "_id"
    }
}
