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
    
    @State private var expValue: Float = 0.0  // Current EXP value
    @State private var showImage: Bool = false
    
    //    @State private var image1Offset: CGSize = CGSize.zero
    //    @State private var image2Offset: CGSize = CGSize.zero
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("homepage_Background")  // Replace with the name of your background image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack {
                        HStack {
                            NavigationLink(destination: MonsterMenuView().padding(.bottom,60)){
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
                    
                    
                    HStack(spacing: 100) {
                        if isCard1Visible {
                            Image("Card_1")
                                .resizable()
                                .frame(width: 70, height: 70).offset(x: 0,y: -30)
                                .onTapGesture {
                                    withAnimation {
                                        isCard1Visible = false
                                        if expValue < 1.0 {
                                            expValue += 0.25  // Increment EXP here
                                        }
                                    }
                                }
                        }
                        
                        if isCard2Visible {
                            Image("Card_2")
                                .resizable()
                                .frame(width: 70, height: 40).offset(x: 0,y: -40)
                                .onTapGesture {
                                    withAnimation {
                                        isCard2Visible = false
                                        if expValue < 1.0 {
                                            expValue += 0.25  // Increment EXP here
                                        }
                                    }
                                }
                        }
                    }
                    
                    HStack(spacing: 150) {
                        if isCard3Visible {
                            Image("Card_3")
                                .resizable()
                                .frame(width: 70, height: 50).offset(x: 0,y: -10)
                                .onTapGesture {
                                    withAnimation {
                                        isCard3Visible = false
                                        if expValue < 1.0 {
                                            expValue += 0.25  // Increment EXP here
                                        }
                                    }
                                }
                        }
                        
                        if isPoopVisible {
                            Image("Poop")
                                .resizable()
                                .frame(width: 60, height: 60).offset(x: -100,y: 0)
                                .onTapGesture {
                                    withAnimation {
                                        isPoopVisible = false
                                        if expValue < 1.0 {
                                            expValue -= 0.1  // Decrement EXP here
                                        }
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
                                Text("Aditya Lv.3")
                                Spacer()
                                Text("+ EXP")
                            }
                            .font(.system(size: 22))
                            .bold()
                            .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.5))
                            
                            ProgressBar(value: expValue)
                                .frame(height: 10)
                        }
                        .frame(width: UIScreen.main.bounds.width - 40) // Set a defined width
                        .offset(x: 0,y: 40)
                    }
                    .frame(width: 400.0, height: 130.0)
                    
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
                    .frame(width: UIScreen.main.bounds.width, height: 60)
                    //                .frame(maxWidth: .infinity)
                    //                .padding()
                    .frame(height: 50.0)
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
