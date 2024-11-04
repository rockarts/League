//
//  ImageCache.swift
//  LeagueMobileChallenge
//
//  Created by Steven Rockarts on 2024-11-04.
//


actor ImageCache {
    private var cache: [String: UIImage] = [:]
    
    func image(for key: String) -> UIImage? {
        cache[key]
    }
    
    func setImage(_ image: UIImage, for key: String) {
        cache[key] = image
    }
    
    func clear() {
        cache.removeAll()
    }
}
