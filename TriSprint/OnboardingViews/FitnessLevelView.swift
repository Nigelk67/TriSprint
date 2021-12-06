//
//  FitnessLevelView.swift
//  TriSprint
//
//  Created by Nigel Karan on 12.11.21.
//

import SwiftUI

struct FitnessLevelView: View {
    
    let fitnessLevels = ["Better than good","Good","Not that good"]
    @State private var fitnessLevel = ""
    @State private var nextScreen = false
    @State private var showFitnessTestModal = false
    
    var body: some View {
        ZStack {
            BikeBackground()
            VStack {
                Spacer()
                Text("Personalise Your Plan")
                    .foregroundColor(Color.accentButton)
                    .font(.system(size: 32, weight: .medium, design: .rounded))
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

extension FitnessLevelView {
    private var selectionView: some View {
        VStack {
            HStack {
            Text("What's your general level of fitness?")
                .foregroundColor(Color.mainText)
                .font(.system(.title2, design: .rounded))
                .padding(.vertical)
                .multilineTextAlignment(.center)
                .padding()
                Button {
                    showFitnessTestModal.toggle()
                } label: {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(Color.mainButton)
                        .font(.system(size: 20))
                }
                .halfSheet(showSheet: $showFitnessTestModal) {
                    fitnessLevelHalfModal
                } onEnd: {
                    print("Dismissed")
                }
            }
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
                        CustomUserDefaults.shared.set(level, key: .fitnessLevel)
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
    
    var fitnessLevelHalfModal: some View {
        ZStack {
            Color.mainBackground.opacity(0.98)
            VStack {
                Text("Assess Your Fitness")
                    .font(.system(size: 24, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("The following times (mins) show the fitness level for someone with a relatively good level of fitness running 2.5km (1.5mi).\n\nSelect your answer based on your running time for this distance.")
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                HStack(spacing: 50) {
                    VStack {
                        Text("Age")
                            .foregroundColor(Color.mainText)
                            .font(.system(size: 24, weight: .regular, design: .rounded))
                        Text("25")
                        Text("35")
                        Text("45")
                        Text("55")
                        Text("65")
                    }
                    VStack {
                        Text("Women")
                            .foregroundColor(Color.mainText)
                            .font(.system(size: 24, weight: .regular, design: .rounded))
                        Text("13")
                            
                        Text("13.5")
                        Text("14")
                        Text("16")
                        Text("17.5")
                    }
                    VStack {
                        Text("Men")
                            .foregroundColor(Color.mainText)
                            .font(.system(size: 24, weight: .regular, design: .rounded))
                        Text("11")
                        Text("11.5")
                        Text("12")
                        Text("13")
                        Text("14")
                    }
                }
                .foregroundColor(Color.white)
                .font(.system(size: 20, weight: .regular, design: .rounded))
               
                
                Button {
                    showFitnessTestModal.toggle()
                } label: {
                    Text("Close")
                        .foregroundColor(Color.mainButton)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

struct FitnessLevelView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessLevelView()
    }
}
