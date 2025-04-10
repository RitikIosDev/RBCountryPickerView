//
//  CountryPickerViewModel.swift
//  RBCountryPickerView
//
//  Created by Ritik Bunkar on 28/03/25.
//

import Foundation
import RBCountryPickerView

class CountryPickerViewModel: ObservableObject {
    
    @Published var allCountries: [ModelCountry]?
    @Published var selectedCountry: ModelCountry?
    @Published var selectedState: ModelState?
    @Published var presentStatePickerView: Bool = false
    @Published var checkInDate = Date()
    
    @Published var showToast: Bool = false
    var toastMessage: String = ""
    
    let minimumDate: PartialRangeThrough<Date>
    
    init(minAge: Int = 18) {
        let minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        self.minimumDate = ...minimumDate!
        fetchCountryData()
    }
    
    private func fetchCountryData() {
        let bundle = Bundle(for: RBCountryPickerResourceFinder.self)

        if let url = bundle.url(forResource: "countries+states", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let countriesData = try decoder.decode([ModelCountry].self, from: data)
                allCountries = countriesData
            } catch {
                print(" Error decoding JSON: \(error)")
            }
        } else {
            print(" countries+states.json not found in bundle")
        }
    }


    
    
    func showAlert(message: String) {
        toastMessage = message
        showToast.toggle()
    }
}
