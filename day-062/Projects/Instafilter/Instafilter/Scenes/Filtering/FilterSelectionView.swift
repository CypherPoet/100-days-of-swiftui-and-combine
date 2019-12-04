//
//  FilterSelectionView.swift
//  Instafilter
//
//  Created by CypherPoet on 12/2/19.
// ✌️
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins


struct FilterSelectionView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    /// available filters
    let options: [CoreImageFilter]
    
    let onSelect: ((CoreImageFilter) -> Void)
}


// MARK: - Body
extension FilterSelectionView {

    var body: some View {
        List {
            ForEach(options) { filterOption in
                Button(action: {
                    self.onSelect(filterOption)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text(filterOption.displayName)
                }
            }
        }
    }
}


// MARK: - Computeds
extension FilterSelectionView {


}


// MARK: - View Variables
extension FilterSelectionView {


}



// MARK: - Preview
struct FilterSelectionView_Previews: PreviewProvider {

    static var previews: some View {
        FilterSelectionView(
            options: [
                CoreImageFilter.bokehBlur,
                CoreImageFilter.sepiaTone,
            ],
            onSelect: { _ in }
        )
    }
}
