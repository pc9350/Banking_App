//
//  Login_Page.swift
//  Banking_App
//
//  Created by Pranav Chhabra on 11/17/23.
//

import SwiftUI

//class AppState: ObservableObject {
//    @Published var isAuthenticated = false
//}

struct Login_Page: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @EnvironmentObject var appState: AppState
    
    // Mock user data for demonstration purposes
    let users = [
        (username: "user1@gmail.com", password: "password1"),
        (username: "user2@gmail.com", password: "password2"),
        (username: "user3@gmail.com", password: "password3"),
        (username: "user4@gmail.com", password: "password4")
    ]
    
    var body: some View {
        VStack {
            Image("capitalOne_login1") // Replace with your logo asset name
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 200)
                .padding(.top, 100)
            
            
            Spacer()
            
            //USERNAME stack
            VStack(alignment: .leading){
                Text("Enter your username")
                    .foregroundColor(.white)
                    .padding(.leading, 15)
                    .font(.subheadline)
                
                TextField("", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 15) // Matches the Text padding
                    .padding(.trailing, 15) // Ensures padding is consistent
            }
            .frame(width: 300)
            
            //PASSWORD stack
            VStack(alignment: .leading){
                Text("Enter your password")
                    .foregroundColor(.white)
                    .padding(.leading, 15)
                    .font(.subheadline)
                
                SecureField("", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 15) // Matches the Text padding
                    .padding(.trailing, 15) // Ensures padding is consistent
            }
            .frame(width: 300)
            
            Button(action: {
                authenticateUser()
            }) {
                Text("Sign in")
                    .foregroundColor(.white)
                    .frame(width: 270,height: 30)
                //                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding([.bottom,.top])
            
            Button("Forgot your password?") {
                // Action for forgetting password
            }
            .foregroundColor(.white)
            .padding(.bottom, 50)
            
            Spacer()
            
            // Additional UI elements as per your design, like legal text, etc.
        }
        .frame(maxWidth: .infinity)
        .background(Color("blue").edgesIgnoringSafeArea(.all))
//        .navigationDestination(isPresented: $appState.isAuthenticated) {
//            ContentView() // Destination view
//        }
    }
    
    func authenticateUser() {
        let userExists = users.contains { $0.username.lowercased() == username.lowercased() && $0.password == password }
            if userExists {
                appState.isAuthenticated = true
                print("Authentication successful, isAuthenticated set to true")
            } else {
                appState.isAuthenticated = false
                print("Authentication failed")
                // Handle login failure (e.g., show an alert)
            }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        Login_Page().environmentObject(AppState())
    }
}
