//
//  CustomStyling.swift
//  TriSprint
//
//  Created by Nigel Karan on 12.11.21.
//

import Foundation
import SwiftUI

struct StartButton: ButtonStyle {
    var hasStarted: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 100, height: 100)
            .background(hasStarted ? Color.gray : Color.green)
            .foregroundColor(Color.mainText)
            .clipShape(Circle())
    }
}


struct ReallySmallGreenButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12))
            .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
            .foregroundColor(Color.white)
            .background(Color.accentButton)
            .cornerRadius(10)
    }
}

struct SmallGreenButtonWithBool: ViewModifier {
    @Binding var isDisabled: Bool
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
            .foregroundColor(Color.white)
            .background(isDisabled ? Color.gray.opacity(0.3) : Color.accentButton)
            .cornerRadius(10)
    }
}
struct SmallGreenButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
            .foregroundColor(Color.white)
            .background(Color.accentButton)
            .cornerRadius(10)
    }
}

struct SmallGreyButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
            .foregroundColor(Color.white)
            .background(Color.gray)
            .cornerRadius(10)
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
            .cornerRadius(10)
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

struct SettingsButtons: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.mainText)
            .font(.system(size: 24, weight: .regular, design: .rounded))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.accentButton.opacity(0.1))
    }
}

struct RegisterButtons: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .frame(width: 100, height: 40)
            .background(Color.mainButton)
            .cornerRadius(8)
    }
}


