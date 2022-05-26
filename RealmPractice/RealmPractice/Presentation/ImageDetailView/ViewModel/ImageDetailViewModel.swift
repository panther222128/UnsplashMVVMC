//
//  ImageViewModel.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import Foundation

protocol ImageDetailViewModel {
    var observableImageUnit: Observable<ImageSource> { get }
    var isSaveSuccess: Observable<Bool?> { get }
    var isError: Observable<Bool> { get }
    var error: Observable<Error?> { get }
    
    func didFetchImage()
    func didSaveImageUnit()
}

final class DefaultImageDetailViewModel: ImageDetailViewModel {
    
    let observableImageUnit: Observable<ImageSource>
    let isSaveSuccess: Observable<Bool?>
    let isError: Observable<Bool>
    let error: Observable<Error?>
    
    private let imagesRepository: ImagesRepository
    private var imageSource: ImageSource
    
    init(imagesRepository: ImagesRepository, imageSource: ImageSource) {
        self.imagesRepository = imagesRepository
        self.imageSource = imageSource
        self.observableImageUnit = Observable(ImageSource(urls: Urls(raw: "", full: "", regular: "", small: "")))
        self.isSaveSuccess = Observable(nil)
        self.isError = Observable(false)
        self.error = Observable(nil)
    }
    
    func didFetchImage() {
        self.observableImageUnit.value = self.imageSource
    }
    
    private func saveImageUnit(imageUnit: ImageSource, completion: @escaping (Result<ImageSourceDTO, Error>) -> Void) {
        self.imagesRepository.saveImageSource(imageSource: imageUnit) { result in
            switch result {
            case .success(let data):
                self.isSaveSuccess.value = true
                guard let urls = data.urls else { return }
                let convertedUrlsToDto = UrlsDTO(raw: urls.raw ?? "", full: urls.full ?? "", regular: urls.regular ?? "", small: urls.small ?? "")
                let convertedToDto = ImageSourceDTO(urls: convertedUrlsToDto)
                completion(.success(convertedToDto))
            case .failure(let error):
                self.isError.value = true
                self.error.value = error
                self.isSaveSuccess.value = false
                completion(.failure(error))
            }
        }
    }
    
    func didSaveImageUnit() {
        self.saveImageUnit(imageUnit: self.imageSource) { result in
            switch result {
            case .success(_):
                self.isSaveSuccess.value = true
            case .failure(let error):
                self.isError.value = true
                self.error.value = error
                self.isSaveSuccess.value = false
            }
        }
    }
    
}
