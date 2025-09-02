//
//  BookmarManager.swift
//  HeaderViewer
    

import Foundation

class BookmarkManager: ObservableObject {
    static let shared = BookmarkManager()
    
    // keeps track of the last opened framework or dynamic library
    static var lastLeafNode: String?
    
    
    @Published var bookmarks: [Bookmark] = []
    
    private let userDefaults: UserDefaults
    private let userDefaultsKey = "bookmarks"

    
    private init() {
        self.userDefaults = UserDefaults(suiteName: "BookmarkManager")!
        loadBookmarks()
        debugBookmarks()
    }
    
    func toggleBookmark(for imageName: String) {
        guard let parent = BookmarkManager.lastLeafNode else { return }
        let b = Bookmark(imageName: imageName, parentFramework: parent)
        
        if let index = bookmarks.firstIndex(of: b) {
            bookmarks.remove(at: index)
        } else {
            bookmarks.append(b)
        }
        
        syncBookmarks()
        debugBookmarks()
    }
    
    @discardableResult
    func addBookmark(imageName: String, parent: String) -> Int {
        let newBookmark = Bookmark(imageName: imageName, parentFramework: parent)
        bookmarks.append(newBookmark)
        syncBookmarks()
        return bookmarks.count - 1
    }
    
    func removeBookmark(at index: Int) {
        bookmarks.remove(at: index)
        syncBookmarks()
    }
    
    func clearBookmarks() {
        bookmarks.removeAll()
        syncBookmarks()
    }
    
    func isBookmarked(_ imageName: String) -> Bool {
        guard let parent = BookmarkManager.lastLeafNode else { return false }
        return bookmarks.contains { $0.imageName == imageName && $0.parentFramework == parent }
    }
    
    private func syncBookmarks() {
        let data = try? JSONEncoder().encode(bookmarks)
        userDefaults.set(data, forKey: userDefaultsKey)
    }
    
    private func loadBookmarks() {
        guard let data = userDefaults.data(forKey: userDefaultsKey) else { return }
        bookmarks = try! JSONDecoder().decode([Bookmark].self, from: data)
    }
    
    private func debugBookmarks() {
        print("Bookmarks:")
        bookmarks.forEach { print($0) }
    }
}

struct Bookmark: Codable, Equatable {
    let imageName: String
    let parentFramework: String
}
