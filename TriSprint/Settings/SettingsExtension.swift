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
        }
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
        .alert(isPresented: $noPlansWarning) {
            noPlansAlert
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
    private var logoutAction: ActionSheet {
        ActionSheet(title: Text("Logout?"), message: Text("Are you sure?"), buttons: [
            .destructive(Text("Yes 👍🏽"), action: {
                //signedIn = false
                loginVm.signedIn = false
            }),
            .cancel()
        ])
    }
    
    private var resetPlansAction: ActionSheet {
        ActionSheet(title: Text("NOTE: THIS WILL DELETE ALL CURRENT PLANS"), message: Text("Do you want to continue with the reset?"), buttons: [
            .destructive(Text("YES!"), action: {
                if !plans.isEmpty {
                    deletePlans()
                } else {
                    noPlansWarning = true
                }
                showResetPlansWarning = false
            }),
            .default(Text("Oooppss - NO!"),
                     action: {
                         showResetPlansWarning = false
                     })
        ])
    }
    
    private var resetActivitiesAction: ActionSheet {
        ActionSheet(title: Text("NOTE: THIS WILL DELETE ALL YOUR ACTIVITIES"), message: Text("This is permanent. \nDo you want to continue?"), buttons: [
            .destructive(Text("YES!"), action: {
                deleteActivities()
                showResetActivitiesWarning = false
            }),
            .default(Text("Aarrghh - NO!"),
                     action: {
                         showResetActivitiesWarning = false
                     })
        ])
    }
    
    private var resetEverythingAction: ActionSheet {
        ActionSheet(title: Text("NOTE: THIS WILL DELETE ALL CURRENT PLANS AND ALL ACTIVITES"), message: Text("This is permanent.\nDo you want to continue?"), buttons: [
            .destructive(Text("YES!"), action: {
                deletePlans()
                deleteActivities()
                showResetEverythingWarning = false
            }),
            .default(Text("Oooppss - NO!"),
                     action: {
                         showResetEverythingWarning = false
                     })
        ])
    }
    
    //MARK: Alerts
    private var noPlansAlert: Alert {
        Alert(title: Text("No Plans"), message: Text("You don't have any scheduled training plans"), dismissButton: .default(Text("OK")))
    }
    
    var confirmationAlert: Alert {
        Alert(title: Text("DONE!"), message: Text("Actions completed"), dismissButton: .default(Text("OK")))
    }
    
    //MARK: Functions
    private func deletePlans() {
        showSpinner()
        plans.forEach { plan in
            viewContext.delete(plan)
        }
        do {
            try viewContext.save()
        } catch {
            print("Failed to delete all plans", error)
        }
        
    }
    private func deleteActivities() {
        showSpinner()
        swims.forEach { swim in
            viewContext.delete(swim)
        }
        rides.forEach { ride in
            viewContext.delete(ride)
        }
        runs.forEach { run in
            viewContext.delete(run)
        }
        do {
            try viewContext.save()
        } catch {
            print("Failed to delete activities", error)
        }
    }
    
    func showSpinner() {
       isSaving = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           isSaving = false
            self.confirmed = true
        }
       
    }
}


