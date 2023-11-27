//
//  MonsterMenu.swift
//  Banking_App
//
//  Created by Izzy Bogot on 10/25/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image("MonstersMenuPage.jpg")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .edgesIgnoringSafeArea(.all)

        // Other page content
        // Text("Banking Monsters")
        //     .font(.largeTitle)
        //     .foregroundColor(.white)
    }
}

#Preview {
    ContentView()
}
