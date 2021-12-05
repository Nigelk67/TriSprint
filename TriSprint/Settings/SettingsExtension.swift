//
//  SettingsExtension.swift
//  TriSprint
//
//  Created by Nigel Karan on 01.12.21.
//

import SwiftUI


extension SettingsView {
    //MARK: Buttons
    var metricsButton: some View {
        VStack {
            Text("Kilometers Or Miles?")
                .foregroundColor(Color.mainText)
                .font(.system(size: 24, weight: .regular, design: .rounded))
            if isKilometers {
                HStack {
                    Button {
                        isKilometers = true
                        measure = Measure.kilometers.rawValue
                        CustomUserDefaults.shared.set(Measure.kilometers.rawValue, key: .measure)
                    } label: {
                        Text("Km")
                            .foregroundColor(Color.mainText)
                            .font(.system(.title, design: .rounded))
                            .frame(maxWidth: .infinity)
                    }
                    .modifier(SmallGreenButton())
                    .padding()
                    
                    
                    Button {
                        isKilometers = false
                        measure = Measure.miles.rawValue
                        CustomUserDefaults.shared.set(Measure.miles.rawValue, key: .measure)
                    } label: {
                        Text("Mi")
                            .foregroundColor(Color.mainText)
                            .font(.system(.title, design: .rounded))
                            .frame(maxWidth: .infinity)
                    }
                    .modifier(SmallGreyButton())
                    .padding()
                }
                .frame(width: 300, height: 60)
                
            } else {
                HStack {
                    Button {
                        isKilometers = true
                        measure = Measure.kilometers.rawValue
                        CustomUserDefaults.shared.set(Measure.kilometers.rawValue, key: .measure)
                    } label: {
                        Text("Km")
                            .foregroundColor(Color.mainText)
                            .font(.system(.title, design: .rounded))
                            .frame(maxWidth: .infinity)
                    }
                    .modifier(SmallGreyButton())
                    .padding()
                    
                    
                    Button {
                        isKilometers = false
                        measure = Measure.miles.rawValue
                        CustomUserDefaults.shared.set(Measure.miles.rawValue, key: .measure)
                    } label: {
                        Text("Mi")
                            .foregroundColor(Color.mainText)
                            .font(.system(.title, design: .rounded))
                            .frame(maxWidth: .infinity)
                    }
                    .modifier(SmallGreenButton())
                    .padding()

                }
                .frame(width: 300, height: 60)
            }
        }.modifier(SettingsButtons())
    }
    
    var resetActivitiesButton: some View {
        Button {
            showResetActivitiesWarning = true
        } label: {
            Text("Reset Activities")
                .modifier(SettingsButtons())
        }
        .actionSheet(isPresented: $showResetActivitiesWarning) {
            resetActivitiesAction
        }
    }
    
    var resetPlansButton: some View {
        Button {
            showResetPlansWarning = true
        } label: {
            Text("Reset Plans")
                .modifier(SettingsButtons())
        }
        .actionSheet(isPresented: $showResetPlansWarning) {
            resetPlansAction
        }
        .halfSheet(showSheet: $noPlansWarning) {
            noPlansHalfModal
        } onEnd: {
            print("Dismissed")
        }

    }
    
    var resetEverythingButton: some View {
        Button {
            showResetEverythingWarning = true
        } label: {
            Text("Reset Everything")
                .modifier(SettingsButtons())
        }
        .actionSheet(isPresented: $showResetEverythingWarning) {
            resetEverythingAction
        }
    }
    
    var changeEmailButton: some View {
        Button {
            print("Nige: Show Alert")
        } label: {
            Text("Change Email")
                .modifier(SettingsButtons())
        }
    }
    
    var changePasswordButton: some View {
        Button {
            print("Nige: Show Alert")
        } label: {
            Text("Change Password")
                .modifier(SettingsButtons())
        }
    }
    
    var deleteAccountButton: some View {
        Button {
            showDeleteAccountWarning.toggle()
        } label: {
            Text("Delete Account")
                .modifier(SettingsButtons())
        }
        .actionSheet(isPresented: $showDeleteAccountWarning) {
            deleteAccountAction
        }
        .alert(isPresented: $settingsVm.accountDeletedConfirmation) {
            Alert(title: Text("Deleted"), message: Text("Your account has been deleted"), dismissButton: .destructive(Text("OK"), action: {
                loginVm.signedIn = false
            }))
        }
//        .halfSheet(showSheet: $settingsVm.accountDeletedConfirmation) {
//            confirmAccountDeletedHalfModal
//        } onEnd: {
//            print("Dismissed")
//        }
        
    }
    
    var logoutButton: some View {
        Button {
            showLogoutWarning.toggle()
        } label: {
            Text("Log Out")
                .modifier(SettingsButtons())
        }
        .actionSheet(isPresented: $showLogoutWarning) {
            logoutAction

        }
    }
    
 
    
   
    
}


