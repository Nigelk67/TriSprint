//
//  HomeNavView.swift
//  TriSprint
//
//  Created by Nigel Karan on 12.11.21.
//

import SwiftUI

struct HomeNavView: View {
    
    @State private var nextScreen = false
    @StateObject var coreDataVm = CoreDataViewModel()
    
    var body: some View {
        
        VStack {
            Spacer()
            Button {
                nextScreen.toggle()
            } label: {
                Text("Next Screen")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
            }
            Spacer()
            
            Button {
                for plan in coreDataVm.savedPlans {
                    coreDataVm.deletePlan(plan: plan)
                }
            } label: {
                Text("Delete All Plans")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
            }
            Spacer()
                .fullScreenCover(isPresented: $nextScreen) {
                    FirstTriathlonView()
                }
        }
    }
}

struct HomeNavView_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavView()
    }
}
