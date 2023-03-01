//
//  ContentViewModel.swift
//  iPhone+SwiftUI+Combine
//
//  Created by KOVIGROUP on 02/03/2023.
//

import Foundation
import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    private let movieService = MovieService()
    
    @Published var movies: [Movie] = []
    
    func getMovies() {
        movieService.getMovies(by: 28)
            .map { models -> [Movie] in
                return models.map { model in
                    return Movie(
                        title: model.title!,
                        category: "Category",
                        year: "2022",
                        posterPath: "https://image.tmdb.org/t/p/w500\(model.poster_path ?? "")"
                    )
                }
            }
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("API Error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }
            .store(in: &cancellables)
    }
}
