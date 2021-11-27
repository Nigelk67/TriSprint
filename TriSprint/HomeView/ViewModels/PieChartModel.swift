//
//  PieChartModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 25.11.21.
//

import SwiftUI

struct PieChartModel: View {
    
    @State private var show: Bool = false
    fileprivate var slices: [PieSlice] = []
    
    init(_ values: [(Color, Double)]) {
        slices = calculateSlices(from: values)
    }
    var body: some View {
        GeometryReader { reader in
            let halfWidth = (reader.size.width / 2)
            let halfHeight = (reader.size.height / 2)
            let radius = min(halfWidth, halfHeight)
            let center = CGPoint(x: halfWidth, y: halfHeight)
            ZStack(alignment: .center) {
              
                    ForEach(slices, id: \.self) { slice in
                        Path { path in
                            path.move(to: center)
                            path.addArc(center: center, radius: radius, startAngle: slice.start, endAngle: slice.end, clockwise: false)
                        }
                        .fill(slice.color)
                        .scaleEffect(self.show ? 1 : 0)
                        .animation(Animation.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.3).delay(0.03))
                    }
                    .onAppear {
                        self.show = true
                    }
                }
        }
    }
    
    private func calculateSlices(from inputValues: [(color: Color, value: Double)]) -> [PieSlice] {
        print("Nige: input vals = \(inputValues)")
        let sumOfAllValues = inputValues.reduce(0) { $0 + $1.value }
        
        guard sumOfAllValues > 0 else { return [] }
        let degreeForOneValue = 360.0 / sumOfAllValues
        var currentStartAngle = -90.0
        var slices = [PieSlice]()
        inputValues.forEach { inputValue in
            let endAngle = -degreeForOneValue * inputValue.value + currentStartAngle
            slices.append(PieSlice(start: Angle(degrees: currentStartAngle), end: Angle(degrees: endAngle), color: inputValue.color))
            currentStartAngle = endAngle
        }
        return slices
    }
}

private struct PieSlice: Hashable {
    var start: Angle
    var end: Angle
    var color: Color
}


struct PieChartModel_Previews: PreviewProvider {
    static var previews: some View {
        PieChartModel([(Color.accentButton, 30),(Color.gray,10)])
    }
}
