//
//  MainView.swift
//  TriSprint
//
//  Created by Nigel Karan on 13.11.21.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.mainButton)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.accentButton.opacity(0.5))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UITabBar.appearance().barTintColor = UIColor(Color.mainBackground)
        UITabBar.appearance().backgroundColor = UIColor(Color.mainBackground)
    }

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
