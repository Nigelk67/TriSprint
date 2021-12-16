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
    @State private var showWarning: Bool = false
    @EnvironmentObject var loginVm: LoginViewModel
    let fitnessLevel = CustomUserDefaults.shared.get(key: .fitnessLevel)
    
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
                if showWarning {
                    warningsView
                }
            }.animation(.default, value: showWarning)
            
            
            VStack {
                if trainingPlanVm.isSaving {
                    withAnimation {
                        LoadingView(loadingText: "Get ready...")
                    }
                }
            }
        }
    }
    
}

extension TrainingDaysView {
    private var selectionView: some View {
        ScrollView {
        VStack {
            Text("How many days per week can you train?")
                .foregroundColor(Color.mainText)
                .font(.system(.title2, design: .rounded))
                .padding(.vertical)
                .multilineTextAlignment(.center)
                .padding()
            Text("Note: All plans last for 13 weeks")
                .foregroundColor(Color.mainText)
                .font(.system(size: 20, weight: .regular, design: .rounded))
                .padding(.vertical)
                .multilineTextAlignment(.center)
                .padding()
            Text("(Get ready - selecting the number of days will load the plan into your schedule)")
                .foregroundColor(Color.mainText)
                .font(.system(size: 18, weight: .light, design: .rounded))
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
    }
    
    private var buttonsView: some View {
        VStack {
            ForEach(trainingPlanVm.numberOfTrainingDaysArray, id: \.self) { num in
                Button {
                    daysSelected = num
                    if fitnessLevel as! String == "Not that good" && num == "5" {
                        showWarning = true
                    } else {
                        CustomUserDefaults.shared.set(num, key: .trainingDays)
                        trainingPlanVm.fetchPlanArray(name: num)
                        trainingPlanVm.showLoadingSpinner()
                    }
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

                .halfSheet(showSheet: $trainingPlanVm.hasLoadedPlans) {
                    plansLoadedHalfModal
                } onEnd: {
                    print("Dismissed")
                }
                
                
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
    
    private var warningsView: some View {
        ZStack {
            VStack {
                Text("Are you sure?")
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("As you've said your fitness level is not that good, we suggest you train either 3 or 4 days per week to avoid any injuries and to build your fitness level gradually.")
                    .font(.system(size: 20, weight: .light, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button {
                    showWarning = false
                } label: {
                    Text("OK, I'll select another amount")
                        .foregroundColor(Color.mainButton)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .padding()
                Button {
                    showWarning = false
                    let daysSelected = "5"
                    CustomUserDefaults.shared.set(daysSelected, key: .trainingDays)
                    trainingPlanVm.fetchPlanArray(name: daysSelected)
                    trainingPlanVm.showLoadingSpinner()
                } label: {
                    Text("I'm ok with training 5 days per week")
                        .foregroundColor(Color.mainButton)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .padding()
            }
            .padding()
            .background(Color.mainBackground)
            .opacity(0.95)
            .cornerRadius(10)
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(width: 350, height: 100)
    }
    
}



struct TrainingDaysView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingDaysView()
    }
}
