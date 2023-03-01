//
//  ContentView.swift
//  iPhone+SwiftUI+Combine
//
//  Created by KOVIGROUP on 01/03/2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        MovieCollectionView(movies: viewModel.movies)
            .onAppear(perform: viewModel.getMovies)
            .onReceive(viewModel.$movies) { movies in
                print("Received movies: \(movies)")
            }
    }
}


