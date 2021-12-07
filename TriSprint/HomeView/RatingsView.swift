//
//  RatingsView.swift
//  TriSprint
//
//  Created by Nigel Karan on 07.12.21.
//

import SwiftUI

struct RatingsView: View {
    @Binding var rating: Int
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    let appStoreReviewUrl = "https://apps.apple.com/app/id*******?action=write-review"
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
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
}

struct RatingsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingsView(rating: .constant(3))
    }
}
