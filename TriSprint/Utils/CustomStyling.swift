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
//                    .font(.footnote)
//                    .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
//                    .foregroundColor(Color.white)
//                    .background(Color.accentButton)
//                    .cornerRadius(40)

struct ReallySmallGreenButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12))
            .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
            .foregroundColor(Color.white)
            .background(Color.accentButton)
            .cornerRadius(40)
    }
}

struct SmallGreenButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
            .foregroundColor(Color.white)
            .background(Color.accentButton)
            .cornerRadius(40)
    }
}

struct RedButton: ViewModifier {
    @Binding var isSwim: Bool
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
            .foregroundColor(Color.white)
            .background(isSwim ? Color.gray.opacity(0.3) : Color.mainButton)
            .cornerRadius(20)
    }
}

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


