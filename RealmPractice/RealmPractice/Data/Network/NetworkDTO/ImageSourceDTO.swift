//
//  StickerListDTO.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import Foundation

struct ImageSourceDTO: Decodable {
    
    let urls: UrlsDTO
    
    enum CodingKeys: String, CodingKey {
        case urls
    }
    
    func convertToDomain() -> ImageSource {
        let convertedToDomain = self.urls.convertToDomain()
        return .init(urls: convertedToDomain)
    }
    
    func convertToEntity() -> ImageSourceStorageEntity {
        let urls = UrlsStorageEntity()
        urls.full = self.urls.full
        urls.regular = self.urls.regular
        urls.small = self.urls.small
        urls.raw = self.urls.raw
        
        let imageUnitStorageEntity = ImageSourceStorageEntity()
        imageUnitStorageEntity.urls = urls
        
        return imageUnitStorageEntity
    }
    
}

struct UrlsDTO: Decodable {
    
    let raw, full, regular, small: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small
    }
    
    func convertToDomain() -> Urls {
        return .init(raw: self.raw, full: self.full, regular: self.regular, small: self.small)
    }
    
}
