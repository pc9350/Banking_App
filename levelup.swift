import SwiftUI
import UIKit


struct ContentView: View {
   @State var points: Int = 0
    @State var level: Int = 0
    var body: some View {
        Group
        {VStack(spacing: 10){
            
            Button("Click10"){
                
                self.points += 10
                if (points >= 60){
                    points = 0
                    level += 1
                }
                
            }
            Button("Click5"){
                
                self.points += 5
                if (points >= 60){
                    points = 0
                    level += 1
                    
                }
                
            }
            
            ZStack(alignment: .bottomLeading) {
                Rectangle().foregroundColor(.green)
                Text("Aditya Lvl " + String(level) + " " + String(points)).fontWeight(.black)
                            .padding()
                    }
            
        }
        }.padding()
    }
    }


#Preview {
    ContentView()
}
