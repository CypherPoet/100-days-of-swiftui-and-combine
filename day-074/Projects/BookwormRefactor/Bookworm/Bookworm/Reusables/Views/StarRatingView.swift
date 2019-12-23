//
//  StarRatingView.swift
//  Bookworm
//
//  Created by CypherPoet on 11/17/19.
// ✌️
//

import SwiftUI



struct StarRatingView: View {
    @Binding var rating: Int
    
    var maxRating: Int

    var offImage: Image
    var onImage: Image

    var offColor: Color
    var onColor: Color
    
    
    init(
        rating: Binding<Int>,
        maxRating: Int = 5,
        offImage: Image = Image(systemName: "star.fill"),
        onImage: Image = Image(systemName: "star.fill"),
        offColor: Color = .gray,
        onColor: Color = .yellow
    ) {
        self._rating = rating
        self.maxRating = maxRating
        self.offImage = offImage
        self.onImage = onImage
        self.offColor = offColor
        self.onColor = onColor
    }
}


// MARK: - Body
extension StarRatingView {

    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { number in
                self.image(for: number)
                    .foregroundColor(self.color(for: number))
                    .onTapGesture {
                        self.rating = number
                    }
                    .accessibility(
                        label: Text(self.label(for: number))
                    )
                    .accessibility(removeTraits: .isImage)
                    .accessibility(addTraits: self.accessibilityTraits(for: number))
            }
        }
    }
}


// MARK: - Computeds
extension StarRatingView {
}


// MARK: - Private Helpers
private extension StarRatingView {
    
    func image(for number: Int) -> Image {
        number < rating ? offImage : onImage
    }
    
    
    func color(for number: Int) -> Color {
        number <= rating ? onColor : offColor
    }
    
    
    func label(for number: Int) -> String {
        "\(number == 1 ? "1 star" : "\(number) stars") out of \(maxRating)"
    }
    
    
    func accessibilityTraits(for number: Int) -> AccessibilityTraits {
        number > rating ? [.isButton] : [.isButton, .isSelected]
    }
}


// MARK: - View Variables
extension StarRatingView {
}



// MARK: - Preview
struct StarRatingView_Previews: PreviewProvider {

    static var previews: some View {
        StarRatingView(
            rating: .constant(4)
        )
    }
}
