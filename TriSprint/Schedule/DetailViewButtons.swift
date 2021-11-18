//
//  DetailViewButtons.swift
//  TriSprint
//
//  Created by Nigel Karan on 17.11.21.
//

import SwiftUI

struct EnterManuallyButton: View {
    var body: some View {
        HStack {
            Spacer()
            Button {
                print("Nige: Enter Manually")
            } label: {
                Text("Enter Manually")
                    .modifier(SmallGreenButton())
            }
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
    @State var isDisabled: Bool = true
    @Binding var showMapView: Bool
    var body: some View {
        HStack {
            Spacer()
            Button {
                print("LetsGo button showMapView = \(showMapView)")
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
        .padding(.leading,10)
        .padding(.bottom,20)
        .padding(.top,20)
    }
    
}

