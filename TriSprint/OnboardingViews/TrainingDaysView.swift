//
//  PersonaliseView.swift
//  TriSprint
//
//  Created by Nigel Karan on 11.11.21.
//

import SwiftUI

struct TrainingDaysView: View {
   
    @State private var daysSelected = ""
    @State private var nextScreen = false
    @ObservedObject var trainingPlanVm = TrainingPlanArrayViewModel()
    @State private var showConfirmationPopup: Bool = false
    @EnvironmentObject var loginVm: LoginViewModel
    
    var body: some View {
        
        ZStack {
            TriBackground()
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
            
            VStack {
                if trainingPlanVm.isSaving {
                    withAnimation {
                        LoadingView(loadingText: "Get ready...")
                    }
                }
            }
            .halfSheet(showSheet: $trainingPlanVm.hasLoadedPlans) {
                plansLoadedHalfModal
            } onEnd: {
                print("Dismissed")
            }

        }
    }
    
}

extension TrainingDaysView {
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
        .padding(.horizontal,20)
    }
    
    private var buttonsView: some View {
        VStack {
            ForEach(trainingPlanVm.numberOfTrainingDaysArray, id: \.self) { num in
                Button {
                    daysSelected = num
                    CustomUserDefaults.shared.set(num, key: .trainingDays)
                    trainingPlanVm.fetchPlanArray(name: num)
                    trainingPlanVm.showLoadingSpinner()
                    //showConfirmationPopup = true
                } label: {
                    Text(num)
                        .foregroundColor(Color.mainText)
                        .font(.system(.title, design: .rounded))
                        .frame(maxWidth: .infinity)
                }
                .modifier(GreenButton())
                .padding(.leading, 10)
                .padding(.trailing, 10)
            }
        }
        .padding()
    }
    

    
    private var plansLoadedHalfModal: some View {
        ZStack {
            Color.mainBackground.opacity(0.98)
            VStack {
                Text("BBOoooommmm!! You are on your way!\n\nGood Luck, you'll be amazing 😊")
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button {
                    loginVm.onBoarded = true
                    trainingPlanVm.hasLoadedPlans = false
                } label: {
                    Text("I'm READY! 🏊🏼🚴🏼‍♀️🏃🏾!")
                        .foregroundColor(Color.mainButton)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .padding()
            }
        }
        .ignoresSafeArea()
    }
    
}

struct TrainingDaysView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingDaysView()
    }
}
