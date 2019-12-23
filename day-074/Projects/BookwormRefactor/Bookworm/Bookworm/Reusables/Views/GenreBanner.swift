//
//  GenreBanner.swift
//  Bookworm
//
//  Created by CypherPoet on 11/18/19.
// ✌️
//

import SwiftUI


struct GenreBanner: View {
    let genre: Book.Genre
    let container: GeometryProxy
}


// MARK: - Body
extension GenreBanner {

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            bannerBackground
            bannerTitle
        }
    }
}


// MARK: - View Variables
extension GenreBanner {
    
    private var bannerBackground: some View {
        Image(genre.imageName)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: container.size.width)
    }
    
    private var bannerTitle: some View {
        Text(genre.displayValue.uppercased())
            .font(.caption)
            .fontWeight(.black)
            .padding(8)
            .background(Color.black.opacity(0.75))
            .clipShape(Capsule())
            .offset(x: -5, y: -5)
            .foregroundColor(Color.white)
    }
}



// MARK: - Preview
struct GenreBanner_Previews: PreviewProvider {

    static var previews: some View {
        GeometryReader { geometry in
            GenreBanner(
                genre: .art,
                container: geometry
            )
        }
    }
}
