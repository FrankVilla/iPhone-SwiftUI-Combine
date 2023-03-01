//
//  Movie.swift
//  iPhone+SwiftUI+Combine
//
//  Created by KOVIGROUP on 01/03/2023.
//

import Foundation

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    let year: String
    let posterPath: String?
    
    var posterURL: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}
