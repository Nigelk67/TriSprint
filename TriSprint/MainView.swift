//
//  MainView.swift
//  TriSprint
//
//  Created by Nigel Karan on 13.11.21.
//

import SwiftUI

struct MainView: View {
//    
//    init() {
//        UITabBar.appearance().backgroundColor = UIColor(Color.black)
//    }
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.mainButton)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.accentButton.opacity(0.5))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        
    }
    @AppStorage(AppStor.signedIn.rawValue) var isSignedIn = false
    @EnvironmentObject var loginVm: LoginViewModel
   
    var body: some View {
        
        if loginVm.signedIn {
            TabView {
                HomeView()
                    .tabItem {
                        Text("Progress")
                    }
                HomeNavView()
                    .tabItem {
                        Text("Home")
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
            LoginView()
        }
    }
       
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
