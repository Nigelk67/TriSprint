//
//  MainView.swift
//  TriSprint
//
//  Created by Nigel Karan on 13.11.21.
//

import SwiftUI

struct MainView: View {
    

    //@AppStorage(AppStor.signedIn.rawValue) var isSignedIn = false
    @EnvironmentObject var loginVm: LoginViewModel
   
    var body: some View {
        
        if loginVm.signedIn {
            if loginVm.onBoarded {
                TabView {
                    HomeView()
                        .tabItem {
                            Image(systemName: "waveform.path.ecg")
                            Text("Progress")
                        }
                    TrainingScheduleView()
                        .tabItem {
                            Image(systemName: "square.and.pencil")
                            Text("Schedule")
                        }
                    ActivityView()
                        .tabItem {
                            Image(systemName: "timer")
                            Text("Activity")
                        }
                    SettingsView()
                        .tabItem {
                            Image(systemName: "slider.vertical.3")
                            Text("Settings")
                        }
                    
                }.accentColor(Color.mainButton)
                
            } else {
                PersonaliseView()
                    .transition(.slide)
            }
            
        } else {
            LoginView()
                .transition(.slide)
        }
    }
       
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
