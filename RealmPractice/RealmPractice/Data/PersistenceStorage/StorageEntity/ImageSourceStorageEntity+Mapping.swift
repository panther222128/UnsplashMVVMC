//
//  ImageUnitStorageEntity+Mapping.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import Foundation

extension ImageSourceStorageEntity {
    
    func convertToDTO() -> ImageSourceDTO {
        guard let urls = urls else { return ImageSourceDTO(urls: UrlsDTO(raw: "", full: "", regular: "", small: ""))}
        let convertedToDTO = urls.convertToDTO()
        return .init(urls: convertedToDTO)
    }
    
}

extension UrlsStorageEntity {
    
    func convertToDTO() -> UrlsDTO {
        return .init(raw: self.raw ?? "", full: self.full ?? "", regular: self.regular ?? "", small: self.small ?? "")
    }
    
}
