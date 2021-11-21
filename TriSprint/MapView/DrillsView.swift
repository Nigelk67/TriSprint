//
//  DrillsView.swift
//  TriSprint
//
//  Created by Nigel Karan on 21.11.21.
//

import SwiftUI

struct DrillsView: View {
    
    @Binding var plan: Plan
    let noDrillsText = "No drills for this session"
    
    var body: some View {
        
        ZStack {
            VStack() {
                Text("Session Drills")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 24, weight: .regular, design: .rounded))
                    .padding(.vertical, 20)
                
                descriptionView

                Spacer()
            }
            .padding()
            .background(Color.accentButton)
            .opacity(0.95)
            .cornerRadius(10)
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(width: 350, height: 100)
    }
    
    
    private var descriptionView: some View {
        VStack {
        if plan.session == Sessions.ride.rawValue {
            if plan.rideDescription == "" {
                Text(noDrillsText)
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .multilineTextAlignment(.center)
            } else {
                Text(plan.rideDescription ?? "")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .multilineTextAlignment(.center)
            }
            
        } else {
            if plan.runDescription == "" {
                Text(noDrillsText)
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .multilineTextAlignment(.center)
            } else {
                Text(plan.runDescription ?? "")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .multilineTextAlignment(.center)
            }
        }
        }
    }
    
}

struct DrillsView_Previews: PreviewProvider {
    static var previews: some View {
        DrillsView(plan: .constant(Plan()))
    }
}
