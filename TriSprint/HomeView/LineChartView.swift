//
//  LineChartView.swift
//  TriSprint
//
//  Created by Nigel Karan on 30.11.21.
//

import SwiftUI

struct LineChartView: View {
    let arrayForLine: [Double]
    let header: String
    private let maxY: Double
    private let minY: Double
    @State private var percentageAnimate: CGFloat = 0
    private let chartHeight: Double = 80
    private let chartWidth: Double = 150
    
    init(dataForArray: [Double], chartHeader: String) {
        arrayForLine = dataForArray
        header = chartHeader
        maxY = arrayForLine.max() ?? 0
        minY = arrayForLine.min() ?? 0
    }
    
    var body: some View {
        
        VStack {
            Text(header)
                .foregroundColor(Color.mainText)
                .font(.system(size: 14, weight: .regular, design: .rounded))
            chartView
                .frame(width: chartWidth, height: chartHeight)
                .background(chartBackground)
                .overlay(chartYAxis,alignment: .leading)
        }
        
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.linear(duration: 2.0)) {
                    percentageAnimate = 1.0
                }
            }
        }
        .frame(height: chartHeight * 2)
        .background(Color.mainBackground.opacity(0.7))
        .cornerRadius(10)
    }
    
}


extension LineChartView {
    
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in arrayForLine.indices {
                    let xPosition = (geometry.size.width / 1) / CGFloat(arrayForLine.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((arrayForLine[index] - minY) / yAxis)) * geometry.size.height
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentageAnimate)
            .stroke(Color.accentButton, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: Color.accentButton, radius: 3, x: 2, y: 4)
            .shadow(color: Color.accentButton.opacity(0.3), radius: 3, x: 2, y: 8)

        }
        .padding()
        
       
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(String(format: "%.2f", maxY))
                .foregroundColor(Color.mainText)
                .font(.system(size: 12, weight: .light, design: .rounded))
            Spacer()
            Text(String(format: "%.2f", ((maxY + minY) / 2)))
                .foregroundColor(Color.mainText)
                .font(.system(size: 12, weight: .light, design: .rounded))
            Spacer()
            Text(String(format: "%.2f", minY))
                .foregroundColor(Color.mainText)
                .font(.system(size: 12, weight: .light, design: .rounded))
        }
        .padding(.leading,20)
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView(dataForArray: [0], chartHeader: "")
    }
}
