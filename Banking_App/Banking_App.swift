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
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if appState.isAuthenticated {
                    ContentView()
                        .onAppear {
                            print("Navigating to ContentView")
                        }
                } else {
                    Login_Page()
                        .environmentObject(appState)
                        .onAppear {
                            print("Showing Login_Page")
                        }
                }
            }
//            .id(appState.isAuthenticated)
        }
    }
}
