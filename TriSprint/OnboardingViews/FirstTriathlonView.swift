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
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
    
}

extension FirstTriathlonView {
    private var selectionView: some View {
        VStack {
            Text("Is This Your First Triathlon?")
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
        .padding(.horizontal, 20)
    }
    
    private var buttonsView: some View {
        VStack {
            NavigationLink(destination: FitnessLevelView(), isActive: $nextScreen) { EmptyView() }
            Button {
                UserDefaults.standard.set(true, forKey: UserDefaults.Keys.first.rawValue)
                nextScreen.toggle()
            } label: {
                Text("Yes")
                    .foregroundColor(Color.mainText)
                    .font(.system(.title, design: .rounded))
                    .frame(maxWidth: .infinity)
            }
            .modifier(GreenButton())
            .padding(.horizontal,10)
            
            Button {
                UserDefaults.standard.set(false, forKey: UserDefaults.Keys.first.rawValue)
                nextScreen.toggle()
            } label: {
                Text("No")
                    .foregroundColor(Color.mainText)
                    .font(.system(.title, design: .rounded))
                    .frame(maxWidth: .infinity)
            }
            .modifier(GreenButton())
            .padding(.horizontal,10)
            
        }
        .padding()
        
    }
}

struct FirstTriathlonView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTriathlonView()
    }
}
