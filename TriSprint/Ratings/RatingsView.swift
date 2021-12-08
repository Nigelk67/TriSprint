//
//  RatingsView.swift
//  TriSprint
//
//  Created by Nigel Karan on 07.12.21.
//

import SwiftUI

struct RatingsView: View {
    @Binding var rating: Int
    var label = "How are you finding TriSprint so far?"
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    let appStoreReviewUrl = "https://apps.apple.com/app/id*******?action=write-review"
    @State private var showMailView = false
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ZStack {
            Color.mainBackground
            VStack {
                CancelButton(presentationMode: presentationMode)
                    .padding(.top,30)
                    .padding(.leading,10)
                    .padding(.bottom,60)
                
                Text(label)
                    .foregroundColor(.white)
                    .font(.system(size: 26, weight: .medium, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.bottom,40)
                
                ratingStarsView
                
                Spacer()
                
                Button {
                    if rating == 4 || rating == 5 {
                        goToAppStoreReview()
                    } else {
                        showMailView.toggle()
                    }
                } label: {
                    Text("Submit")
                        .modifier(RegisterButtons())
                }
                Spacer()
                NavigationLink(destination: MailView(), isActive: $showMailView) { EmptyView() }
            }
            .navigationBarHidden(true)
            .navigationTitle("")
        }
        .ignoresSafeArea()
    }
    
    
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    func goToAppStoreReview() {
        guard let writeReviewUrl = URL(string: appStoreReviewUrl) else { fatalError("Expected a valid URL")}
        UIApplication.shared.open(writeReviewUrl, options: [:], completionHandler: nil)
    }
    
    private var ratingStarsView: some View {
        HStack {
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .resizable()
                    .foregroundColor(number > rating ? offColor : onColor)
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = number
                        }
                        
                    }
            }
        }
    }
}

struct RatingsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingsView(rating: .constant(3))
    }
}
