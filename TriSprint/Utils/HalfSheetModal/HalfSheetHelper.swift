//
//  HalfSheetHelper.swift
//  TriSprint
//
//  Created by Nigel Karan on 04.12.21.
//

import SwiftUI

extension View {
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>,@ViewBuilder sheetView: @escaping ()->SheetView, onEnd: @escaping ()->()) -> some View {
        return self
            .background(HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet, onEnd: onEnd))
    }
}

struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    var sheetView: SheetView
    @Binding var showSheet: Bool
    
    var onEnd: () -> ()
    let controller = UIViewController()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if showSheet {
            let sheetController = CustomHostingController(rootView: sheetView)
            sheetController.presentationController?.delegate = context.coordinator
            
            uiViewController.present(sheetController, animated: true)
        } else {
            uiViewController.dismiss(animated: true)
        }
    }
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        
        var parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper) {
            self.parent = parent
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
            parent.onEnd()
        }
    }
}

