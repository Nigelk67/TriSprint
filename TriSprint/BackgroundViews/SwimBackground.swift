//
//  SwimBackground.swift
//  TriSprint
//
//  Created by Nigel Karan on 12.11.21.
//

import SwiftUI

struct SwimBackground: View {
    var body: some View {
        ZStack {
        Image("Photo_swim")
            .resizable()
            .ignoresSafeArea()
            .aspectRatio(contentMode: .fill)
        Color((.systemBackground))
            .ignoresSafeArea()
            .opacity(0.8)
    }
    }
}

struct SwimBackground_Previews: PreviewProvider {
    static var previews: some View {
        SwimBackground()
    }
}
