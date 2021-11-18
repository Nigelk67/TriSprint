//
//  UnitConverter.swift
//  TriSprint
//
//  Created by Nigel Karan on 18.11.21.
//

import Foundation

class UnitConverterInverse: UnitConverter {
    
    private var coefficient: Double
    
    init(coefficient: Double) {
        self.coefficient = coefficient
    }
    
    override func baseUnitValue(fromValue value: Double) -> Double {
        return value / coefficient
    }
    
    override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
        return baseUnitValue / coefficient
    }
}

class UnitConverterPace: UnitConverter {
  private let coefficient: Double
  
  init(coefficient: Double) {
    self.coefficient = coefficient
  }
  
  override func baseUnitValue(fromValue value: Double) -> Double {
    return reciprocal(value * coefficient)
  }
  
  override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
    return reciprocal(baseUnitValue * coefficient)
  }
  
  private func reciprocal(_ value: Double) -> Double {
    guard value != 0 else { return 0 }
    return 1.0 / value
  }
  
}
