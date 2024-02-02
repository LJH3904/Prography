//
//  BookmarkStore.swift
//  PrographyTest
//
//  Created by LJh on 2/2/24.
//

import Foundation

final class BookmarkStore: ObservableObject {
    @Published var bookmarkedPhotos: [Unsplash] = []
    private let bookmarkKey = "BookmarkedUnsplash"
    
    init() {
        self.bookmarkedPhotos = getBookmarkedUnsplash()
    }
    
    func getBookmarkedUnsplash() -> [Unsplash] {
        guard let data = UserDefaults.standard.data(forKey: bookmarkKey),
              let bookmarkedUnsplashes = try? JSONDecoder().decode([Unsplash].self, from: data) else {
            return []
        }
        return bookmarkedUnsplashes
    }
    
    func addBookmarkedUnsplash(_ unsplash: Unsplash) {
        var bookmarkedUnsplashes = getBookmarkedUnsplash()
        bookmarkedUnsplashes.append(unsplash)
        saveBookmarkedUnsplash(bookmarkedUnsplashes)
    }
    
    func removeBookmarkedUnsplash(_ unsplash: Unsplash) {
        var bookmarkedUnsplashes = getBookmarkedUnsplash()
        bookmarkedUnsplashes.removeAll { $0.id == unsplash.id }
        saveBookmarkedUnsplash(bookmarkedUnsplashes)
    }
    
    private func saveBookmarkedUnsplash(_ unsplashes: [Unsplash]) {
        do {
            let data = try JSONEncoder().encode(unsplashes)
            UserDefaults.standard.set(data, forKey: bookmarkKey)
        } catch {
            print("Error encoding bookmarked Unsplash: \(error)")
        }
    }
    
    func updateBookmarkedPhotos() {
        bookmarkedPhotos = getBookmarkedUnsplash()
    }
}

