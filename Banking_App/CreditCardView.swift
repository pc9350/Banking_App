//
//  CreditCard.swift
//  Banking_App
//
//  Created by Izzy Bogot on 11/19/23.
//

import SwiftUI

struct CreditCardView: View {
    // Declaring text variable
    let cardImage = "Card_2"
    let cardName = "Capital One Quicksilver Card"
    let lastFourDigits = "5237"
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: 0x004879)
                
                VStack {
                    Image("\(cardImage)")
                        .resizable()
                        .frame(width: 180, height: 110)
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("\(cardName)")
                                            .foregroundColor(.white)
                                            .font(Font.system(size: 22))
                                
                    Text(".... \(lastFourDigits)")
                                            .foregroundColor(.gray)
                                            .font(Font.system(size: 18))
                                            .padding(.top,0)
                }
                .padding(.top, -350)
                
                // Card Management
                VStack {
                    
                    Text("Card Management                                     ")
                                            .foregroundColor(.white)
                                            .font(Font.system(size: 20))
                    
                            // Set Credit Lock
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 350, height: 65)
                                .foregroundColor(Color(hex: 0x3482A8))
                                .overlay(
                                    HStack(spacing: 8) {
                                        Image(systemName: "lock")
                                            .resizable()
                                            .frame(width: 45, height: 50)
                                            .foregroundColor(.white)
                                            .padding()
                                        
                                        Text("Set Credit Lock                     ")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    }
                                )
                    
                    // Freeze or Unfreeze a Card
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 350, height: 65)
                        .foregroundColor(Color(hex: 0x3482A8))
                        .overlay(
                            HStack(spacing: 8) {
                                Image(systemName: "shield")
                                    .resizable()
                                    .frame(width: 45, height: 50)
                                    .foregroundColor(.white)
                                    .padding()
                                
                                Text("Freeze or Unfreeze a Card")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        )
                    
                    // Replace a Card
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 350, height: 65)
                        .foregroundColor(Color(hex: 0x3482A8))
                        .overlay(
                            HStack(spacing: 8) {
                                Image(systemName: "creditcard")
                                    .resizable()
                                    .frame(width: 65, height: 50)
                                    .foregroundColor(.white)
                                    .padding()
                                
                                Text("Replace a Card                    ")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        )
                    
                        }
                .padding(.top, -30)
                
                // Payment
                VStack {
                    
                    Text("Payment                                                       ")
                                            .foregroundColor(.white)
                                            .font(Font.system(size: 20))
                    
                            // Auto Pay
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 350, height: 65)
                                .foregroundColor(Color(hex: 0x3482A8))
                                .overlay(
                                    HStack(spacing: 8) {
                                        Image("AutoPay")
                                            .resizable()
                                            .frame(width: 45, height: 50)
                                            .foregroundColor(.white)
                                            .padding()
                                        
                                        Text("Auto Pay                                  ")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    }
                                )
                    
                    // Set Up a Payment
                    NavigationLink(destination: PaymentProcessedView()) {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 350, height: 65)
                            .foregroundColor(Color(hex: 0x3482A8))
                            .overlay(
                                
                                HStack(spacing: 8) {
                                    Image(systemName: "dollarsign")
                                        .resizable()
                                        .frame(width: 30, height: 45)
                                        .foregroundColor(.white)
                                    
                                    Text("Set Up a Payment                ")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                }
                                
                            )
                    }
                    // Add To Digital Wallet
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 350, height: 65)
                        .foregroundColor(Color(hex: 0x3482A8))
                        .overlay(
                            HStack(spacing: 8) {
                                Image("pocket")
                                    .resizable()
                                    .frame(width: 45, height: 50)
                                    .foregroundColor(.white)
                                    .padding()
                                
                                Text("Add To Digital Wallet           ")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        )
                    
                        }
                .padding(.top, 500)
                
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

extension Color { // Setting the hex background color
    init(hex: Int, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}


        #Preview {
            CreditCardView()
        }

