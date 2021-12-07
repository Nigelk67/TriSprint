//
//  GlossaryViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 07.12.21.
//

import SwiftUI

class GlossaryViewModel: ObservableObject {
    @Published var glossaryItems: [Glossary] = Glossary.glossaryItems
}
