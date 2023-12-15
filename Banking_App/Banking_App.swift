//
//  Banking_AppApp.swift
//  Banking_App
//
//  Created by Pranav Chhabra on 10/22/23.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var isAuthenticated = false
}

@main
struct Banking_App: App {
    @StateObject private var appState = AppState()
    @StateObject private var accountDetailsViewModel = AccountDetailsViewModel(details: AccountDetails(
        accountNumber: "",   // Placeholder value
                xpAmount: 0.0,       // Placeholder value
                level: 1,            // Placeholder value
                checkingAmount: 0,   // Placeholder value
                savingsAmount: 0,    // Placeholder value
                miles: 0,            // Placeholder value
                walmartCredits: 0,   // Placeholder value
                amazonCredits: 0,    // Placeholder value
                targetCredits: 0,    // Placeholder value
                joinDate: Date(),    // Current date
                id: ""               // Placeholder value
    ))
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if appState.isAuthenticated {
                    ContentView()
//                        .environmentObject(appState)
                        .environmentObject(accountDetailsViewModel)
                        .onAppear {
                            print("Navigating to ContentView")
                        }
                } else {
                    Login_Page()
                        .environmentObject(appState)
                        .environmentObject(accountDetailsViewModel)
                        .onAppear {
                            print("Showing Login_Page")
                        }
                }
            }
            .onAppear {
                let staticName = "Mickey"  // Replace with a static name
                let staticPassword = "password"  // Replace with a static password
                
                        NetworkManager.shared.generateAccount (name: staticName, password: staticPassword) { result in
                            switch result {
                            case .success(let details):
                                accountDetailsViewModel.details = details
                                UserDefaults.standard.set(details.accountNumber, forKey: "accountNumber")
                                print("Account number set: \(details.accountNumber)")
                            case .failure(let error):
                                print("Error fetching account details: \(error.localizedDescription)")
                            }
                        }
                    }
            //            .id(appState.isAuthenticated)
        }
    }
}
