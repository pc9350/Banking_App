//
//  Banking_Page.swift
//  Banking_App
//
//  Created by Pranav Chhabra on 11/13/23.
//

import SwiftUI

//struct MainView: View {
//    var body: some View {
//        TabView {
//            Banking_Page()
//                .tabItem {
//                    Label("Banking", systemImage: "banknote")
//                }
//
//            Text("Another Tab Content")
//                .tabItem {
//                    Label("Other", systemImage: "square.and.pencil")
//                }
//        }
//    }
//}

struct Banking_Page: View {
    
    var userInfo: UserAccountInfo
    var accountDetails: AccountDetails?
    
        var body: some View {
            NavigationView {
            VStack {
                
                Image("capitalOne_logo")
                    .resizable()
                    .frame(width: 200, height: 70)
                    .padding(.vertical, 15)
                
                // Header
                VStack(alignment: .leading) {
                    Text("Good evening, \(userInfo.name)")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("December 25, 2023")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 10)
                
                // Action Buttons
                HStack {
                    Button(action: {
                        // action for Send / Zelle
                    }) {
                        VStack {
                            //                                Image(systemName: "arrow.right.arrow.left.circle")
                            Text("Send | Zelle")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 9)
                        .background(Color("blue"))
                        .cornerRadius(10)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // action for Deposit checks
                    }) {
                        VStack {
                            //                                Image(systemName: "doc.text.viewfinder")
                            Text("Deposit")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(9) //or padding(.vertical, 9) for complete text
                        .background(Color("blue"))
                        .cornerRadius(10)
                    }
                    
                    //                                            Spacer()
                    
                    Button(action: {
                        // action for Nearby ATM/branch
                    }) {
                        VStack(spacing: 0) {
                            //                                Image(systemName: "location.circle")
                            Text("Find ATM")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(9)
                        .background(Color("blue"))
                        .cornerRadius(10)
                    }
                }
                .padding()  // This will apply padding around the entire HStack
                .frame(height: 50)  // Sets a fixed height for the buttons
                .background(Color.white)
                .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 5)
                //                    Rectangle()
                //                    .fill(Color.gray.opacity(0.4))  // Use .gray for the border color, adjust opacity as needed
                //                    .frame(height: 5)
                
            
                // Payment Due Section
                VStack(alignment: .leading) {
                    Text("Payment due")
                        .font(.headline)
                        .padding([.leading,.top])
                    
                    NavigationLink(destination: CardSelectionView(userInfo: userInfo)){
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
                
                // Accounts Section
                VStack(alignment: .leading) {
                    Text("Accounts")
                        .font(.headline)
                        .padding([.leading,.top])
                    
                    VStack(spacing: 10) {  // Add spacing between account cards
                        // Capital Checking Account Card
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Capital Checking")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                //                            Spacer()
                                Text("$\(accountDetails?.checkingAmount ?? 0)")
                                    .font(.system(size: 40))  // Adjust font size if necessary
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            //                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 2, y: 2)
                            Spacer()
                            // Optionally, add an icon or additional information here
                        }
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 3)
                        
                        // Capital Saving Account Card
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Capital Saving")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                //                            Spacer()
                                Text("$\(accountDetails?.savingsAmount ?? 0)")
                                    .font(.system(size: 40))  // Adjust font size if necessary
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            //                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 2, y: 2)
                            Spacer()
                            // Optionally, add an icon or additional information here
                        }
                        .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.gray.opacity(0.4)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 3)
                    }
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
}

//#Preview {
//    Banking_Page()
//}
struct Banking_Page_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample user account info to use in the preview
        let sampleUserInfo = UserAccountInfo(name: "Mickey",
                                             checkingAccountBalance: "$1,234.56",
                                             savingAccountBalance: "$77,890.12",
                                             CC_Balance: "$2,898",CC_Limit: "$5,000",EXP: 0,level: 1,
                                             creditScore: 800)
        
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
        // Initialize Banking_Page with the sample user info
        Banking_Page(userInfo: sampleUserInfo, accountDetails: sampleAccountDetails)
    }
}
