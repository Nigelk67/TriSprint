//
//  MailView.swift
//  TriSprint
//
//  Created by Nigel Karan on 08.12.21.
//

import SwiftUI

struct MailView: View {
    @State private var mailData = ComposeMailData(subject: "TriSprint Review", recipients: ["team@trihardapps.com"], message: "Type your message here")
    @State private var showMailView = false
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("We're sorry to hear you're not having a better experience with the TriSprint app.\n\nIt would really help us to improve the app if you could take a few minutes to let us know how we could improve your experience.")
                .foregroundColor(Color.mainText)
                .font(.system(size: 22, weight: .regular, design: .rounded))
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            Button {
                showMailView.toggle()
            } label: {
                Text("Send feedback")
                    .foregroundColor(Color.mainButton)
                    .font(.system(size: 22, weight: .regular, design: .rounded))
                    .padding()
            }
            .disabled(!MailViewWrapper.canSendMail)
            .sheet(isPresented: $showMailView) {
                MailViewWrapper(data: $mailData) { result in
                    print(result)
                }
            }
            Spacer()
        }
        
        
        
    }
}

struct MailView_Previews: PreviewProvider {
    static var previews: some View {
        MailView()
    }
}
