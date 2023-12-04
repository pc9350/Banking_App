//
//  ContentView.swift
//  Banking_App
//
//  Created by Pranav Chhabra on 10/22/23.
//

import SwiftUI
import Foundation

struct UserAccountInfo {
    var name: String
    var checkingAccountBalance: String
    var savingAccountBalance: String
    var CC_Balance: String
    var CC_Limit: String
    var EXP: Float
    var level: Int
    var creditScore: Int
    // Add other relevant details as needed
}

struct ThoughtBubble: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Drawing the main bubble
        path.addRoundedRect(in: rect, cornerSize: CGSize(width: 20, height: 20))
        
        // Drawing a tail for the bubble
        path.move(to: CGPoint(x: rect.maxX - 10, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX + 10, y: rect.maxY + 10))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        return path
    }
}

struct ProgressBar: View {
    var value: Float  // Between 0 and 1
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.white)
                
                Rectangle()
                    .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.5))
                    .frame(width: CGFloat(value) * geometry.size.width)
            }
        }
    }
}

struct ContentView: View {
    //    @EnvironmentObject var appState: AppState
    @State private var scale: CGFloat = 1
    @State private var isTextVisible: Bool = false
    @State private var isCard1Visible: Bool = true
    @State private var isCard2Visible: Bool = true
    @State private var isCard3Visible: Bool = true
    @State private var isPoopVisible: Bool = true
    
    //    @State private var level: Int = 1  // Start at level 1
    //    @State private var expValue: Float = 0.0  // Current EXP value
    @State private var showImage: Bool = false
    
    let card1Size: CGSize = CGSize(width: 70, height: 70)
    let card2Size: CGSize = CGSize(width: 70, height: 40)
    let card3Size: CGSize = CGSize(width: 70, height: 50)
    let card4Size: CGSize = CGSize(width: 60, height: 60)
    
    @State private var userInfo = UserAccountInfo(name: "Mickey", checkingAccountBalance: "$8,525.81", savingAccountBalance: "$372,600.24",CC_Balance: "$2,000",CC_Limit: "$4,000",EXP: 0,level: 1, creditScore: 750)
    
    let positions = [
        CGPoint(x: 300, y: 280), // Adjusted
        CGPoint(x: 500, y: 180), // Adjusted
        CGPoint(x: 300, y: 200), // Adjusted
        CGPoint(x: 400, y: 310), // Adjusted
        CGPoint(x: 450, y: 280), // Adjusted
        CGPoint(x: 350, y: 340)  // Adjusted
    ]
    
    
    // Randomize the positions
    @State private var randomizedPositions: [CGPoint]
    
    init() {
        _randomizedPositions = State(initialValue: positions.shuffled())
    }
    
    
    @State private var isRedClicked: Bool = false
    @State private var isInfoClicked: Bool = false
    
    //value to fetch from backend for the EXP
    @State private var xpAmount: Int = 0
    
    @State private var accountDetails: AccountDetails?
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.clear
                // Background Image
                Image("homepage_Background")  // the name of background image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack {
                    
                    HStack {
                        NavigationLink(destination: MonsterMenuView()){
                            Image("top_Left_Icon")  // Replace icon
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding(7)
                                .clipShape(Circle())  // Clip to circle shape
                                .overlay(Circle().stroke(Color.black, lineWidth: 2))
                                .padding(.leading, 20)
                        }
                        Spacer()
                        NavigationLink(destination: PrizePageView(accountDetails: accountDetails)){
                            Image("top_Right_Icon")  // Replace icon
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding(7)
                                .clipShape(Circle())  // Clip to circle shape
                                .overlay(Circle().stroke(Color.black, lineWidth: 2))
                                .padding(.trailing, 20)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.horizontal, 30)  // Add some horizontal padding
                    
                    Spacer()  // This pushes the HStack to the top
                }
                
