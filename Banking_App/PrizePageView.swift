//
//  PrizePageView.swift
//  Banking_App
//
//  Created by Izzy Bogot on 11/9/23.
//

import SwiftUI

struct PrizePageView: View {
    // Declaring text variable
    let titleText = "Amazing job,"
    let name = "Aditya"
    let capitalOneMiles = 50
    let walmartCredits = 5
    let amazonCredits = 0
    let targetCredits = 0
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("Prize")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
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
                        
                        Text("\(walmartCredits) Walmart Credits")
                            .font(.custom("IrishGrover-Regular", size: 18))
                    }
                    
                    HStack {
                        Image("AmazonCard")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                        
                        Text("\(amazonCredits) Amazon Credits")
                            .font(.custom("IrishGrover-Regular", size: 18))
                    }
                    
                    HStack {
                        Image("TargetCard")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 45, height: 45)
                            .padding(7)
                        
                        Text("\(targetCredits) Target Credits")
                            .font(.custom("IrishGrover-Regular", size: 18))
                    }
                }
            }
        }
    }
}

struct PrizePageView_Previews: PreviewProvider {
    static var previews: some View {
        PrizePageView()
    }
}

