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
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Text("Home")
                }
            TrainingScheduleView()
                .tabItem {
                    Text("Schedule")
                }
        }.accentColor(Color.mainButton)
            
    
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
