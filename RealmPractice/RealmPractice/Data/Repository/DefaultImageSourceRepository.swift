//
//  DefaultStickerListRepository.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import Foundation
import Moya

final class DefaultImageSourceRepository {
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
    
}

extension DefaultImageSourceRepository: ImageSourcesRepository {

    func fetchImageSource(completion: @escaping (Result<[ImageSource], Error>) -> Void) {
        let apiEndpoint = APIEndpoint.getImageListEndpoint()
        self.dataTransferService.request(with: apiEndpoint, dataType: [ImageSourceDTO].self) { result in
            switch result {
            case .success(let data):
                let convertedToDomain = data.map( { $0.convertToDomain() } )
                completion(.success(convertedToDomain))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchImageSourceUsingMoya(completion: @escaping (Result<[ImageSource], Error>) -> Void) {
        let provider = MoyaProvider<ImageListEndpoint>()
        provider.request(.imageSourcePath) { result in
            switch result {
            case .success(let response):
                guard let result = try? response.map([ImageSourceDTO].self) else { return }
                let convertedToDomain = result.map( { $0.convertToDomain() } )
                completion(.success(convertedToDomain))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
