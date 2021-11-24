//
//  PersonaliseView.swift
//  TriSprint
//
//  Created by Nigel Karan on 11.11.21.
//

import SwiftUI

struct TrainingDaysView: View {
    
    let numberOfDays = ["3","4","5"]
    @State private var daysSelected = ""
    @State private var nextScreen = false
    @ObservedObject var trainingPlanVm = TrainingPlanArrayViewModel()
    @State private var showConfirmationPopup: Bool = false
    //@Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        
        ZStack {
            RunBackground()
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
//                    .toolbar {
//                        ToolbarItem(placement: .navigationBarLeading) {
//                            CancelButton(presentationMode: presentationMode)
//                        }
//                    }
            }
            .alert(isPresented: $showConfirmationPopup) {
                Alert(title: Text("SAVED!"), message: Text("We've personalised your plan!\nYou'll see it in your Schedule"), dismissButton: .default(Text("OK"), action: {
                    UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
                }))
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
        .padding(.horizontal,20)
    }
    
    private var buttonsView: some View {
        VStack {
            ForEach(numberOfDays, id: \.self) { num in
                Button {
                    daysSelected = num
                    UserDefaults.standard.set(num, forKey: UserDefaults.Keys.trainingDays.rawValue)
                    trainingPlanVm.fetchPlanArray(name: num)
                    showConfirmationPopup = true
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
        //}
    }
    
}


struct PersonaliseView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingDaysView()
    }
}
