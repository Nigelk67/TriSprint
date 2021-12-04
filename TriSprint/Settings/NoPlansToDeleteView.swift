//
//  NoPlansToDeleteView.swift
//  TriSprint
//
//  Created by Nigel Karan on 04.12.21.
//

import SwiftUI

struct NoPlansToDeleteView: View {
    
    var body: some View {
        ZStack {
            VStack {
                Text("You have no plans to delete")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 24, weight: .regular, design: .rounded))
                    .multilineTextAlignment(.center)
                    Spacer()
                    Button {
                        print("Go to Onboarding")
                    } label: {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            
                    }
                    Button {
                        print("Go to Onboarding")
                    } label: {
                        Text("Set Up Training Plan")
                            .frame(width: 200, height: 50, alignment: .center)
                            .modifier(RegisterButtons())
                    }
                
                
            }
            .padding()
            .background(Color.accentButton)
            .opacity(0.95)
            .cornerRadius(10)
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(width: 300, height: 100)
    }
}

struct NoPlansToDeleteView_Previews: PreviewProvider {
    static var previews: some View {
        NoPlansToDeleteView()
    }
}
