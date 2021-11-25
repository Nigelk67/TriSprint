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
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.accentButton)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        
    }
    
    var body: some View {
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
        }.accentColor(Color.mainButton)
            
    
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
