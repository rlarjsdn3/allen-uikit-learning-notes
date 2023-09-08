//
//  NetworkManager.swift
//  MusicCover(MVC)
//
//  Created by 김건우 on 2023/09/01.
//

import UIKit
import Foundation

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

protocol MusicNetwork {
    func fetchMusic(completionHandler: @escaping (Result<Music?, NetworkError>) -> Void)
    func performRequest(with url: URL, completionHandler: @escaping (Result<[Music], NetworkError>) -> Void)
    func loadImage(imageUrl: String?, completionHandler: @escaping (UIImage?) -> Void)
}

class NetworkManager: MusicNetwork {
    
    // 일부러 싱글톤 패턴으로 구현하지 않음
    
    func fetchMusic(completionHandler: @escaping (Result<Music?, NetworkError>) -> Void) {
        let urlString = "https://itunes.apple.com/search?media=music&term=jazz"
        let url = URL(string: urlString)!
        
        performRequest(with: url) { result in
            switch result {
            case .success(let music):
                completionHandler(.success(music.first))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func performRequest(with url: URL, completionHandler: @escaping (Result<[Music], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.networkingError))
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200..<300) ~= statusCode else {
                completionHandler(.failure(.networkingError))
                return
            }
            guard let safeData = data else {
                completionHandler(.failure(.dataError))
                return
            }
            guard let parsedData = self.decode(of: MusicData.self, data: safeData) else {
                completionHandler(.failure(.parseError))
                return
            }
            completionHandler(.success(parsedData.results))
        }.resume()
    }
    
    func loadImage(imageUrl: String?, completionHandler: @escaping (UIImage?) -> Void) {
        guard let urlString = imageUrl,
              let url = URL(string: urlString) else {
                  completionHandler(nil)
                  return
              }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                completionHandler(nil)
                return
            }
            completionHandler(image)
            return
        }
    }
    
    private func decode<T: Codable>(of type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(type, from: data)
    }
}
