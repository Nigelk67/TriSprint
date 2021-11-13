//
//  HomeView.swift
//  TriSprint
//
//  Created by Nigel Karan on 12.11.21.
//

import SwiftUI

struct HomeView: View {
    @State private var nextScreen = false
    @ObservedObject var trainingVm = TrainingPlanArrayViewModel()
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
            print("Nige: training plan = \(trainingVm.trainingPlan)")
        } label: {
            Text("Print Plan")
                .font(.system(size: 32, weight: .semibold, design: .rounded))
        }
        Spacer()
        .fullScreenCover(isPresented: $nextScreen) {
            FirstTriathlonView()
        }
    }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
