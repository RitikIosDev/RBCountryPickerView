//
//  SearchBarView.swift
//  RBCountryPickerView
//
//  Created by Ritik Bunkar on 28/03/25.
//

import SwiftUI
import RBCountryPickerView


struct SearchBarView: View {
    
    @Binding var value: String
    let isAnimating: Bool
    @State var color = Color.blue

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 24 : 20,
                       height: UIDevice.current.userInterfaceIdiom == .pad ? 24 : 20)
                .padding(.leading, 20)
                .foregroundColor(Color.gray)
            
            TextField("Search", text: $value)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 16, weight: .regular))
                .disabled(isAnimating)
                .autocorrectionDisabled(true)

            if isAnimating {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(Color.gray)
                    .padding(.trailing, 10)
            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: UIDevice.current.userInterfaceIdiom == .pad ? 98 : 56,
               alignment: .leading)
        .border(Color.green, width: 1)
        .background(color)
        .padding([.leading, .trailing], UIDevice.current.userInterfaceIdiom == .pad ? 36 : 24)
        .padding(.top, 24)
        
    }
}
