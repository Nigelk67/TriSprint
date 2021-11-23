//
//  NumbersValidation.swift
//  TriSprint
//
//  Created by Nigel Karan on 23.11.21.
//

import SwiftUI
import Combine
// Text("\($enteredNumber, specifier: "%.2f")")
class NumbersOnly: ObservableObject {
    @Published var value = ""
    private var subCancellable: AnyCancellable!
    private var validCharSet = CharacterSet(charactersIn: "1234567890.")
    
    init() {
        subCancellable = $value.sink { val in
            if val.rangeOfCharacter(from: self.validCharSet.inverted) != nil {
                DispatchQueue.main.async {
                    self.value = String(self.value.unicodeScalars.filter {
                        self.validCharSet.contains($0)
                    })
                }
            }
        }
    }
    deinit {
        subCancellable.cancel()
    }
//        didSet {
//            let filtered = value.filter { $0.isNumber }
//            if value != filtered {
//                value = filtered
//            }
//        }
    
}
