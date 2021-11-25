//
//  NoPlansView.swift
//  TriSprint
//
//  Created by Nigel Karan on 16.11.21.
//

import SwiftUI

struct NoPlansView: View {
    
    var body: some View {
        
        VStack {
        Text("You have no training schedule :-(\n\nHead to 'Settings' to set up a new plan!")
            .foregroundColor(Color.mainText)
            .font(.title2)
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.accentButton.opacity(0.5))
            .cornerRadius(18)
            
        }.padding()
        
    }
}

struct NoPlansView_Previews: PreviewProvider {
    static var previews: some View {
        NoPlansView()
    }
}
