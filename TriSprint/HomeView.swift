//
//  HomeView.swift
//  TriSprint
//
//  Created by Nigel Karan on 12.11.21.
//

import SwiftUI

struct HomeView: View {
    @State private var nextScreen = false
    
    var body: some View {
        Button {
            nextScreen.toggle()
        } label: {
            Text("Next Screen")
                .font(.system(size: 32, weight: .semibold, design: .rounded))
        }
        .fullScreenCover(isPresented: $nextScreen) {
            FirstTriathlonView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
