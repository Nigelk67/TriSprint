//
//  Mail_Wrapper.swift
//  TriSprint
//
//  Created by Nigel Karan on 08.12.21.
//

import SwiftUI
import UIKit
import MessageUI

typealias MailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?

struct MailViewWrapper: UIViewControllerRepresentable {
   
    @Environment(\.presentationMode) var presentation
    @Binding var data: ComposeMailData
    let callback: MailViewCallback
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var presentation: PresentationMode
        @Binding var data: ComposeMailData
        let callback: MailViewCallback
        
        init(presentation: Binding<PresentationMode>, data: Binding<ComposeMailData>, callback: MailViewCallback) {
        _presentation = presentation
            _data = data
            self.callback = callback
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            
            if let error = error {
                callback?(.failure(error))
            } else {
                callback?(.success(result))
            }
            $presentation.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(presentation: presentation, data: $data, callback: callback)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailViewWrapper>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setSubject(data.subject)
        vc.setToRecipients(data.recipients)
        vc.setMessageBody(data.message, isHTML: false)
        vc.accessibilityElementDidLoseFocus()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailViewWrapper>) {
        
    }
    
    static var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
}
