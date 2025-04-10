//
//  CountryPickerView.swift
//  RBCountryPickerView
//
//  Created by Ritik Bunkar on 28/03/25.
//

import SwiftUI
import RBCountryPickerView
// File: RBCountryPickerResourceFinder.swift




public struct RBCountryPickerView: View {
    @State private var isPresentingCountrySheet = false
    @State private var isPresentingStateSheet = false
    @StateObject private var viewModel = CountryPickerViewModel()
    @State private var isCountryValid = true
    @State private var isStateValid = true
    @State private var country: String = ""
    @State private var countryCode: String = ""
    @State private var state: String = ""
    @State private var stateCode: String = ""
    
    let orientation: PickerOrientation
    let spacing: CGFloat

    public init(orientation: PickerOrientation? = .horizontal, spacing: CGFloat = 20) {
        self.orientation = orientation ?? .horizontal
        self.spacing = spacing
    }

    public var body: some View {
        switch orientation {
        case .horizontal:
            HStack(spacing: 20) {
                countryPicker
                statePicker
            }
            .padding()
            
            case .vertical:
            VStack(spacing: 20) {
                countryPicker
                statePicker
            }
            .padding()
        }
    }

    var countryPicker: some View {
        Button(action: { isPresentingCountrySheet.toggle() }) {
            HStack {
                Text(country.isEmpty ? "Select Country" : country)
                    .foregroundColor(country.isEmpty ? .gray : .primary)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(width: 180, height: 50)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
        }
        .sheet(isPresented: $isPresentingCountrySheet) {
            if let allCountries = viewModel.allCountries {
                CountryPicker(allCountries: allCountries, selectedCountry: $viewModel.selectedCountry, isPresent: $isPresentingCountrySheet)
            }
        }
        .onChange(of: viewModel.selectedCountry) { value in
            country = value?.name ?? ""
            countryCode = value?.iso2 ?? ""
            state = ""
            stateCode = ""
            isCountryValid = true
        }
    }

    var statePicker: some View {
        Button(action: {
            if !country.isEmpty {
                isPresentingStateSheet.toggle()
            } else {
                isCountryValid = false
                viewModel.showAlert(message: "Select country first")
            }
        }) {
            HStack {
                Text(state.isEmpty ? "Select State" : state)
                    .foregroundColor(state.isEmpty ? .gray : .primary)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(width: 180, height: 50)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
        }
        .sheet(isPresented: $isPresentingStateSheet) {
            if let selectedCountry = viewModel.selectedCountry {
                StatePicker(selectedCountry: selectedCountry, selectedState: $viewModel.selectedState, isPresent: $isPresentingStateSheet)
            }
        }
        .onChange(of: viewModel.selectedState) { value in
            state = value?.name ?? ""
            stateCode = value?.state_code ?? ""
            isStateValid = true
        }
    }
}
