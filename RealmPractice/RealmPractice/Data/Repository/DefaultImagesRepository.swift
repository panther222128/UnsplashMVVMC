//
//  DefaultImageUnitRepository.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import Foundation

final class DefaultImagesRepository {
    
    private let imagesStorage: ImagesStorage
    
    init(imagesStorage: ImagesStorage) {
        self.imagesStorage = imagesStorage
    }
    
}

extension DefaultImagesRepository: ImagesRepository {
    
    func saveImageSource(imageSource: ImageSource, completion: @escaping (Result<ImageSourceStorageEntity, Error>) -> Void) {
        let convertedUrlsToDto = UrlsDTO(raw: imageSource.urls.raw, full: imageSource.urls.full, regular: imageSource.urls.regular, small: imageSource.urls.small)
        let convertedToDto = ImageSourceDTO(urls: convertedUrlsToDto)
        let convertedToEntity = convertedToDto.convertToEntity()
        self.imagesStorage.insert(imageSourceStorageEntity: convertedToEntity) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchImageSource(completion: @escaping (Result<[ImageSource], Error>) -> Void) {
        self.imagesStorage.fetch { result in
            switch result {
            case .success(let data):
                let convertedToDto = data.map( { $0.convertToDTO() } )
                let convertedToDomain = convertedToDto.map( { $0.convertToDomain() } )
                completion(.success(convertedToDomain))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteImageSource(at index: Int, completion: @escaping (Result<ImageSourceStorageEntity, Error>) -> Void) {
        self.imagesStorage.remove(at: index) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
