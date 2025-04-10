//
//  ContentView.swift
//  RBCountryPickerView
//
//  Created by Ritik Bunkar on 27/03/25.
//

import SwiftUI
import RBCountryPickerView

struct CountryPicker: View {
    
    let allCountries: [ModelCountry]
    @Binding var selectedCountry: ModelCountry?
    @Binding var isPresent: Bool
    @State var searchCountry: String = ""
    @State var searchBarLoader: Bool = false
    @State private var filteredCountries: [ModelCountry]?

    var body: some View {
        VStack(spacing: 16) {
            Text("Select a Country")
                .foregroundColor(Color.orange)
                .font(.system(size: 20))
                .padding(.top, 30)
            
            SearchBarView(value: $searchCountry, isAnimating: searchBarLoader, color: .white)
                .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 140 : 100)
                .padding(.horizontal, -8)
            
            ScrollView {
                ForEach(filteredCountries ?? allCountries, id: \.iso2) { country in
                    Button {
                        selectedCountry = country
                        isPresent = false
                    } label: {
                        CountryPickerViewCell(cellTitle: country.name, cellImage: country.emoji, cellSubtitle: country.iso2)
                            .padding(.horizontal, 24)
                    }
                }
            }
        }
        .onAppear {
            print("allCountries: ", allCountries)
            filteredCountries = allCountries // Initialize filteredCountries on appear
        }
        .onChange(of: searchCountry) { newValue in
            filteredCountries = filterCountry()
        }

    }
    
    private func filterCountry() -> [ModelCountry] {
        if searchCountry.isEmpty {
            return allCountries
        } else {
            return allCountries.filter { country in
                country.name.lowercased().contains(searchCountry.lowercased())
            }
        }
    }
}
