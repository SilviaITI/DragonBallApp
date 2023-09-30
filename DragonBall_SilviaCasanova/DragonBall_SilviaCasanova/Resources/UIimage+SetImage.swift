//
//  UIimage+SetImage.swift
//  DragonBall_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 24/9/23.
//

import Foundation
import UIKit

extension UIImageView {
    // MARK: - Public Methods
    func setImage(for url: URL) {
        downloadImage(url: url) { [weak self] result in
            guard case let .success(image) = result else {
                return
            }
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    // MARK: - Private methods
    private func downloadImage(
        url: URL,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) {
        let task = URLSession.shared.dataTask(with: url) { data, response, _ in
            let result: Result<UIImage, Error>
            
            defer {
                completion(result)
            }
            
            guard let data, let image = UIImage(data: data) else {
                result = .failure(NSError(domain: "No image", code: -1))
                return
            }
            
            result = .success(image)
        }
        
        task.resume()
    }
}
