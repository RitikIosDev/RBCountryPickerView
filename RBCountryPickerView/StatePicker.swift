//
//  StatePicker.swift
//  RBCountryPickerView
//
//  Created by Ritik Bunkar on 28/03/25.
//

import SwiftUI
import RBCountryPickerView


struct StatePicker: View {
    
    let selectedCountry: ModelCountry
    @Binding var selectedState: ModelState?
    @Binding var isPresent: Bool
    @State var searchState: String = ""
    @State var searchBarLoader: Bool = false
    @State private var filteredState: [ModelState]?

    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading) {
                Text("Select a State")
                    .foregroundColor(.orange)
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 20))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 30)

                SearchBarView(value: $searchState, isAnimating: searchBarLoader, color: .white)
                    .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 140 : 100)
                    .padding(.horizontal, -8)
            }

            ScrollView {
                ForEach(filteredState ?? selectedCountry.states , id: \.id) { state in
                    Button {
                        selectedState = state
                        isPresent = false
                    } label: {
                        CountryPickerViewCell(cellTitle: state.name)
                            .padding(.horizontal, 24)
                    }
                }
            }
        }
        .onAppear {
            filteredState = getStates()
        }
        .onChange(of: searchState) { newValue in
            filteredState = filterStates()
        }
    }
    private func getStates() -> [ModelState] {
        if selectedCountry.name == "United States" {
            return selectedCountry.states.filter { state in
                state.type?.lowercased().contains("state") ?? false
            }
        } else {
            return selectedCountry.states
        }
    }
    
    private func filterStates() -> [ModelState] {
        if searchState.isEmpty {
            return getStates()
        } else {
            return getStates().filter { state in
                state.name.lowercased().contains(searchState.lowercased())
            }
        }
    }
}
