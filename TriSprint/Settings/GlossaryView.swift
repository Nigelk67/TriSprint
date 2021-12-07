//
//  GlossaryView.swift
//  TriSprint
//
//  Created by Nigel Karan on 06.12.21.
//

import SwiftUI

struct GlossaryView: View {
    
    @StateObject var glossaryVm = GlossaryViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ZStack {
            Color.mainBackground
            VStack {
                HStack(alignment: .lastTextBaseline) {
                    CancelButton(presentationMode: presentationMode)
                    Text("Glossary")
                        .foregroundColor(Color.white)
                        .font(.system(size: 32, weight: .medium, design: .rounded))
                        .padding()

                }
                
                List(glossaryVm.glossaryItems) { item in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(item.term)
                            .foregroundColor(Color.mainText)
                            .italic()
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            
                        Text(item.explanation)
                            .foregroundColor(Color.mainText)
                            .font(.system(size: 20, weight: .light, design: .rounded))
                    }
                }
                .listStyle(.inset)
                .foregroundColor(.white)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.mainBackground)
            }
            .navigationBarHidden(true)
        }
        //.ignoresSafeArea()
    }
}

struct GlossaryView_Previews: PreviewProvider {
    static var previews: some View {
        GlossaryView()
    }
}
