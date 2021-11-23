//
//  EnterManualView.swift
//  TriSprint
//
//  Created by Nigel Karan on 23.11.21.
//

import SwiftUI

struct EnterManualView: View {
    
    @Binding var plan: Plan
    @State private var session: Activity = .swim
    @State private var targetTime = ""
    @ObservedObject private var actualTime = NumbersOnly()
    @ObservedObject private var actualDistance = NumbersOnly()
    @State private var isKilometres = true
    @State private var pace = ""
    
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
                        
                        Spacer()
                    }
                    
                    Button {
                        print("Save button pressed")
                    } label: {
                        Text("SAVE")
                            .foregroundColor(Color.mainText)
                            .font(.system(size: 35, weight: .medium, design: .rounded))
                    }
                    .modifier(GreenButton())
                }
            }
            .onTapGesture {
                dismissKeyboard()
            }
        }
        .onAppear {
            setTarget()
            if UserDefaults.Keys.measure.rawValue == "Kilometers" {
                isKilometres = true
            } else {
                isKilometres = false
            }
            
        }
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
                TextField("Enter distance", text: $actualDistance.value)
                    .frame(width: 150, height: 100, alignment: .center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(Color.mainText)
                    .keyboardType(.decimalPad)
            }
            .padding(.horizontal, 40)
        }
    }
    
    private var paceCalcView: some View {
        VStack {
        HStack {
            Text(isKilometres ? "Mins / km" : "Mins / mile")
                .foregroundColor(Color.mainText)
                .font(.system(size: 18, weight: .regular, design: .rounded))
            Spacer()
            Text(pace)
                .foregroundColor(Color.mainText)
                .font(.system(size: 26, weight: .regular, design: .rounded))
        }
        .padding(.horizontal, 40)
        }
    }
    
    private func setTarget() {
        
        if plan.session == Sessions.swim.rawValue {
            targetTime = plan.swimTime ?? ""
            session = .swim
        } else if plan.session == Sessions.ride.rawValue {
            targetTime = plan.rideTime ?? ""
            session = .ride
        } else {
            targetTime = plan.runTime ?? ""
            session = .run
        }
    }
}

struct EnterManualView_Previews: PreviewProvider {
    static var previews: some View {
        EnterManualView(plan: .constant(Plan()))
    }
}
