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
    
    func generateAccount(name: String, password: String, completion: @escaping (Result<AccountDetails, Error>) -> Void) {
        guard let url = URL(string: "https://pacific-lake-00352-372639b432c2.herokuapp.com/api/account/createRandomAccount") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody = ["name": name, "password": password]
        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch {
            completion(.failure(error))
            return
        }

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
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
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
                let xpResponse = try JSONDecoder().decode(XPResponse.self, from: data)
                DispatchQueue.main.async { completion(.success(xpResponse.xpAmount)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }
    
    func updateXP(accountNumber: String, password: String, xpAmount: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        guard let url = URL(string: "https://pacific-lake-00352-372639b432c2.herokuapp.com/api/account/changeXP") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let updateRequest = XPUpdateRequest(accountNumber: accountNumber, password: password, xpAmount: xpAmount)
        do {
            request.httpBody = try JSONEncoder().encode(updateRequest)
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async { completion(.failure(NetworkError.invalidResponse)) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NetworkError.invalidData)) }
                return
            }

            do {
                let updatedXP = try JSONDecoder().decode(XPResponse.self, from: data)
                DispatchQueue.main.async { completion(.success(updatedXP.xpAmount)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }
    
    func getLevel(accountNumber: String, completion: @escaping (Result<Int, Error>) -> Void) {
        // Construct the URL with the account number
        guard let url = URL(string: "https://pacific-lake-00352-372639b432c2.herokuapp.com/api/account/\(accountNumber)/level") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
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
                let levelResponse = try JSONDecoder().decode(levelResponse.self, from: data)
                DispatchQueue.main.async { completion(.success(levelResponse.level)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }
    
    func updateLevel(accountNumber: String, level: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        guard let url = URL(string: "https://pacific-lake-00352-372639b432c2.herokuapp.com/api/account/increaseLevelByAmountWithoutPassword") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let updateRequest = levelUpdateRequest(accountNumber: accountNumber, level: level)
        do {
            request.httpBody = try JSONEncoder().encode(updateRequest)
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async { completion(.failure(NetworkError.invalidResponse)) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NetworkError.invalidData)) }
                return
            }

            do {
                let updatedLevel = try JSONDecoder().decode(levelResponse.self, from: data)
                DispatchQueue.main.async { completion(.success(updatedLevel.level)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }
    
    func getMiles(accountNumber: String, completion: @escaping (Result<Int, Error>) -> Void) {
        // Construct the URL with the account number
        guard let url = URL(string: "https://pacific-lake-00352-372639b432c2.herokuapp.com/api/account/\(accountNumber)/capitalOneMiles") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
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
                let milesResponse = try JSONDecoder().decode(milesResponse.self, from: data)
                DispatchQueue.main.async { completion(.success(milesResponse.miles)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }
    
    func updateMiles(accountNumber: String, password: String, miles: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        guard let url = URL(string: "https://pacific-lake-00352-372639b432c2.herokuapp.com/api/account/increaseCapitalOneMiles") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let updateRequest = milesUpdateRequest(accountNumber: accountNumber, password: password, miles: miles)
        do {
            request.httpBody = try JSONEncoder().encode(updateRequest)
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async { completion(.failure(NetworkError.invalidResponse)) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NetworkError.invalidData)) }
                return
            }

            do {
                let updatedMiles = try JSONDecoder().decode(milesResponse.self, from: data)
                DispatchQueue.main.async { completion(.success(updatedMiles.miles)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }
    
    


}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
