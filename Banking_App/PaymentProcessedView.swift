//
//  PaymentProcessedView.swift
//  Banking_App
//
//  Created by Izzy Bogot on 11/19/23.
//

import SwiftUI

struct PaymentProcessedView: View {
    // Declaring text variable
    let cardImage = "Card_2"
    let paymentStatus = "You have set up your payment successfully!"
    let lastFourDigits = "5237"
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: 0x004879)
                
                VStack {
                    Image("checkCircle")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("\(paymentStatus)")
                                            .foregroundColor(.white)
                                            .font(Font.system(size: 28))
                                            .multilineTextAlignment(.center)
                    HStack {
                        Image(cardImage)
                            .resizable()
                            .frame(width: 90, height: 60)
                            .foregroundColor(.white)

                        
                        Text(".... \(lastFourDigits)")
                            .foregroundColor(.white)
                            .font(Font.system(size: 25))
                    }
                    Image("Button_3")
                        .resizable()
                        .frame(width: 200, height: 50)
                        .foregroundColor(.white)
                        .padding(.top, 80)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    PaymentProcessedView()
}
