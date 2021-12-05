//
//  HalfModalAlerts_Settings.swift
//  TriSprint
//
//  Created by Nigel Karan on 05.12.21.
//

import SwiftUI

extension SettingsView {
    var noPlansHalfModal: some View {
        ZStack {
            Color.mainBackground.opacity(0.98)
            VStack {
                Text("You don't have any scheduled plans 😮!")
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Button {
                    loginVm.onBoarded = false
                    noPlansWarning.toggle()
                } label: {
                    Text("Take me to set up a plan immediately!")
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
       
    var confirmPlansDeletedHalfModal: some View {
        ZStack {
            Color.mainBackground.opacity(0.98)
            VStack {
                Text("Your plans have been deleted successfully.\n What next?")
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Button {
                    loginVm.onBoarded = false
                } label: {
                    Text("Take me to set up a new plan immediately!")
                        .foregroundColor(Color.mainButton)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .padding()
                
                Button {
                    plansDeletedConfirmation.toggle()
                } label: {
                    Text("I'll come back to this later")
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
    
    var confirmResetActivitiesHalfModal: some View {
        ZStack {
            Color.mainBackground.opacity(0.98)
            VStack {
                Text("Your activities have been reset. \n\n Onwards and upwards 💪🏽!!")
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Button {
                    loginVm.signedIn = false
                } label: {
                    Text("OK Thanks")
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
