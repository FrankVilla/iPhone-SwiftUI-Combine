//
//  MovieCollectionView.swift
//  iPhone+SwiftUI+Combine
//
//  Created by KOVIGROUP on 01/03/2023.
//
import Foundation
import SwiftUI

struct MovieCollectionView: UIViewRepresentable {
    var movies: [Movie]
    
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView.dataSource = context.coordinator
        return collectionView
    }
    
    func updateUIView(_ collectionView: UICollectionView, context: Context) {
        context.coordinator.movies = movies
        collectionView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(movies: movies)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 360)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 5
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }
    
    class Coordinator: NSObject, UICollectionViewDataSource {
        var movies: [Movie]
        
        init(movies: [Movie]) {
            self.movies = movies
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return movies.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
            let movie = movies[indexPath.row]
            cell.titleLabel.text = movie.title
            cell.categoryLabel.text = movie.category
            cell.yearLabel.text = "\(movie.year)"
            cell.backgroundColor = .black
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            
            if let posterURL = movie.posterURL {
                URLSession.shared.dataTask(with: posterURL) { data, response, error in
                    guard let data = data, error == nil else {
                        return
                    }
                    DispatchQueue.main.async {
                        cell.posterImageView.image = UIImage(data: data)
                    }
                }.resume()
            }
            
            return cell
        }
    }
}
