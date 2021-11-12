//
//  FirstTriathlonView.swift
//  TriSprint
//
//  Created by Nigel Karan on 12.11.21.
//

import SwiftUI

struct FirstTriathlonView: View {
    
    @State private var selection: String? = ""
    @State private var nextScreen = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                BikeBackground()
                VStack {
                    VStack {
                        Spacer()
                        Text("Is This Your First Triathlon?")
                            .foregroundColor(Color.accentButton)
                            .font(.system(.largeTitle, design: .rounded))
                            .multilineTextAlignment(.center)
                            .padding(EdgeInsets(top: 0, leading: 80, bottom: 0, trailing: 80))
                        Spacer()
                        buttonsView
                        Spacer()
                        Spacer()
                            .navigationTitle("")
                    }
                }
                
            }
        }
    }
    private var buttonsView: some View {
        VStack {
            NavigationLink(destination: PersonaliseView(), isActive: $nextScreen) { EmptyView() }
            Button {
                nextScreen.toggle()
            } label: {
                Text("Yes")
                    .foregroundColor(Color.mainText)
                    .font(.system(.title, design: .rounded))
                    .frame(maxWidth: .infinity)
            }
            .modifier(GreenButton())
            .padding(.leading, 40)
            .padding(.trailing, 40)

            Button {
                nextScreen.toggle()
            } label: {
                Text("No")
                    .foregroundColor(Color.mainText)
                    .font(.system(.title, design: .rounded))
                    .frame(maxWidth: .infinity)
            }
            .modifier(GreenButton())
            .padding(.leading, 40)
            .padding(.trailing, 40)
        }
        .padding()
        
    }
}

struct FirstTriathlonView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTriathlonView()
    }
}