                // other UI elements here
                VStack {
                    
                    ZStack(alignment: .top) {
                        // Monster Image
                        Image("Monster_Homepage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150.0, height: 150.0).offset(x: -100,y: 250)
                        
                        VStack {
                            NavigationLink(destination: CardSelectionView(userInfo: userInfo)) {
                                Image("Thought_bubble")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200)
                                    .offset(x: -40,y: 110)
                            }
                        }
                    }
                    
                    
                    Spacer()
                    
                    ZStack{
                        //                        HStack {
                        if isCard1Visible {
                            
                            Image("Card_1")
                                .resizable()
                                .frame(width: card1Size.width, height: card1Size.height)
                            //                                    .position(x: 350, y: 400)
                                .position(randomizedPositions[0])
                            // For debugging
                                .onTapGesture {
                                    withAnimation {
                                        isCard1Visible = false
                                        incrementExp(by: 0.25)
                                    }
                                    if var details = accountDetails {
                                        details.miles += 20
                                        accountDetails = details  // Update the state
                                    }
                                }
                        }
                        
                        
                        if isCard2Visible {
                            Image("Card_2")
                                .resizable()
                                .frame(width: card2Size.width, height: card2Size.height)
                            //                                .position(x: 500, y: 200)
                                .position(randomizedPositions[1])
                                .onTapGesture {
                                    withAnimation {
                                        isCard2Visible = false
                                        incrementExp(by: 0.25)
                                    }
                                    //}
                                }
                        }
                        
                        //                        HStack {
                        if isCard3Visible {
                            Image("Card_3")
                                .resizable()
                                .frame(width: card3Size.width, height: card3Size.height)
                            //                                .position(x: 300, y: 220)
                                .position(randomizedPositions[2])
                                .onTapGesture {
                                    withAnimation {
                                        isCard3Visible = false
                                        incrementExp(by: 0.25)
                                    }
                                }
                        }
                        
                        if isPoopVisible {
                            Image("Poop")
                                .resizable()
                                .frame(width: card4Size.width, height: card4Size.height)
                            //                                    .position(x: 400, y: 350)
                            //                                    .border(Color.green, width: 1)
                                .position(randomizedPositions[3])
                                .onTapGesture {
                                    withAnimation {
                                        isPoopVisible = false
                                        incrementExp(by: -0.1)
                                    }
                                }
                            //                            }
                        }
                    }
                    .onAppear {
                        // Shuffle positions when the view appears
                        randomizedPositions = positions.shuffled()
                    }
                    
                    
                    //Z Stack for the friendly_monster and progress bar
                    ZStack {
                        // Background color or other decoration here
                        
                        Button {
                            isRedClicked = true
                        } label: {
                            Image("Friend_Monster").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200.0, height: 200.0)
                            
                        }
                        .padding(.leading, 200) // Example of using padding for horizontal movement
                        .padding(.top, -50) // Example of using padding for vertical movement
                        
                        
                        if (isRedClicked == true){
                            Button(action: {
                                isRedClicked = false
                            }){
                                
                                Image("blank_rectangle").resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 600.0, height: 500.0)
                                    .offset(x: 0,y: -280)
                            }
                            Image("Friend_Monster").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200.0, height: 200.0)
                                .offset(x: 30.5,y: -135)
                            Button {
                                isRedClicked = false
                            } label:{
                                Image("x_icon").resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30.0, height: 30.0)
                                    .offset(x: -110,y: -500)
                            }
                            Image("send_zelle_icon").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150.0, height: 500.0)
                                .offset(x: 0,y: -410)
                            Image("request_zelle_icon").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150.0, height: 500.0)
                                .offset(x: 0,y: -320)
                        }
                        
                        
                        if (isInfoClicked == true){
                            // Button {
                            //   isInfoClicked = false
                            //} label:{
                            //  Image("Cross").offset(x: -50, y: 200)
                            //}
                            Button {
                                isInfoClicked = false
                            } label: {
                                Image("info_homepage").resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 600.0, height: 650.0)
                                    .offset(x: 0,y: -300)
                                
                            }
                            Button {
                                isInfoClicked = false
                            } label:{
                                Image("x_icon").resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30.0, height: 30.0)
                                    .offset(x: -108,y: -490)
                            }
                            
                        }
                        
                        
                        //                        let details = accountDetails
                        // The VStack for text and progress bar
                        if let details = accountDetails {
                            VStack {
                                HStack {
                                    Text("\(userInfo.name) Lv. \(details.level)")
                                    Button {
                                        isInfoClicked = true
                                    } label: {
                                        Image( "info_icon")
                                    }
                                    
                                    Spacer()
                                    Text("+ EXP")
                                }
                                .bold()
                                .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.5))
                                
                                ProgressBar(value: details.xpAmount)
                                    .frame(height: 10)
                                
                            }
                            .frame(width: UIScreen.main.bounds.width - 40) // Set a defined width
                            .offset(x: 0,y: 40)
                        }
                    }
                    .frame(height: 130.0)
                    
                    HStack {
                        Spacer()
                        VStack() {
                            NavigationLink(destination: Banking_Page(userInfo: userInfo, accountDetails: accountDetails)){
                                Image("Accounts_icon")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                            Text("Accounts")
                                .font(.caption)
                        }
                        Spacer()
                        VStack {
                            Image("COM_icon")  // Replace icon
                                .resizable()
                                .frame(width: 40, height: 40)
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
                    .background(Color.white)  // White background
                    
                    
                }
            }
            .font(.custom("IrishGrover-Regular", size: 20))
            .onAppear {
                print("Screen width: \(UIScreen.main.bounds.width), Screen height: \(UIScreen.main.bounds.height)");
                //                .onAppear {
                NetworkManager.shared.fetchAccountDetails { result in
                    switch result {
                    case .success(let details):
                        self.accountDetails = details
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                //            }
            }
            //            .animation(.easeInOut(duration: 1), value: isCard1Visible)
            //            .animation(.easeInOut(duration: 1), value: isCard2Visible)
            //            .animation(.easeInOut(duration: 1), value: isCard3Visible)
            //            .animation(.easeInOut(duration: 1), value: isPoopVisible)
            //            .onAppear {
            //                    let safeAreaInsets = geometry.safeAreaInsets
            //                    let usableHeight = geometry.size.height - safeAreaInsets.top - safeAreaInsets.bottom
            //                    let usableWidth = geometry.size.width - safeAreaInsets.leading - safeAreaInsets.trailing
            //
            //                    // Now use these values to calculate your random positions
            //                    // For example, adjust minY and maxY based on usableHeight
            //                    let minY = ... // based on usableHeight
            //                    let maxY = ... // based on usableHeight and card size
            //                    // Similar adjustments for minX and maxX using usableWidth
            //                }
            //            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    //    func incrementExp(by amount: Float) {
    //        userInfo.EXP += amount
    //        // When experience increases and crosses the threshold for the next level
    //        while userInfo.EXP >= 1.0 {
    //            userInfo.EXP -= 1.0 // Subtract the full level's worth of exp
    //            userInfo.level += 1      // Increment the level
    //        }
    //
    //        // When experience decreases and falls below the current level
    //        while userInfo.EXP < 0.0 && userInfo.level > 1 {
    //            userInfo.EXP += 1.0 // Add the full level's worth of exp
    //            userInfo.level -= 1      // Decrement the level
    //        }
    //
    //        // Ensure expValue stays within the 0.0 to 1.0 range
    //        userInfo.EXP = min(max(userInfo.EXP, 0.0), 1.0)
    //        // Optionally, if you want to handle multiple level-ups in one go:
    //        //            // You may want to add some logic here if there's additional processing
    //        //            // to do on level-up, like resetting skills, bonuses, etc.
    //    }
    
    func incrementExp(by amount: Float) {
        guard var details = accountDetails else {
            print("Account details not available")
            return
        }
        
        details.xpAmount += Float(amount)
        
        // Check if XP crosses the threshold of 100
        while details.xpAmount >= 1 {
            details.xpAmount -= 1  // Reset XP for the next level
            details.level += 1       // Increase level
        }
        
        while details.xpAmount < 0 && details.level > 1 {
            details.xpAmount += 1.0 // Add the full level's worth of exp
            details.level -= 1      // Decrement the level
        }
        
        print("details level: \(details.level)")
        
        // Update the local state
        accountDetails = details
        
        // Optionally, update the backend with the new XP and level
        // ...
    }
    
    //    func randomPosition(cardSize: CGSize) -> CGPoint {
    //        let lowerBoundY = UIScreen.main.bounds.height / 2 - 100
    //        let upperBoundY = UIScreen.main.bounds.height - cardSize.height / 2
    //
    //        let x = CGFloat.random(in: cardSize.width / 2...(UIScreen.main.bounds.width - cardSize.width / 2))
    //        let y = CGFloat.random(in: lowerBoundY...upperBoundY)
    //
    //        return CGPoint(x: x, y: y)
    //    }
    //    func randomPosition(cardSize: CGSize) -> CGPoint {
    //        let screenHeight = UIScreen.main.bounds.height
    //        let screenWidth = UIScreen.main.bounds.width
    //
    //        // Start y at the middle of the screen to ensure the icon is in the bottom half
    //        let minY = screenHeight / 2
    //        // Subtract the card's height and the navigation bar's height from the screen height to get the maxY
    //        let maxY = screenHeight - cardSize.height - 200 // Assuming the navigation bar is 50 points high
    //
    //        // Ensure we're not going off the sides of the screen with the width
    //        let minX = cardSize.width / 2
    //        let maxX = screenWidth - cardSize.width / 2
    //
    //        // Generate a random position within the constraints
    //        let randomX = CGFloat.random(in: minX...maxX)
    //        let randomY = CGFloat.random(in: minY...maxY)
    //
    //        return CGPoint(x: randomX, y: randomY)
    //    }
    //
    //    private func assignPositions() {
    //        var availablePositions = positions.shuffled()
    //        print("available positions: \(availablePositions)")
    //        var newPositions = [CGPoint?](repeating: nil, count: 4)
    //
    //        if isCard1Visible { newPositions[0] = availablePositions.popLast() }
    //        if isCard2Visible { newPositions[1] = availablePositions.popLast() }
    //        if isCard3Visible { newPositions[2] = availablePositions.popLast() }
    //        if isPoopVisible { newPositions[3] = availablePositions.popLast() }
    //
    //        assignedPositions = newPositions.map { $0 ?? .zero }
    //    }
    
    
}

struct ImageView: View {
    var imageName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            //                .navigationBarTitle("", displayMode: .inline)
                .navigationBarBackButtonHidden(true) // Hides the default back button
                .navigationBarItems(leading: Button(action: {
                    // Pop this view off the navigation stack to return to the previous view
                    presentationMode.wrappedValue.dismiss()
                }){
                    HStack {
                        Image(systemName: "arrow.left") // System-provided arrow icon
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.blue) // Custom color for your back button
                        Text("Back") // Text to the right of the arrow
                            .foregroundColor(.blue) // Ensure text color matches the arrow icon
                    }
                })
        }
    }
    @Environment(\.presentationMode) var presentationMode
}

#Preview {
    ContentView()
}
