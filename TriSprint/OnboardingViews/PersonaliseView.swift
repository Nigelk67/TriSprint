//
//  PersonaliseView.swift
//  TriSprint
//
//  Created by Nigel Karan on 03.12.21.
//

import SwiftUI

struct PersonaliseView: View {
    
    @State private var welcomeTextHeader: String = "Welcome to the TriSprint app!"
    @State private var welcomeText: String = "We're going to personalise the training plan just for you, so the next few screens will ask you a couple of questions to help the app do this."
    @State private var showNext: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                TriBackground()
                VStack {
                    header
                    Spacer()
                    textStack
                    Spacer()
                    nextButton
                    Spacer()
                    NavigationLink(destination: FirstTriathlonView(), isActive: $showNext) { EmptyView() }
                }
            }
            .navigationTitle("")
        }
    }
}

extension PersonaliseView {
    
    private var header: some View {
        VStack {
            Text("Personalise")
                .foregroundColor(Color.accentButton)
                .font(.system(size: 32, weight: .medium, design: .rounded))
                .padding(.vertical)
        }
    }
    
    private var textStack: some View {
        VStack {
            Text(welcomeTextHeader)
                .foregroundColor(Color.accentButton)
                .font(.system(size: 24, weight: .medium, design: .rounded))
                .multilineTextAlignment(.center)
                .padding()
            Text(welcomeText)
                .foregroundColor(Color.mainText)
                .font(.system(size: 20, weight: .regular, design: .rounded))
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(width: 300)
        .background(Color.white.opacity(0.4))
        .cornerRadius(10)
    }
    
    private var nextButton: some View {
        Button {
            showNext.toggle()
        } label: {
            Text("Let's Go!")
                .modifier(RegisterButtons())
        }
    }
    
}


struct PersonaliseView_Previews: PreviewProvider {
    static var previews: some View {
        PersonaliseView()
    }
}
