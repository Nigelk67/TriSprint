//
//  DetailViewButtons.swift
//  TriSprint
//
//  Created by Nigel Karan on 17.11.21.
//

import SwiftUI

struct EnterManuallyButton: View {
    @Binding var isDisabled: Bool
    @Binding var showManualEnterView: Bool
    var body: some View {
        HStack {
            Spacer()
            Button {
                showManualEnterView.toggle()
            } label: {
                Text("Enter Manually")
                    .modifier(SmallGreenButtonWithBool(isDisabled: $isDisabled))
            }
            .disabled(isDisabled ? true : false)
            .padding(.top)
            .padding(.trailing)
        }
    }
}

struct SkipButton: View {
    var body: some View {
        HStack {
            Button {
                print("Nige: Skip button pressed")
            } label: {
                Text("Skip Session")
                    .modifier(ReallySmallGreenButton())
            }
            .padding(.top)
            .padding(.leading)
            Spacer()
        }
    }
}
struct LetsGoButton: View {
    @Binding var isDisabled: Bool
    @Binding var showMapView: Bool
    var body: some View {
        HStack {
            Spacer()
            Button {
                showMapView.toggle()
            } label: {
                Text("Let's Go!")
                    .modifier(RedButton(isSwim: $isDisabled))
            }
            .disabled(isDisabled ? true : false)
            .padding(.top)
            .padding(.trailing)
        }
    }
}

struct CancelButton: View {
    var presentationMode : Binding<PresentationMode>
    var body: some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 34))
                    .foregroundColor(Color.mainButton)
            })
            Spacer()
        }
        .padding(.leading,20)
        .padding(.bottom,10)
        .padding(.top,20)
    }
    
}

