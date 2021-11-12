//
//  CustomStyling.swift
//  TriSprint
//
//  Created by Nigel Karan on 12.11.21.
//

import Foundation
import SwiftUI

//struct GreenButton: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding()
//            .font(.system(size: 40, weight: .regular, design: .default))
//            .foregroundColor(Color.white)
//            .frame(width: 350, height: 60, alignment: .center)
//            .background(Color("FeBlue"))
//            .scaleEffect(configuration.isPressed ? 1.1 : 1)
//            .cornerRadius(8)
//            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("FeBlue"), lineWidth: 1))
//
//    }
//}

struct GreenButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.accentButton)
            .border(.gray)
            .cornerRadius(3)
    }
}

