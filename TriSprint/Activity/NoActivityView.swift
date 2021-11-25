//
//  NoActivityView.swift
//  TriSprint
//
//  Created by Nigel Karan on 25.11.21.
//

import SwiftUI

struct NoActivityView: View {
    var body: some View {
        VStack {
        Text("You have no activities. Time to start!")
            .foregroundColor(Color.mainText)
            .font(.title2)
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.accentButton.opacity(0.5))
            .cornerRadius(18)
            
        }.padding()
    }
}

struct NoActivityView_Previews: PreviewProvider {
    static var previews: some View {
        NoActivityView()
    }
}
