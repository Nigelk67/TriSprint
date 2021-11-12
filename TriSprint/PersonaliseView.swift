//
//  PersonaliseView.swift
//  TriSprint
//
//  Created by Nigel Karan on 11.11.21.
//

import SwiftUI

struct PersonaliseView: View {
    
    let numberOfDays = ["3","4","5"]
    @State private var daysSelected = ""
    @State private var nextScreen = false
    
    var body: some View {
        
            ZStack {
                SwimBackground()
                VStack {
                    Spacer()
                    Text("Personalise Your Plan")
                        .foregroundColor(Color.accentButton)
                        .font(.system(.largeTitle, design: .rounded))
                        .padding(.vertical)
                    Spacer()
                    selectionView
                    Spacer()
                    Spacer()
                        .navigationTitle("")
                }
            }
        
        
    }
    
    private var selectionView: some View {
        VStack {
            Text("How many days per week can you train?")
                .foregroundColor(Color.mainText)
                .font(.system(.title2, design: .rounded))
                .padding(.vertical)
                .multilineTextAlignment(.center)
                .padding()
            
            buttonsView
            
        }
        .background(Color.white)
        .opacity(0.7)
        .cornerRadius(8)
        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
        
    }
    
    private var buttonsView: some View {
        VStack {
            ForEach(numberOfDays, id: \.self) { num in
                NavigationLink(destination: FirstTriathlonView(), isActive: $nextScreen) {
                Button {
                    daysSelected = num
                    print("Nige: Set PList here?")
                    nextScreen.toggle()
                } label: {
                    Text(num)
                        .foregroundColor(Color.mainText)
                        .font(.system(.title, design: .rounded))
                }
                .modifier(GreenButton())
                }
            }
            .padding()
        }
    }
    
}


struct PersonaliseView_Previews: PreviewProvider {
    static var previews: some View {
        PersonaliseView()
    }
}
