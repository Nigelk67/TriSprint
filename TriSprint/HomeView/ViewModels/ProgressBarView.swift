//
//  ProgressBarView.swift
//  TriSprint
//
//  Created by Nigel Karan on 26.11.21.
//

import SwiftUI

struct ProgressBarView: View {
    @State var currentProgress: CGFloat
    @State var endProgress: CGFloat
    @State var barColor: Color
    @State var barOpacity: Double
    @State var progressBarColor: Color
    @State var progressBarOpacity: Double
    
    var body: some View {
        
        VStack {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(barColor.opacity(barOpacity))
                .frame(width: 150, height: 15)
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(progressBarColor.opacity(progressBarOpacity))
                .frame(width: 150*currentProgress, height: 15)
        }
        
        }
        .onAppear {
            startLoading()
            
        }
    }
    func startLoading() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
            withAnimation() {
                self.currentProgress += 0.05
                if self.currentProgress >= self.endProgress {
                    timer.invalidate()
                }
            }
        })
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(currentProgress: 0.0, endProgress: 0.6, barColor: .gray, barOpacity: 0.7, progressBarColor: .red, progressBarOpacity: 0.7)
    }
}
