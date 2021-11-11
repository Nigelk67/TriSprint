//
//  PersonaliseView.swift
//  TriSprint
//
//  Created by Nigel Karan on 11.11.21.
//

import SwiftUI

struct PersonaliseView: View {
    
    var body: some View {
        ZStack {
            Image("Photo_swim")
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
            Color((.systemBackground))
                .ignoresSafeArea()
                .opacity(0.8)
        VStack {
            Text("Personalise Your Plan")
                .foregroundColor(Color.accentButton).font(.system(size: 32, weight: .semibold, design: .default))
                .padding(.vertical)
        Spacer()
        }
        }
    }
}

struct PersonaliseView_Previews: PreviewProvider {
    static var previews: some View {
        PersonaliseView()
    }
}
