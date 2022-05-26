//
//  ImageListViewModel.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import Foundation

struct ImageSourcesViewModelAction {
    let showImageDetail: ((ImageSource) -> Void)
    let showStorage: (() -> Void)
}

protocol ImageSourcesViewModel {
    var imageSources: Observable<[ImageSource]> { get }
    var isError: Observable<Bool> { get }
    var error: Observable<Error?> { get }
    
    func didFetch()
    func didFetchUsingMoya()
    func didSelectItem(of imageUnit: ImageSource)
    func didMoveToStorageView()
}

final class DefaultImageSourcesViewModel {
    
    let imageSources: Observable<[ImageSource]>
    let isError: Observable<Bool>
    let error: Observable<Error?>
    
    private let imageSourcesRepository: ImageSourcesRepository
    private let action: ImageSourcesViewModelAction
    
    init(imageSourcesRepository: ImageSourcesRepository, action: ImageSourcesViewModelAction) {
        self.imageSources = Observable([])
        self.isError = Observable(false)
        self.error = Observable(nil)
        self.imageSourcesRepository = imageSourcesRepository
        self.action = action
    }
    
}

extension DefaultImageSourcesViewModel: ImageSourcesViewModel {
    
    private func fetchImageListUsingMoya(completion: @escaping (Result<[ImageSource], Error>) -> Void) {
        self.imageSourcesRepository.fetchImageSourceUsingMoya { result in
            switch result {
            case .success(let data):
                self.imageSources.value = data
                completion(.success(data))
            case .failure(let error):
                self.isError.value = true
                self.error.value = error
                completion(.failure(error))
            }
        }
    }
    
    func didFetchUsingMoya() {
        self.fetchImageListUsingMoya { result in
            switch result {
            case .success(let data):
                self.imageSources.value = data
            case .failure(let error):
                self.isError.value = true
                self.error.value = error
            }
        }
    }
    
    private func fetchImageList(completion: @escaping (Result<[ImageSource], Error>) -> Void) {
        self.imageSourcesRepository.fetchImageSource { result in
            switch result {
            case .success(let data):
                self.imageSources.value = data
                completion(.success(data))
            case .failure(let error):
                self.isError.value = true
                self.error.value = error
                completion(.failure(error))
            }
        }
    }
    
    func didFetch() {
        self.fetchImageList { result in
            switch result {
            case .success(let data):
                self.imageSources.value = data
            case .failure(let error):
                self.isError.value = true
                self.error.value = error
            }
        }
    }
    
    func didSelectItem(of imageUnit: ImageSource) {
        self.action.showImageDetail(imageUnit)
    }
    
    func didMoveToStorageView() {
        self.action.showStorage()
    }
    
}
