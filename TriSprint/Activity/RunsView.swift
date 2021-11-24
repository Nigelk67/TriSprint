//
//  RunsView.swift
//  TriSprint
//
//  Created by Nigel Karan on 23.11.21.
//

import SwiftUI

struct RunsView: View {
    
    @ObservedObject var activityVm = ActivityViewModel()
    let run: Run
    
    var body: some View {
        VStack() {
            HStack {
                Spacer()
                Text("\(activityVm.runDateText)")
                Spacer()
            }
            .background(Color.accentButton.opacity(0.3))
            
            VStack(alignment: .center) {
                HStack {
                    Image(activityVm.imageName)
                        .padding()
                    
                    Spacer()
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Time: \(activityVm.runTimeText)")
                        Text("Distance: \(activityVm.runDistanceText)")
                        Text("Speed: \(activityVm.runSpeedText)")
                        Text("Pace: \(activityVm.runPaceText)")
                    }
                    .padding()
                    Spacer()
                }
            }
            .background(Color.accentButton)
            .cornerRadius(20)
        }
        .onAppear {
            activityVm.updateRuns(run: run)
            
        }
    }
                    
}

struct RunsView_Previews: PreviewProvider {
    static var previews: some View {
        RunsView(run: Run())
    }
}
