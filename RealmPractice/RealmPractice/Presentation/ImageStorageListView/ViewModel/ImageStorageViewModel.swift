//
//  ImageStorageViewModel.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/25.
//

import Foundation

protocol ImageStorageViewModel {
    var imageUnit: Observable<[ImageSource]> { get }
    var isError: Observable<Bool> { get }
    var error: Observable<Error?> { get }
    
    func didFetch()
    func didRemove(at index: Int)
}

final class DefaultImageStorageViewModel: ImageStorageViewModel {
    
    private let imagesRepository: ImagesRepository
    let imageUnit: Observable<[ImageSource]>
    let isError: Observable<Bool>
    let error: Observable<Error?>
    
    init(imagesRepository: ImagesRepository) {
        self.imagesRepository = imagesRepository
        self.imageUnit = Observable([])
        self.isError = Observable(false)
        self.error = Observable(nil)
    }
    
    private func fetch(completion: @escaping (Result<[ImageSource], Error>) -> Void) {
        self.imagesRepository.fetchImageSource { result in
            switch result {
            case .success(let data):
                self.imageUnit.value = data
                completion(.success(data))
            case .failure(let error):
                self.isError.value = true
                self.error.value = error
                completion(.failure(error))
            }
        }
    }
    
    func didFetch() {
        self.fetch { result in
            switch result {
            case .success(let data):
                self.imageUnit.value = data
            case .failure(let error):
                self.isError.value = true
                self.error.value = error
            }
        }
    }
    
    func remove(at index: Int, completion: @escaping (Result<ImageSourceStorageEntity, Error>) -> Void) {
        self.imagesRepository.deleteImageSource(at: index) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                self.isError.value = true
                self.error.value = error
                completion(.failure(error))
            }
        }
    }
    
    func didRemove(at index: Int) {
        self.remove(at: index) { result in
            switch result {
            case .success(_):
                return
            case .failure(let error):
                self.isError.value = true
                self.error.value = error
            }
        }
    }
    
}
