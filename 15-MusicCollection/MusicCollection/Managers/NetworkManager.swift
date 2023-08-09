//
//  NetworkManager.swift
//  MusicCollection
//
//  Created by 김건우 on 2023/08/09.
//

import Foundation

// MARK: - 통신 과정에서 발생할 수 있는 에러 정의

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

// MARK: - 네트워크 통신을 하는 클래스 모델 (싱글톤)

final class NetworkManager {
    // shared 클래스 변수를 통해서만 접근
    static let shared = NetworkManager()
    // 여러 인스턴스를 생성하지 못하도록 설정
    private init() { }
    
    typealias NetworkCompletion = (Result<[Music], NetworkError>) -> Void
    
    // 음악 데이터를 요청하는 메서드
    func fetchMusic(searchTerm: String, completionHandler: @escaping NetworkCompletion) {
        // 호출 URL 선언하기
        let urlString = "\(MusicURL.requestUrl)\(MusicURL.mediaParam)&term=\(searchTerm)"
        // URL로 음악 데이터 요청하기
        performRequest(with: urlString) { result in
            completionHandler(result)
        }
    }
    
    // 음악 데이터를 서버로부터 불러오는 메서드
    func performRequest(with url: String, completionHandler: @escaping NetworkCompletion) {
        // url을 URL구조체로 래핑하기
        guard let url = URL(string: url) else {
            completionHandler(.failure(.networkingError))
            return
        }
        // URLSession 열기
        let session = URLSession.shared
        // 세션에 작업 부여하기
        let task = session.dataTask(with: url) { (data, response, error) in
            // 에러가 발생하면
            guard error == nil else {
                completionHandler(.failure(.networkingError))
                return
            }
            
            // 상태 코드가 200~300 사이가 아니라면
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                completionHandler(.failure(.networkingError))
                return
            }
            
            // 데이터를 옵셔널 바인딩할 수 없다면
            guard let data = data else {
                completionHandler(.failure(.dataError))
                return
            }
            
            // 받은 데이터를 JSON으로 파싱하기
            guard let parsedData = self.parseJSON(of: iTunesData.self, data: data) else {
                completionHandler(.failure(.parseError))
                return
            }
            
            // 음악 검색 결과를 콜백함수로 반환하기
            completionHandler(.success(parsedData.results))
        }
        // 작업 시작하기
        task.resume()
    }

    // 음악 데이터를 JSON으로 파싱하는 메서드
    private func parseJSON<T: Codable>(of type: T.Type, data: Data) -> T? {
        return try? JSONDecoder().decode(type, from: data)
    }
}
