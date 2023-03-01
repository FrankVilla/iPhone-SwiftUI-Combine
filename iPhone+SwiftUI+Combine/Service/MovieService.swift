//
//  MovieService.swift
//  iPhone+SwiftUI+Combine
//
//  Created by KOVIGROUP on 01/03/2023.
//

import Foundation
import Combine

enum APIError: Error {
    case badURL
    case decodingError
    case serverError
    case unknown
}

class MovieService {
    private let baseURL = "https://api.themoviedb.org/3/discover/movie"
    private let apiKey = "YOU API KEY"
    
    func getMovies(by genreId: Int) -> AnyPublisher<[Model], APIError> {
        guard let url = URL(string: "\(baseURL)?api_key=\(apiKey)&with_genres=\(genreId)") else {
            return Fail(error: APIError.badURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .mapError { error -> APIError in
                switch error {
                case is URLError:
                    return .serverError
                case is DecodingError:
                    return .decodingError
                default:
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
}

struct APIResponse: Codable {
    let results: [Model]
}





