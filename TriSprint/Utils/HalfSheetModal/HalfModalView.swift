//
//  HalfModalView.swift
//  TriSprint
//
//  Created by Nigel Karan on 04.12.21.
//

import SwiftUI

struct HalfModalView: View {
    
    @State var mainText: String
    @State var boolForButton: Bool = false
    @State var buttonText: String = ""
    @State var boolState: Bool = false
    
    var body: some View {
        ZStack {
            Color.mainBackground
            VStack {
                Text(mainText)
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Button {
                    boolForButton.toggle()
                    print("Nige: boolForButton = \(boolForButton), boolState = \(boolState)")
                } label: {
                    Text(buttonText)
                        .foregroundColor(Color.mainButton)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}


struct HalfModalView_Previews: PreviewProvider {
    static var previews: some View {
        HalfModalView(mainText: "")
    }
}
