//
//  RunBackground.swift
//  TriSprint
//
//  Created by Nigel Karan on 12.11.21.
//

import SwiftUI

struct RunBackground: View {
    var body: some View {
        ZStack {
        Image("Photo_run")
            .resizable()
            .ignoresSafeArea()
            .aspectRatio(contentMode: .fill)
        Color((.systemBackground))
            .ignoresSafeArea()
            .opacity(0.8)
    }
    }
}

struct RunBackground_Previews: PreviewProvider {
    static var previews: some View {
        RunBackground()
    }
}
