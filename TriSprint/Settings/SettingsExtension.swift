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
            print("Nige: Show Alert")
        } label: {
            Text("Delete Account")
                .modifier(SettingsButtons())
        }
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
    
    //MARK: ActionSheets
//    private var logoutAction: ActionSheet {
//        ActionSheet(title: Text("Logout?"), message: Text("Are you sure?"), buttons: [
//            .destructive(Text("Yes 👍🏽"), action: {
//                //signedIn = false
//                loginVm.signedIn = false
//            }),
//            .cancel()
//        ])
//    }
//    
//    private var resetPlansAction: ActionSheet {
//        
//        ActionSheet(title: Text("NOTE: THIS WILL DELETE ALL CURRENT PLANS"), message: Text("Do you want to continue with the reset?"), buttons: [
//            .destructive(Text("YES!"), action: {
//                if !plans.isEmpty {
//                    print("")
//                    settingsVm.deletePlans(plans: plans)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                        plansDeletedConfirmation = true
//                    }
//                    
//                } else {
//                    noPlansWarning = true
//                }
//                showResetPlansWarning = false
//            }),
//            .default(Text("Oooppss - NO!"),
//                     action: {
//                         showResetPlansWarning = false
//                     })
//        ])
//            
//    }
//        
//    
//    private var resetActivitiesAction: ActionSheet {
//        ActionSheet(title: Text("NOTE: THIS WILL DELETE ALL YOUR ACTIVITIES"), message: Text("This is permanent. \nDo you want to continue?"), buttons: [
//            .destructive(Text("YES!"), action: {
//                settingsVm.deleteActivities(swims: swims, rides: rides, runs: runs)
//                showResetActivitiesWarning = false
//            }),
//            .default(Text("Aarrghh - NO!"),
//                     action: {
//                         showResetActivitiesWarning = false
//                     })
//        ])
//    }
//    
//    private var resetEverythingAction: ActionSheet {
//        ActionSheet(title: Text("NOTE: THIS WILL DELETE ALL CURRENT PLANS AND ALL ACTIVITES"), message: Text("This is permanent.\nDo you want to continue?"), buttons: [
//            .destructive(Text("YES!"), action: {
//                settingsVm.deletePlans(plans: plans)
//                settingsVm.deleteActivities(swims: swims, rides: rides, runs: runs)
//                showResetEverythingWarning = false
//            }),
//            .default(Text("Oooppss - NO!"),
//                     action: {
//                         showResetEverythingWarning = false
//                     })
//        ])
//    }
    
    //MARK: Alerts
//    private var noPlansHalfModal: some View {
//        ZStack {
//            Color.mainBackground.opacity(0.95)
//            VStack {
//                Text("You don't have any scheduled plans 😮!")
//                    .font(.system(size: 32, weight: .medium, design: .rounded))
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.center)
//                    .padding()
//                Button {
//                    loginVm.onBoarded = false
//                    noPlansWarning.toggle()
//                } label: {
//                    Text("Take me to set up a plan immediately!")
//                        .foregroundColor(Color.mainButton)
//                        .font(.system(size: 24, weight: .regular, design: .rounded))
//                        .multilineTextAlignment(.center)
//                        .padding()
//                }
//                .padding()
//            }
//        }
//        .ignoresSafeArea()
//    }
//       
//    var confirmPlansDeletedHalfModal: some View {
//        ZStack {
//            Color.mainBackground.opacity(0.95)
//            VStack {
//                Text("Your plans have been deleted successfully.\n What next?")
//                    .font(.system(size: 32, weight: .medium, design: .rounded))
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.center)
//                    .padding()
//                Button {
//                    loginVm.onBoarded = false
//                } label: {
//                    Text("Take me to set up a new plan immediately!")
//                        .foregroundColor(Color.mainButton)
//                        .font(.system(size: 24, weight: .regular, design: .rounded))
//                        .multilineTextAlignment(.center)
//                        .padding()
//                }
//                .padding()
//                
//                Button {
//                    plansDeletedConfirmation.toggle()
//                } label: {
//                    Text("I'll come back to this later")
//                        .foregroundColor(Color.mainButton)
//                        .font(.system(size: 24, weight: .regular, design: .rounded))
//                        .multilineTextAlignment(.center)
//                        .padding()
//                }
//                .padding()
//            }
//        }
//        .ignoresSafeArea()
//    }
    
    var confirmationAlert: Alert {
        Alert(title: Text("DONE!"), message: Text("Actions completed"), dismissButton: .default(Text("OK")))
    }
    
   
    
}


