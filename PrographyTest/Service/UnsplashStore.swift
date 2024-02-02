//
//  UnsplashStore.swift
//  PrographyTest
//
//  Created by LJh on 2/2/24.
//

import SwiftUI

final class UnsplashStore: ObservableObject {
    @Published var isHave = false
    @Published var photos: [Unsplash] = []
    @Published var randomphotos: [Unsplash] = []
    @Published var pageEnd: Bool = false
    @Published var searchPhoto: Unsplash = tempUnsplash
    private let accessKey = "s_xc_3Qm1dXTRqS4cYaPkeV8OlQOyflvtmOKtDgR-hA"
    
    private func fetchData(from urlString: String, completion: @escaping (Result<[Unsplash], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(.failure(error))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let unsplashData = try decoder.decode([Unsplash].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(unsplashData))
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func fetchAllPhotos() {
        let urlString = "https://api.unsplash.com/photos?client_id=\(accessKey)"
        
        fetchData(from: urlString) { result in
            switch result {
                case .success(let photos):
                    self.photos.append(contentsOf: photos)
                case .failure:
                    break
            }
        }
    }
    
    func fetchNextAllPhoto(page: Int, per_page: Int) {
        let urlString = "https://api.unsplash.com/photos?page=\(page)&per_page=\(per_page)&order_by=latest&client_id=\(accessKey)"
        fetchData(from: urlString) { result in
            switch result {
                case .success(let photos):
                    self.photos.append(contentsOf: photos)
                case .failure:
                    break
            }
        }
    }
    
    func fetchRandomPhoto(count: Int) {
        let urlString = "https://api.unsplash.com/photos/random?client_id=\(accessKey)&count=\(count)"
        
        fetchData(from: urlString) { result in
            switch result {
                case .success(let randomphotos):
                    self.randomphotos.append(contentsOf: randomphotos)
                case .failure:
                    break
            }
        }
    }
    
    // 특정 사진 가져오기
    func fetchSearchPhoto(id: String) {
        let urlString: String = "https://api.unsplash.com/photos/\(id)?client_id=\(accessKey)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let searchPhoto = try decoder.decode(Unsplash.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.searchPhoto = searchPhoto
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        task.resume()
    }
    
    func deleteRandomPhoto(index: Int) {
        randomphotos.remove(at: index)
    }
}
