//
//  PadsListView.swift
//  PadFinder
//
//  Created by CypherPoet on 1/26/20.
// ✌️
//

import SwiftUI


struct PadsListView<Destination: View> {
    @ObservedObject var viewModel: ViewModel
    let buildDestination: ((Pad) -> Destination)
}


// MARK: - View
extension PadsListView: View {

    var body: some View {
        List {
            Section(header: Text("Sorting").font(.headline)) {
                sortingPicker
                    .padding()
            }
            
            Section(header: Text("Filters").font(.headline)) {
                activityTypeFilterPicker
                    .padding()
            }
            
            ForEach(viewModel.displayedPads) { pad in
                NavigationLink(destination: self.buildDestination(pad)) {
                    HStack {
                        pad.padType.listItemImage
                        
                        VStack(alignment: .leading) {
                            Text(pad.name)
                                .foregroundColor(.primary)
                                .font(.headline)
                            
                            Text(pad.padType.displayName)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
}


// MARK: - Computeds
extension PadsListView {
}


// MARK: - View Variables
extension PadsListView {
    
    private var sortingPicker: some View {
        Picker("Sorting Mode", selection: $viewModel.sortingMode) {
            ForEach(ViewModel.SortMode.allCases) { sortMode in
                Text(sortMode.displayName).tag(sortMode)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    
    private var activityTypeFilterPicker: some View {
        VStack(alignment: .leading) {
            Text("Pad Activity Type").font(.headline)
            
            Picker("Pad Activity Type Filtering Mode", selection: $viewModel.activityTypeFilteringMode) {
                ForEach(ViewModel.ActivityTypeFilterMode.allCases) { filterMode in
                    Text(filterMode.displayName).tag(filterMode)
                }
            }
            .labelsHidden()
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}


// MARK: - Private Helpers
private extension PadsListView {
}



// MARK: - Preview
struct PadsListView_Previews: PreviewProvider {

    static var previews: some View {
        let store = PreviewData.AppStores.withPads

        return NavigationView {
            PadsListView(
                viewModel: .init(padsState: store.state.padsState),
                buildDestination: { _ in EmptyView() }
            )
            .navigationBarTitle("Launch Pads")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(store)
    }
}
