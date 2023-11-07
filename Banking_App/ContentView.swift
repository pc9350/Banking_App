//
//  ContentView.swift
//  Banking_App
//
//  Created by Pranav Chhabra on 10/22/23.
//

import SwiftUI

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
    @State private var scale: CGFloat = 1
    @State private var isTextVisible: Bool = false
    @State private var isCard1Visible: Bool = true
    @State private var isCard2Visible: Bool = true
    @State private var isCard3Visible: Bool = true
    @State private var isPoopVisible: Bool = true
    
    @State private var level: Int = 1  // Start at level 1
    @State private var expValue: Float = 0.0  // Current EXP value
    @State private var showImage: Bool = false
    
    let card1Size: CGSize = CGSize(width: 70, height: 70)
    let card2Size: CGSize = CGSize(width: 70, height: 40)
    let card3Size: CGSize = CGSize(width: 70, height: 50)
    let card4Size: CGSize = CGSize(width: 60, height: 60)
    
    @State private var card1Position: CGPoint = .zero
    @State private var card2Position: CGPoint = .zero
    @State private var card3Position: CGPoint = .zero
    @State private var card4Position: CGPoint = .zero
    
    
    //    func randomOffset(rangeX: ClosedRange<CGFloat>, rangeY: ClosedRange<CGFloat>) -> CGSize {
    //        let randomX = CGFloat.random(in: rangeX)
    //        let randomY = CGFloat.random(in: rangeY)
    //        return CGSize(width: randomX, height: randomY)
    //    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                // Background Image
                Image("homepage_Background")  // the name of background image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .onAppear {
                        // Call your random position generating function here
                        card1Position = randomPosition(cardSize: card1Size)
                        card2Position = randomPosition(cardSize: card2Size)
                        card3Position = randomPosition(cardSize: card3Size)
                        card4Position = randomPosition(cardSize: card4Size)
                        
                        print("Card 1 Position: \(card1Position)")
                        print("Card 2 Position: \(card2Position)")
                        print("Card 3 Position: \(card3Position)")
                        print("Poop Position: \(card4Position)")
                    }
                
                Image("Card_1")  // Replace with a known good image asset name
                    .resizable()
                    .frame(width: 50, height: 50)  // Adjust to your icon size
                    .background(Color.red)  // Will show red if the image is not loading
                    .position(randomPosition(cardSize: CGSize(width: 50, height: 50)))
                    .onAppear {
                        print("Icon should be visible now")
                    }
                
                VStack {
                    HStack {
                        NavigationLink(destination: ImageView(imageName: "monster_Page").padding(.bottom,60)){
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
                        NavigationLink(destination: ImageView(imageName: "prize_Page").padding(.bottom,60)){
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
                    //                        .background(Color.red)  // Debugging background
                    
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
                            NavigationLink(destination: ImageView(imageName: "Credit_card_page").padding(.bottom,90)) {
                                Image("Thought_bubble")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200)
                                    .offset(x: -40,y: 110)
                            }
                        }
                    }
                    
                    
                    Spacer()
                    
                    
                    HStack {
                        if isCard1Visible {
                            
                            Image("Card_1")
                                .resizable()
                                .frame(width: card1Size.width, height: card1Size.height).position(card1Position)
                                .background(Color.red.opacity(0.3)).zIndex(1.0)
                                .onTapGesture {
                                    withAnimation {
                                        isCard1Visible = false
                                        incrementExp(by: 0.25)
                                    }
                                }
                        }
                        
                        if isCard2Visible {
                            Image("Card_2")
                                .resizable()
                                .frame(width: card2Size.width, height: card2Size.height)
                                .position(card2Position)
                                .background(Color.red.opacity(0.3))
                                .onTapGesture {
                                    withAnimation {
                                        isCard2Visible = false
                                        incrementExp(by: 0.25)
                                    }
                                }
                        }
                    }
                    
                    HStack {
                        if isCard3Visible {
                            Image("Card_3")
                                .resizable()
                                .frame(width: card3Size.width, height: card3Size.height).position(card3Position).background(Color.red.opacity(0.3))
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
                                .frame(width: card4Size.width, height: card4Size.height).position(card4Position).background(Color.red.opacity(0.3))
                            //                                .offset(x: -100,y: 0)
                                .onTapGesture {
                                    withAnimation {
                                        isPoopVisible = false
                                        incrementExp(by: -0.1)
                                    }
                                }
                        }
                    }
                    
                    //                Spacer()
                    
                    //Z Stack for the friendly_monster and progress bar
                    ZStack {
                        // Background color or other decoration here
                        
                        //                    HStack {
                        // Friend_Monster Image
                        Image("Friend_Monster")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200.0, height: 200.0)
                            .offset(x: 100,y: -25)
                        
                        
                        // The VStack for text and progress bar
                        VStack {
                            HStack {
                                Text("Aditya Lv. \(level)")
                                Spacer()
                                Text("+ EXP")
                            }
                            //                            .font(.system(size: 22))
                            .bold()
                            .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.5))
                            
                            ProgressBar(value: expValue)
                                .frame(height: 10)
                            
                        }
                        .frame(width: UIScreen.main.bounds.width - 40) // Set a defined width
                        .offset(x: 0,y: 40)
                    }
                    .frame(height: 130.0)
                    
                    HStack {
                        Spacer()
                        VStack() {
                            NavigationLink(destination: ImageView(imageName: "accounts_Page")){
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
            .animation(.easeInOut(duration: 1), value: isCard1Visible)
            .animation(.easeInOut(duration: 1), value: isCard2Visible)
            .animation(.easeInOut(duration: 1), value: isCard3Visible)
            .animation(.easeInOut(duration: 1), value: isPoopVisible)
        }
    }
    func incrementExp(by amount: Float) {
        self.expValue += amount
        // When experience increases and crosses the threshold for the next level
            while self.expValue >= 1.0 {
                self.expValue -= 1.0 // Subtract the full level's worth of exp
                self.level += 1      // Increment the level
            }
            
            // When experience decreases and falls below the current level
            while self.expValue < 0.0 && self.level > 1 {
                self.expValue += 1.0 // Add the full level's worth of exp
                self.level -= 1      // Decrement the level
            }
            
            // Ensure expValue stays within the 0.0 to 1.0 range
            self.expValue = min(max(self.expValue, 0.0), 1.0)
        // Optionally, if you want to handle multiple level-ups in one go:
        //            // You may want to add some logic here if there's additional processing
        //            // to do on level-up, like resetting skills, bonuses, etc.
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
    func randomPosition(cardSize: CGSize) -> CGPoint {
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        
        // Start y at the middle of the screen to ensure the icon is in the bottom half
        let minY = screenHeight / 2
        // Subtract the card's height and the navigation bar's height from the screen height to get the maxY
        let maxY = screenHeight - cardSize.height - 200 // Assuming the navigation bar is 50 points high
        
        // Ensure we're not going off the sides of the screen with the width
        let minX = cardSize.width / 2
        let maxX = screenWidth - cardSize.width / 2
        
        // Generate a random position within the constraints
        let randomX = CGFloat.random(in: minX...maxX)
        let randomY = CGFloat.random(in: minY...maxY)
        
        return CGPoint(x: randomX, y: randomY)
    }


}

struct ImageView: View {
    var imageName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
            //                .padding(.bottom, 90.0)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: Button("") {
                    // Pop this view off the navigation stack to return to the previous view
                    presentationMode.wrappedValue.dismiss()
                })
        }
    }
    @Environment(\.presentationMode) var presentationMode
}

#Preview {
    ContentView()
}
