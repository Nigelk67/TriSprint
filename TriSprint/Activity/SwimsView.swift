//
//  SwimsView.swift
//  TriSprint
//
//  Created by Nigel Karan on 23.11.21.
//

import SwiftUI

struct SwimsView: View {
    @ObservedObject var activityVm = ActivityViewModel()
    let swim: Swim
    
    var body: some View {
        VStack() {
            HStack {
                Spacer()
                Text("\(activityVm.swimDateText)")
                Spacer()
            }
            .background(Color.accentButton.opacity(0.3))
            
            VStack(alignment: .center) {
                HStack {
                    Image(activityVm.imageName)
                        .padding()
                    
                    Spacer()
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Time: \(activityVm.swimTimeText)")
                        Text("Distance: \(activityVm.swimDistanceText)")
                        Text("Pace: \(activityVm.swimPaceText)")
                    }
                    .padding()
                    Spacer()
                }
            }
            .background(Color.accentButton)
            .cornerRadius(20)
        }
        .onAppear {
            activityVm.updateSwims(swim: swim)
            
        }
    }
                    
}

struct SwimsView_Previews: PreviewProvider {
    static var previews: some View {
        SwimsView(swim: Swim())
    }
}
