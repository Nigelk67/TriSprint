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
    var body: some View {
        HStack {
            Spacer()
            Button {
                print("Nige: Let's go button pressed")
            } label: {
                Text("Let's Go!")
                    .modifier(RedButton())
            }
            .padding(.top)
            .padding(.trailing)
        }
    }
}

struct CancelButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
            })
        }
    }
    
}

