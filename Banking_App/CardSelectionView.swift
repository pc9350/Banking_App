//
//  CardSelectionView.swift
//  Banking_App
//
//  Created by Izzy on 11/29/23.
//

import SwiftUI

struct CardSelectionView: View {
    var userInfo: UserAccountInfo
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Color(hex: 0x004879)
                        .ignoresSafeArea()
                        .frame(height: 230)
                        .offset(x:0,y:-270)
                }

                
                VStack {
                    
                    Image("CapitalOneLogo-White")
                        .resizable()
                        .frame(width: 300, height: 150)
                        .padding([.top,.bottom], 20)
                    
                    // Header
                    VStack() {
                        Text("Manage My Cards")
//                            .font(.title)
                            .font(Font.system(size: 26))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding(.top, -40)
                        Text("Coming Up              ")
                            .font(Font.system(size: 26))
                            .fontWeight(.semibold)
                            .padding(.top, 10)

                    }
                    .padding(.vertical, 10)
                    .padding(.leading, -150)
                    
                    // PLATINUM CARD
                    
                    VStack(alignment: .leading) {
                        Text("Payment due")
                            .font(.headline)
                            .padding([.leading])
                        
                        NavigationLink(destination: CreditCardView()){
                            HStack {
                                Image("Card_3") // Replace with your card icon asset name
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70, height: 70) // Adjust size as needed
                                    .foregroundColor(.white)
                                    .padding([.leading,.vertical], 5)
                                
                                VStack(alignment: .leading) {
                                    Text("PLATINUM")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 2)
                                    Text("\(userInfo.CC_Balance) / \(userInfo.CC_Limit)")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                .padding([.top, .bottom], 10)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Due on 12/31/2023")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 2)
                                Text("6 days left")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .padding([.trailing, .top, .bottom], 10)
                        }
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 3)
                        .padding(.horizontal)
                    }
                    
                    // QUICKSILVER CARD
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        
                        
                        NavigationLink(destination: CreditCardView()){
                            HStack {
                                Image("quicksilver") // Replace with your card icon asset name
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70, height: 70) // Adjust size as needed
                                    .foregroundColor(.white)
                                    .padding([.leading,.vertical], 5)
                                
                                VStack(alignment: .leading) {
                                    Text("QUICKSILVER")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 2)
                                    Text("\(userInfo.CC_Balance) / \(userInfo.CC_Limit)")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                .padding([.top, .bottom], 10)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Due on 12/31/2023")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 2)
                                Text("6 days left")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .padding([.trailing, .top, .bottom], 10)
                        }
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 3)
                        .padding(.horizontal)
                    }
                    
                    // SAVOR CARD
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        
                        NavigationLink(destination: CreditCardView()){
                            HStack {
                                Image("savor") // Replace with your card icon asset name
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70, height: 70) // Adjust size as needed
                                    .foregroundColor(.white)
                                    .padding([.leading,.vertical], 5)
                                
                                VStack(alignment: .leading) {
                                    Text("SAVOR")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 2)
                                    Text("\(userInfo.CC_Balance) / \(userInfo.CC_Limit)")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                .padding([.top, .bottom], 10)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Due on 12/31/2023")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 2)
                                Text("6 days left")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .padding([.trailing, .top, .bottom], 10)
                        }
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 3)
                        .padding(.horizontal)
                    }

                    
                   
                    
                    
                    Spacer()
                    
                    
                    VStack(spacing: 0) {  // Use VStack with no spacing to put the border directly above the HStack
                        Rectangle()
                            .fill(Color.gray.opacity(0.4))  // Adjust color to get the grayish look you want
                            .frame(height: 5)
                        
                        
                        HStack {
                            Spacer()
                            VStack() {
                                Image("Accounts_icon")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                
                                Text("Accounts")
                                    .font(.caption)
                            }
                            Spacer()
                            VStack {
                                NavigationLink(destination: ContentView()){
                                    Image("COM_icon")  // Replace icon
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                }
                                Text("COM")
                                    .font(.caption)
                                
                            }
                            Spacer()
                            VStack {
                                Image("Profile_icon")  // Replace icon
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                Text("Profile")
                                    .font(.caption)
                            }
                            Spacer()
                        }
                        .padding(.top, 30.0)
                        .frame(width: UIScreen.main.bounds.width, height: 50)
                        .background(Color.white) // White background
                        
                    }
                    
                }
            }
            .navigationBarBackButtonHidden(true)
        }
//        // Hide the navigation bar for this view
//        .navigationBarHidden(true)

    }
}

struct CardSelection_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample user account info to use in the preview
        let sampleUserInfo = UserAccountInfo(name: "Mickey",
                                             checkingAccountBalance: "$1,234.56",
                                             savingAccountBalance: "$77,890.12",
                                             CC_Balance: "$2,898",CC_Limit: "$5,000",EXP: 0,level: 1,
                                             creditScore: 800, miles: 20)
        // Initialize Banking_Page with the sample user info
        CardSelectionView(userInfo: sampleUserInfo)
    }
}

