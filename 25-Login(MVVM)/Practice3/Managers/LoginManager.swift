//
//  LoginManager.swift
//  Practice3
//
//  Created by 김건우 on 2023/09/09.
//

import Foundation

enum LoginError: Error {
    case badRequest
    case decodingError
    case notAuthenticated
}

final class LoginManager {
    
    // 싱글톤으로 구현
    static let shared = LoginManager()
    private init() { }
    
    // 테스트 로그인
    func loginTest(username: String, password: String, completionHandler: @escaping (Result<Void, LoginError>) -> Void) {
        if username == "username" && password == "password" {
            completionHandler(.success(()))
            return
        } else {
            completionHandler(.failure(.notAuthenticated))
            return
        }
    }
    
    // 실제 로그인 네트워킹
    func login(username: String, password: String, completionHandler: @escaping (Result<Void, LoginError>) -> Void) {
        
        guard let url = URL(string: "...") else {
            return completionHandler(.failure(.badRequest))
        }
        
        let loginData = ["username": username, "password": password]
        
        // 리퀘스트 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(loginData)
        
        // 네트워킹 시작
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러 발생 여부 확인
            guard let error = error else {
                completionHandler(.failure(.badRequest))
                return
            }
            // 상태 코드 확인
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  (200..<300) ~= statusCode else {
                completionHandler(.failure(.badRequest))
                return
            }
            // 전달된 데이터 확인
            guard let safeData = data else {
                completionHandler(.failure(.badRequest))
                return
            }
            // 데이터 파싱
            guard let parsedData = try? JSONDecoder().decode(LoginResponse.self, from: safeData) else {
                completionHandler(.failure(.decodingError))
                return
            }
            // 로그인 완료
            if parsedData.success {
                completionHandler(.success(()))
                return
            } else {
                completionHandler(.failure(.notAuthenticated))
                return
            }
        }.resume()
    }
}
