//
//  NetworkManager.swift
//  Banking_App
//
//  Created by Pranav Chhabra on 12/1/23.
//

import Foundation

class NetworkManager {
//    @State private var accountDetails: AccountDetails?
    static let shared = NetworkManager()
    
    func generateAccount(completion: @escaping (Result<AccountDetails, Error>) -> Void) {
            guard let url = URL(string: "https://pacific-lake-00352-372639b432c2.herokuapp.com/api/account/createRandomAccount") else {
                completion(.failure(NetworkError.invalidURL))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"  // Adjust as necessary

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async { completion(.failure(error)) }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async { completion(.failure(NetworkError.invalidResponse)) }
                    return
                }

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"  // Adjust this format to match your backend
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(dateFormatter)

                do {
                    let accountDetails = try decoder.decode(AccountDetails.self, from: data)
                    DispatchQueue.main.async { completion(.success(accountDetails)) }
                } catch {
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }.resume()
        }
    
    func getXP(accountNumber: String, completion: @escaping (Result<Int, Error>) -> Void) {
            // Construct the URL with the account number
            guard let url = URL(string: "https://pacific-lake-00352-372639b432c2.herokuapp.com/api/account/\(accountNumber)/xp") else {
                completion(.failure(NetworkError.invalidURL))
                return
            }

            // Setup the request (assuming it's a GET request)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            // Perform the network request
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async { completion(.failure(error)) }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async { completion(.failure(NetworkError.invalidResponse)) }
                    return
                }

                do {
                    // Assuming the response is just an integer value for XP
                    let xpAmount = try JSONDecoder().decode(Int.self, from: data)
                    DispatchQueue.main.async { completion(.success(xpAmount)) }
                } catch {
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }.resume()
        }
    
    // GET LEVEL
    func getLevel(accountNumber: String, completion: @escaping (Result<Int, Error>) -> Void) {
        // Construct the URL
        guard let url = URL(string: "https://pacific-lake-00352-372639b432c2.herokuapp.com/api/account/\(accountNumber)/level") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        // Create an HTTP GET request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Create a URLSession task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NetworkError.invalidResponse)) }
                return
            }

            do {
                let level = try JSONDecoder().decode(Int.self, from: data)
                DispatchQueue.main.async { completion(.success(level)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }

        // Start the URLSession task
        task.resume()
    }
    
    // GET CAPITAL ONE MILES
    func getCapitalOneMiles(accountNumber: String, completion: @escaping (Result<Int, Error>) -> Void) {
        // Construct the URL
        guard let url = URL(string: "https://pacific-lake-00352-372639b432c2.herokuapp.com/api/account/\(accountNumber)/capitalOneMiles") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        // Create an HTTP GET request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Create a URLSession task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NetworkError.invalidResponse)) }
                return
            }

            do {
                let capitalOneMiles = try JSONDecoder().decode(Int.self, from: data)
                DispatchQueue.main.async { completion(.success(capitalOneMiles)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }

        // Start the URLSession task
        task.resume()
    }
    
    // GET WALMART CREDITS
    func getWalmartCredits(accountNumber: String, completion: @escaping (Result<Int, Error>) -> Void) {
        // Construct the URL
        guard let url = URL(string: "https://pacific-lake-00352-372639b432c2.herokuapp.com/api/account/\(accountNumber)/walmartCredits") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        // Create an HTTP GET request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Create a URLSession task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NetworkError.invalidResponse)) }
                return
            }

            do {
                let walmartAmount = try JSONDecoder().decode(Int.self, from: data)
                DispatchQueue.main.async { completion(.success(walmartAmount)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }

        // Start the URLSession task
        task.resume()
    }
    
    // GET AMAZON CREDITS
    func getAmazonCredits(accountNumber: String, completion: @escaping (Result<Int, Error>) -> Void) {
        // Construct the URL
        guard let url = URL(string: "https://pacific-lake-00352-372639b432c2.herokuapp.com/api/account/\(accountNumber)/amazonCredits") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        // Create an HTTP GET request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Create a URLSession task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NetworkError.invalidResponse)) }
                return
            }

            do {
                let amazonCredits = try JSONDecoder().decode(Int.self, from: data)
                DispatchQueue.main.async { completion(.success(amazonCredits)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }

        // Start the URLSession task
        task.resume()
    }
    
    // GET TARGET CREDITS
    func getTargetCredits(accountNumber: String, completion: @escaping (Result<Int, Error>) -> Void) {
        // Construct the URL
        guard let url = URL(string: "https://pacific-lake-00352-372639b432c2.herokuapp.com/api/account/\(accountNumber)/targetCredits") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        // Create an HTTP GET request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Create a URLSession task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NetworkError.invalidResponse)) }
                return
            }

            do {
                let targetCredits = try JSONDecoder().decode(Int.self, from: data)
                DispatchQueue.main.async { completion(.success(targetCredits)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }

        // Start the URLSession task
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}
