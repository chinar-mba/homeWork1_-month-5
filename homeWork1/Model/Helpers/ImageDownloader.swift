//
//  ImageDownloader.swift
//  homeWork1
//
//  Created by Chinara on 6/20/23.
//

import UIKit


enum ImageDownloader {
    static func downloadImage(with url: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let url = URL(string: url)
        
        DispatchQueue.global(qos: .userInitiated).async {
            let imageData = try? Data(contentsOf: url!)
            guard let imageData else {
                return
            }
            let image = UIImage(data: imageData)
            completion(.success(image))
            
        }
    }
}
