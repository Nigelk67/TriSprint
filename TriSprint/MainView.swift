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
                            Text("Progress")
                        }
                    TrainingScheduleView()
                        .tabItem {
                            Text("Schedule")
                        }
                    ActivityView()
                        .tabItem {
                            Text("Activity")
                        }
                    SettingsView()
                        .tabItem {
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
