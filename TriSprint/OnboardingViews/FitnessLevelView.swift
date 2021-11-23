//
//  FitnessLevelView.swift
//  TriSprint
//
//  Created by Nigel Karan on 12.11.21.
//

import SwiftUI

struct FitnessLevelView: View {
    
    let fitnessLevels = ["Good","Average","Non-existent"]
    @State private var fitnessLevel = ""
    @State private var nextScreen = false
    //@Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ZStack {
            BikeBackground()
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
                    //.navigationBarBackButtonHidden(true)
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
//                            .toolbar {
//                                ToolbarItem(placement: .navigationBarLeading) {
//                                    CancelButton(presentationMode: presentationMode)
//                                }
//                            }
            }
        }
    }
    
    private var selectionView: some View {
        VStack {
            Text("What's your general level of fitness?")
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
            ForEach(fitnessLevels, id: \.self) { level in
                NavigationLink(destination: MetricView(), isActive: $nextScreen) {
                Button {
                    fitnessLevel = level
                    UserDefaults.standard.set(level, forKey: UserDefaults.Keys.fitnessLevel.rawValue)
                    nextScreen.toggle()
                } label: {
                    Text(level)
                        .foregroundColor(Color.mainText)
                        .font(.system(.title, design: .rounded))
                        .frame(maxWidth: .infinity)
                }
                .modifier(GreenButton())
                .padding(.horizontal, 10)
                }
            }
            .padding()
        }
    }
}

struct FitnessLevelView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessLevelView()
    }
}
