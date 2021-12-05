//
//  SettingsView.swift
//  TriSprint
//
//  Created by Nigel Karan on 30.11.21.
//

import SwiftUI

struct SettingsView: View {
    
    @State var isKilometers: Bool = false
    @State var showResetPlansWarning: Bool = false
    @State var showResetActivitiesWarning: Bool = false
    @State var showResetEverythingWarning: Bool = false
    @State var showLogoutWarning: Bool = false
    @State var noPlansWarning: Bool = false
    @State var plansDeletedConfirmation: Bool = false
//    @State var confirmed: Bool = false
//    @State var isSaving: Bool = false
//    @State var goToOnboarding: Bool = false
    @StateObject var settingsVm = SettingsViewModel()
    @EnvironmentObject var loginVm: LoginViewModel
    
    @AppStorage(AppStor.measure.rawValue) var measure: String?
    @AppStorage(AppStor.signedIn.rawValue) var signedIn: Bool?
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ride.timestamp, ascending: false)], animation: .default)
    var rides: FetchedResults<Ride>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Run.timestamp, ascending: false)], animation: .default)
    var runs: FetchedResults<Run>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Swim.timestamp, ascending: false)], animation: .default)
    var swims: FetchedResults<Swim>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Plan.day, ascending: true)], animation: .default)
    var plans: FetchedResults<Plan>
    
    var body: some View {
        ZStack {
            TriBackground()
            VStack {
                ScrollView {
                Text("Settings")
                    .foregroundColor(Color.accentButton)
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .padding(.vertical)
                
                    VStack(spacing: 20) {
                        metricsButton
                        changeEmailButton
                        changePasswordButton
                        resetPlansButton
                            .halfSheet(showSheet: $plansDeletedConfirmation) {
                                confirmPlansDeletedHalfModal
                            } onEnd: {
                                print("Dismissed")
                            }

                        resetActivitiesButton
                        resetEverythingButton
                        deleteAccountButton
                        logoutButton
                        Spacer()
                    }
                }
            }
            VStack {
                if settingsVm.isSaving {
                    withAnimation {
                        LoadingView(loadingText: "Processing..")
                    }
                }
            }
//            .alert(isPresented: $settingsVm.confirmed) {
//                confirmationAlert
//            }
        }
        .onAppear {
            if measure == Measure.kilometers.rawValue {
                isKilometers = true
            } else {
                isKilometers = false
            }
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
