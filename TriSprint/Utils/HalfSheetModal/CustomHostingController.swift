//
//  CustomHostingController.swift
//  TriSprint
//
//  Created by Nigel Karan on 04.12.21.
//

import SwiftUI

class CustomHostingController<Content: View>: UIHostingController<Content> {
    
    override func viewDidLoad() {
        
        view.backgroundColor = .clear
        
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            presentationController.prefersGrabberVisible = true
        }
    }
}
