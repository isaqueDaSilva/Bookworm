//
//  DetailViewModel.swift
//  Bookworms
//
//  Created by Isaque da Silva on 26/08/23.
//

import Foundation

extension DetailsView {
    class DetailViewModel: ObservableObject {
        @Published var deleteCurrentBookAlert = false
        
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }
    }
}
