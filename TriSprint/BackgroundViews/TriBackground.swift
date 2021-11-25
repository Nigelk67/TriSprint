//
//  TriBackground.swift
//  TriSprint
//
//  Created by Nigel Karan on 25.11.21.
//

import SwiftUI

struct TriBackground: View {
    var body: some View {
        ZStack {
            Image("Photo_TriStart")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            Color((.systemBackground))
                .ignoresSafeArea()
                .opacity(0.8)
        }
    }
}

struct TriBackground_Previews: PreviewProvider {
    static var previews: some View {
        TriBackground()
    }
}
