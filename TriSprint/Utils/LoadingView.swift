//
//  LoadingView.swift
//  TriSprint
//
//  Created by Nigel Karan on 19.11.21.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        ZStack {
            Color("MainText")
                .frame(width: 200, height: 200, alignment: .center)
                .cornerRadius(100)
                .opacity(0.6)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.mainButton))
                .scaleEffect(3)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
