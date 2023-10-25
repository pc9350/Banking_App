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
                    .foregroundColor(Color.gray.opacity(0.3))
                
                Rectangle()
                    .foregroundColor(Color.blue)
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
    
    //    @State private var image1Offset: CGSize = CGSize.zero
    //    @State private var image2Offset: CGSize = CGSize.zero
    
    var body: some View {
        ZStack {
            // Background Image
            Image("homePage_Background")  // Replace with the name of your background image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            // other UI elements here
            VStack {
                ZStack(alignment: .top) {
                    // Monster Image
                    Image("Monster_Homepage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150.0, height: 150.0).offset(x: 0,y: 280)
                    
                    ThoughtBubble()
                        .stroke(Color.gray, lineWidth: 2)
                        .frame(width: 150.0, height: 50.0)
                        .offset(x: -100, y: 200)
                        .scaleEffect(scale)
                        .animation(
                            Animation.easeInOut(duration: 1)
                                .repeatForever(autoreverses: true),
                            value: scale  // Associate the animation with the 'scale' state variable
                        )
                        .onAppear() {
                            self.scale = 1.05
                        }
                        .overlay(
                            // Text in Thought Bubble
                            Text(isTextVisible ? "Hi There, you got a credit card payment due in 6 days!" : "")
                                .foregroundColor(.black)
                        )
                        .onTapGesture {
                            self.isTextVisible.toggle()
                        }
                }
                
                Spacer()
                
                
                
                //                HStack {
                //                    if isImage1Visible {
                //                        Image("Card_1")
                //                            .resizable()
                //                            .frame(width: 100, height: 100)
                //                            .offset(x: image1Offset.width, y: image1Offset.height)
                //                            .onTapGesture {
                //                                withAnimation {
                //                                    isImage1Visible = false
                //                                }
                //                            }
                //                            .transition(.opacity)
                //                    }
                //
                //                    if isImage2Visible {
                //                        Image("Card_2")
                //                            .resizable()
                //                            .frame(width: 100, height: 100)
                //                            .offset(x: image2Offset.width, y: image2Offset.height)
                //                            .onTapGesture {
                //                                withAnimation {
                //                                    isImage2Visible = false
                //                                }
                //                            }
                //                            .transition(.opacity)
                //                    }
                //
                //
                //                    // Add more images here with similar logic
                //                }
                HStack(spacing: 50) {
                    if isCard1Visible {
                        Image("Card_1")
                            .resizable()
                            .frame(width: 70, height: 70).offset(x: 0,y: -180)
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
                            .frame(width: 70, height: 70).offset(x: 0,y: -130)
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
                
                HStack(spacing: 100) {
                    if isCard3Visible {
                        Image("Card_3")
                            .resizable()
                            .frame(width: 70, height: 50).offset(x: 0,y: -100)
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
                            .frame(width: 60, height: 60).offset(x: 0,y: -80)
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

                HStack {
                        ProgressBar(value: expValue)
                            .frame(height: 20)
                    }
                    .frame(width: UIScreen.main.bounds.width - 40) // Set a defined width
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                
                
            }
        }

        .animation(.easeInOut(duration: 1), value: isCard1Visible)
        .animation(.easeInOut(duration: 1), value: isCard2Visible)
        .animation(.easeInOut(duration: 1), value: isCard3Visible)
        .animation(.easeInOut(duration: 1), value: isPoopVisible)
        //        .onAppear {
        //                    // Generate random offsets
        //                    image1Offset = randomOffset()
        //                    image2Offset = randomOffset()
        //                    // Generate more offsets for additional images
        //                }
    }
    
    //    func randomOffset() -> CGSize {
    //        let padding: CGFloat = 50  // Padding from the edges
    //        let imageWidth: CGFloat = 100  // Image width
    //        let imageHeight: CGFloat = 100  // Image height
    //
    //        // Calculate the range for random offsets
    //        let maxX = 150 - (imageWidth / 2 + padding)  // Max x-offset
    //        let maxY = 150 - (imageHeight / 2 + padding)  // Max y-offset
    //
    //        let minX = -(150 - (imageWidth / 2 + padding))  // Min x-offset
    //        let minY = -(150 - (imageHeight / 2 + padding))  // Min y-offset
    //
    //        let randomX = CGFloat.random(in: minX...maxX)
    //        let randomY = CGFloat.random(in: minY...maxY)
    //
    //        return CGSize(width: randomX, height: randomY)
    //    }
}

#Preview {
    ContentView()
}
