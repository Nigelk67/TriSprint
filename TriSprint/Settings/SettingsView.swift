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
    @State var showDeleteAccountWarning: Bool = false
    @State var noPlansWarning: Bool = false
    @State var plansDeletedConfirmation: Bool = false
    @State var accountDeletedConfirmation: Bool = false
    @State var showUpdateEmailView: Bool = false
    @State var showUpdatePasswordView: Bool = false
    @State var showGlossaryView: Bool = false
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
        NavigationView {
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
                            glossaryButton
                            resetPlansButton
                                .halfSheet(showSheet: $plansDeletedConfirmation) {
                                    confirmPlansDeletedHalfModal
                                } onEnd: {
                                    print("Dismissed")
                                }
                            resetActivitiesButton
                            resetEverythingButton
                            logoutButton
                            deleteAccountButton
                            Spacer()
                        }
                    }
                    NavigationLink(destination: EmailUpdateView(), isActive: $showUpdateEmailView) { EmptyView() }
                    NavigationLink(destination: PasswordChangeView(), isActive: $showUpdatePasswordView) { EmptyView() }
                    NavigationLink(destination: GlossaryView(), isActive: $showGlossaryView) { EmptyView() }
                }
                VStack {
                    if settingsVm.isSaving {
                        withAnimation {
                            LoadingView(loadingText: "Processing..")
                        }
                    }
                }
                
            }
            .onAppear {
                if measure == Measure.kilometers.rawValue {
                    isKilometers = true
                } else {
                    isKilometers = false
                }
            }
            .navigationTitle("")
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
