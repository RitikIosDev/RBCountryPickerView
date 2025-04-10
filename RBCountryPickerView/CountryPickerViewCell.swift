//
//  CountryPickerViewCell.swift
//  RBCountryPickerView
//
//  Created by Ritik Bunkar on 28/03/25.
//

import SwiftUI
import RBCountryPickerView

struct CountryPickerViewCell: View {
    
    let cellTitle: String
    let cellImage: String?
    let cellSubtitle: String?
    
    init(cellTitle: String, cellImage: String? = nil, cellSubtitle: String? = nil) {
        self.cellTitle = cellTitle
        self.cellImage = cellImage
        self.cellSubtitle = cellSubtitle
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                if let cellImage = cellImage {
                    Text(cellImage)
                        .foregroundColor(Color.orange)
                        .font(.system(size: 20))
                }

                Text(cellTitle)
                    .foregroundColor(Color.orange)
                    .font(.system(size: 20))


                Spacer()
                
                if let cellSubtitle = cellSubtitle {
                    Text(cellSubtitle)
                        .foregroundColor(.blue)
                        .font(.system(size: 20, weight: .semibold))
                }
            }
            .padding(.vertical, 12)
            Divider()
                .foregroundColor(.blue)
        }
    }
}
