//
//  BookDetailsView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

struct BookDetailsView: View {
    @State private var dummyRate = 4
    
    var body: some View {
        GeometryReader { geo in
            List {
                Section {
                    VStack {
                        BookCover(width: 135, height: 180, customText: "T")
                        .padding(.bottom, 5)
                        
                        VStack {
                            Description(
                                title: "Title Test",
                                description: "Author Test",
                                primaryFont: .title,
                                secondaryFont: .headline
                            )
                        }
                    }
                }
                .frame(width: geo.size.width)
                .listRowBackground(Color(CGColor(red: 240, green: 240, blue: 246, alpha: 0)))
                
                
                Section("More Information") {
                    InformationLabel(
                        informationTitle: "Release Date:",
                        informationDescription: "21/01/2024"
                    )
                    
                    InformationLabel(
                        informationTitle: "Genre:",
                        informationDescription: "Fantasy"
                    )
                    
                    HStack {
                        Text("Rating:")
                            .font(.body)
                            .bold()
                        Spacer()
                        RatingStars(rating: $dummyRate)
                    }
                }
                
                Section("Review") {
                    Text("Review here")
                }
                
                Section {
                    DestructiveButton(label: "Delete Book") { }
                }
            }
            .navigationTitle("Book Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                EditButton(label: "Edit") { }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookDetailsView()
    }
}
