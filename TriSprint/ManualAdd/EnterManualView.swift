//
//  EnterManualView.swift
//  TriSprint
//
//  Created by Nigel Karan on 23.11.21.
//

import SwiftUI
import Combine

struct EnterManualView: View {
    
    @Binding var plan: Plan
    @State private var session: Activity = .swim
    @State var targetTime = ""
    @ObservedObject private var actualTime = NumbersOnly()
    @ObservedObject private var actualDistance = NumbersOnly()
    @StateObject private var sessionVm = SessionViewModel()
    @State private var isKilometres = true
    @State private var isTyping = false
    @State private var isBrick = false
    @State private var shouldShowBrickActions = false
    @State private var pace = ""
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                switch session {
                case .swim:
                    SwimBackground()
                case .ride:
                    BikeBackground()
                case .run:
                    RunBackground()
                }
                
                VStack {
                    Text("Day: \(plan.day ?? "")")
                        .foregroundColor(Color.mainText)
                        .font(.title)
                        .padding()
                    Spacer()
                    
                    VStack {
                        targetView
                        textFieldView
                        paceCalcView
                        Spacer()
                        saveButton
                        Spacer()
                    }
                }
                if sessionVm.isSaving {
                    withAnimation {
                        LoadingView(loadingText: "Saving..")
                    }
                }
            }
            .onTapGesture {
                dismissKeyboard()
            }
            .alert(isPresented: $sessionVm.showConfirmationPopup) {
                savedConfirmationAlert
                
            }
            .actionSheet(isPresented: $shouldShowBrickActions) {
                actionSheet
            }
        }
        .onAppear {
            setTarget()
            if UserDefaults.standard.string(forKey: UserDefaults.Keys.measure.rawValue) == Measure.kilometers.rawValue {
                isKilometres = true
            } else {
                isKilometres = false
            }
        }
    }
    
}

extension EnterManualView {
    private var savedConfirmationAlert: Alert {
        Alert(title: Text("SAVED!"), message: Text("This session has been saved"), dismissButton: .default(Text("OK"), action: {
            if isBrick {
                shouldShowBrickActions.toggle()
            } else {
                sessionVm.markPlanComplete(plan: plan)
                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
            }
            
        }))
    }
    
    private var actionSheet: ActionSheet {
        ActionSheet(title: Text("FINISHED?"), message: Text("Have you completed both your activities for this BRICK session"), buttons: [
            .default(Text("YES!"), action: {
                sessionVm.markPlanComplete(plan: plan)
                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
            }),
            .destructive(Text("NO!"),
                         action: {
                             presentationMode.wrappedValue.dismiss()
                         })
        ])
    }
    
    private var targetView: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(plan.session ?? "")")
                    .foregroundColor(Color.mainText)
                    .font(.title3)
                    .padding()
                Spacer()
            }.background(Color.accentButton.opacity(0.3))
            
            HStack(alignment: .firstTextBaseline) {
                Text("Target Time:")
                    .foregroundColor(Color.mainText)
                    .font(.body)
                Text(targetTime)
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 35, weight: .semibold, design: .rounded))
                Text("mins")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
            }
        }
    }
    
    private var textFieldView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Time in mins")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                Spacer()
                
                TextField("Enter mins...", text: $actualTime.value)
                    .frame(width: 150, height: 100, alignment: .center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(Color.mainText)
                    .keyboardType(.decimalPad)
            }
            .padding(.horizontal,40)
            
            HStack {
                Text(isKilometres ? "Distance in km" : "Distance in miles")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                Spacer()
                TextField("Enter distance", text: $actualDistance.value, onEditingChanged: { isTyping in
                    if isTyping {
                    } else {
                        let paceStr = calculatePace(time: actualTime.value, distance: actualDistance.value)
                        self.pace = paceStr
                    }
                })
                    .frame(width: 150, height: 100, alignment: .center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(Color.mainText)
                    .keyboardType(.decimalPad)
                
            }
            .padding(.horizontal, 40)
        }
    }
    
    private var paceCalcView: some View {
        HStack {
            HStack {
                Text(isKilometres ? "Mins / km" : "Mins / mile")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 0))
                Spacer()
            }
            Text(pace)
                .foregroundColor(Color.mainText)
                .font(.system(size: 20, weight: .regular, design: .rounded))
                .padding(.trailing, 20)
        }
        .background(Color.accentButton.opacity(0.2))
        .padding(.horizontal, 40)
        .padding(.top, 40)
    }
    
    private var saveButton: some View {
        Button {
            sessionVm.saveManualSession(session: plan.session ?? "", measure: isKilometres ? Measure.kilometers.rawValue : Measure.miles.rawValue, distance: actualDistance.value, duration: actualTime.value)
        } label: {
            Text("Save")
                .foregroundColor(Color.mainText)
                .font(.system(size: 35, weight: .medium, design: .rounded))
        }
        .modifier(GreenButton())
    }
    
    private func calculatePace(time: String, distance: String) -> String {
        let paceDble = (Double(time) ?? 0) / (Double(distance) ?? 0)
        let paceStr = String(format: "%.2f", paceDble)
        return paceStr
    }
    
    private func setTarget() {
        
        if plan.session == Sessions.swim.rawValue {
            targetTime = plan.swimTime ?? ""
            session = .swim
        } else if plan.session == Sessions.ride.rawValue {
            targetTime = plan.rideTime ?? ""
            session = .ride
        } else if plan.session == Sessions.run.rawValue {
            targetTime = plan.runTime ?? ""
            session = .run
        } else if plan.session == Sessions.rideRun.rawValue {
            isBrick = true
            targetTime = targetTime
        }
    }
}

struct EnterManualView_Previews: PreviewProvider {
    static var previews: some View {
        EnterManualView(plan: .constant(Plan()))
    }
}