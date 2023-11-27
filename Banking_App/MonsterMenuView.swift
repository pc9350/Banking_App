//
//  MonsterMenuView.swift
//  Banking_App
//
//  Created by Izzy Bogot on 11/3/23.
//

import SwiftUI
//
//struct MonsterMenuView: View {
//    var body: some View {
//        NavigationView {
//            ZStack {
//                // Background Image
//                Image("Monster")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                
//                VStack(spacing: -70) {
//                    HStack {
//                        NavigationLink(destination: ImageView(imageName: "Eggplant Bat")){
//                            Image("PurpleMonster")  // Replace icon
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 180, height: 180)
//                                .padding(.top, 280)
//                        }
//                        Spacer()
//                    }
//                    HStack {
//                        Spacer()
//                        NavigationLink(destination: ImageView(imageName: "Lollipop")){
//                            Image("Friend_Monster")  // Replace icon
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 180, height: 180)
//                                .padding(.bottom, -60)
//                                .padding(.top, 135)
//                        }
//                    }
//                    HStack {
//                        NavigationLink(destination: ImageView(imageName: "Fluffy Potato")){
//                            Image("Yellow Monster")  // Replace icon
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 180, height: 180)
//                                .padding(.top, 20)
//                        }
//                        Spacer()
//                    }
//                    HStack {
////                        Spacer()
//                        NavigationLink(destination: ImageView(imageName: "Onion")){
//                            Image("COM_icon")  // Replace icon
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 180, height: 180)
//                                .padding(.bottom, 100)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
struct MonsterMenuView: View {
    @State private var selection: String? = nil

    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("Monster")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width+20, height: UIScreen.main.bounds.height+70)
                    .ignoresSafeArea()
                
                VStack(spacing: -70) {
                    HStack {
                        NavigationLink(destination: ImageView(imageName: "Eggplant Bat"), tag: "Eggplant Bat", selection: $selection) {
                            EmptyView()
                        }
                        Button(action: {
                            self.selection = "Eggplant Bat"
                        }) {
                            Image("PurpleMonster")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 180)
                                .padding(.top, 280)
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: ImageView(imageName: "Lollipop"), tag: "Lollipop", selection: $selection) {
                            EmptyView()
                        }
                        Button(action: {
                            self.selection = "Lollipop"
                        }) {
                            Image("Friend_Monster")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 180)
                                .padding(.bottom, -80)
                                .padding(.top, 135)
                        }
                    }
                    
                    HStack {
                        NavigationLink(destination: ImageView(imageName: "Fluffy Potato"), tag: "Fluffy Potato", selection: $selection) {
                            EmptyView()
                        }
                        Button(action: {
                            self.selection = "Fluffy Potato"
                        }) {
                            Image("Yellow Monster")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 180)
                                .padding(.top, 20)
                        }
                        Spacer()
                    }
                    
                    HStack {
                        NavigationLink(destination: ImageView(imageName: "Onion"), tag: "Onion", selection: $selection) {
                            EmptyView()
                        }
                        Button(action: {
                            self.selection = "Onion"
                        }) {
                            Image("COM_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 180)
                                .padding(.bottom, 100)
                        }
                    }
                }
            }
        }
    }
}





#Preview {
    MonsterMenuView()
}
