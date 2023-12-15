//
//  PrizePageView.swift
//  Banking_App
//
//  Created by Izzy Bogot on 11/9/23.
//

import SwiftUI

struct PrizePageView: View {
    let accountDetails: AccountDetails?
    let capitalOneMiles: Int
    
    // Declaring text variable
    let titleText = "Amazing job,"
    let name = "Mickey"
//    let walmartCredits = 5
//    let amazonCredits = 0
//    let targetCredits = 0
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("prize_Page")
                    .resizable()
//                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+60)
                
                VStack {
                    Rectangle()
                        .foregroundColor(Color.gray.opacity(0.4))
                        .cornerRadius(20)
                        .frame(width: 300, height: 500)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 4)
                        )
                }
                .padding(.top, 90)
                
                VStack {
                    Text(titleText)
                        .foregroundColor(.black)
                        .font(.custom("IrishGrover-Regular", size: 30))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(-10)
                    
                    Text("\(name)!")
                        .foregroundColor(.black)
                        .font(.custom("IrishGrover-Regular", size: 30))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, -300)
                
                Text("You have earned:")
                    .foregroundColor(.black)
                    .font(.custom("IrishGrover-Regular", size: 28))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .offset(y: -170)
                
                VStack(spacing: 20) {
                    
                    HStack {
                        Image("Card_1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                        
                        Text("\(capitalOneMiles) Capital One Miles")
                            .font(.custom("IrishGrover-Regular", size: 18))
                    }
                    
                    HStack {
                        Image("WalmartCard")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .padding(13)
                        
                        Text("\(accountDetails?.walmartCredits ?? 0) Walmart Credits")
                            .font(.custom("IrishGrover-Regular", size: 18))
                    }
                    
                    HStack {
                        Image("AmazonCard")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                        
                        Text("\(accountDetails?.amazonCredits ?? 0) Amazon Credits")
                            .font(.custom("IrishGrover-Regular", size: 18))
                    }
                    
                    HStack {
                        Image("TargetCard")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 45, height: 45)
                            .padding(7)
                        
                        Text("\(accountDetails?.targetCredits ?? 0) Target Credits")
                            .font(.custom("IrishGrover-Regular", size: 18))
                    }
                }
            }
        }
    }
}

struct PrizePageView_Previews: PreviewProvider {
    static var previews: some View {
        
        let sampleAccountDetails = AccountDetails(
                    accountNumber: "123456789",
                    xpAmount: 75.0,  // Example XP amount
                    level: 3,        // Example level
                    checkingAmount: 5000,    // Example checking account balance
                    savingsAmount: 15000,    // Example savings account balance
                    miles: 200,      // Example miles
                    walmartCredits: 10,      // Example Walmart credits
                    amazonCredits: 5,        // Example Amazon credits
                    targetCredits: 8,        // Example Target credits
                    joinDate: Date(),        // Current date
                    id: "abc123"             // Example ID
                )
        
        let miles = 100
        
        PrizePageView(accountDetails: sampleAccountDetails,capitalOneMiles: miles)
    }
}

