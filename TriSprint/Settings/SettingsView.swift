//
//  SettingsView.swift
//  TriSprint
//
//  Created by Nigel Karan on 30.11.21.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var isKilometers: Bool = false
    @AppStorage("measure") var measure: String?
    
    var body: some View {
        
        ZStack {
            TriBackground()
            VStack {
                ScrollView {
                Text("Settings")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .padding(.vertical,40)
                
                    VStack(spacing: 20) {
                        
                        metricsButton
                        changeEmailButton
                        changePasswordButton
                        resetPlansButton
                        resetActivitiesButton
                        resetEverythingButton
                        deleteAccountButton
                        logoutButton
                        
                        
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            print("Nige: measure in Settings = \(measure ?? "No measure")")
            if measure == Measure.kilometers.rawValue {
                isKilometers = true
            } else {
                isKilometers = false
            }
        }
    }
}

extension SettingsView {
    private var metricsButton: some View {
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
    
    private var resetActivitiesButton: some View {
        
            Button {
                print("Nige: Show Alert")
            } label: {
                Text("Reset Activities")
                    .modifier(SettingsButtons())
            }
    }
    
    private var resetPlansButton: some View {
        Button {
            print("Nige: Show Alert")
        } label: {
            Text("Reset Plans")
                .modifier(SettingsButtons())
                
                
        }
    }
    
    private var resetEverythingButton: some View {
        Button {
            print("Nige: Show Alert")
        } label: {
            Text("Reset Everything")
                .modifier(SettingsButtons())
        }
    }
    
    private var changeEmailButton: some View {
        Button {
            print("Nige: Show Alert")
        } label: {
            Text("Change Email")
                .modifier(SettingsButtons())
        }
    }
    
    private var changePasswordButton: some View {
        Button {
            print("Nige: Show Alert")
        } label: {
            Text("Change Password")
                .modifier(SettingsButtons())
        }
    }
    
    private var deleteAccountButton: some View {
        Button {
            print("Nige: Show Alert")
        } label: {
            Text("Delete Account")
                .modifier(SettingsButtons())
        }
    }
    
    private var logoutButton: some View {
        Button {
            print("Nige: Show Alert")
        } label: {
            Text("Log Out")
                .modifier(SettingsButtons())
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
