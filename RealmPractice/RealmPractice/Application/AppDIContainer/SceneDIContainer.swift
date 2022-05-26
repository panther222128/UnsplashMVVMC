//
//  SceneDIContainer.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import UIKit

final class SceneDIContainer: ViewFlowCoordinatorDependencies {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    lazy var imagesStorage: ImagesStorage = RealmImageSourceStorage()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeViewFlowCoordinator(navigationController: UINavigationController) -> ViewFlowCoordinator {
        return ViewFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    // MARK: - ImageList
    
    private func makeImageListRepository() -> ImageSourcesRepository {
        return DefaultImageSourceRepository(dataTransferService: self.dependencies.apiDataTransferService)
    }
    
    func makeImageListViewModel(action: ImageSourcesViewModelAction) -> ImageSourcesViewModel {
        return DefaultImageSourcesViewModel(imageSourcesRepository: self.makeImageListRepository(), action: action)
    }
    
    func makeImageSourcesViewController(action: ImageSourcesViewModelAction) -> ImageSourcesViewController {
        return ImageSourcesViewController.create(with: self.makeImageListViewModel(action: action))
    }
    
    // MARK: - ImageDetail
    
    func makeImagesRepository() -> ImagesRepository {
        return DefaultImagesRepository(imagesStorage: self.imagesStorage)
    }
    
    func makeImageDetailViewModel(imageUnit: ImageSource) -> ImageDetailViewModel {
        return DefaultImageDetailViewModel(imagesRepository: self.makeImagesRepository(), imageSource: imageUnit)
    }

    func makeImageDetailViewController(imageUnit: ImageSource) -> ImageDetailViewController {
        return ImageDetailViewController.create(with: self.makeImageDetailViewModel(imageUnit: imageUnit))
    }

    // MARK: - ImageStorage
    
    func makeImageStorageViewModel() -> ImageStorageViewModel {
        return DefaultImageStorageViewModel(imagesRepository: self.makeImagesRepository())
    }
    
    func makeImageStorageViewController() -> ImageStorageViewController {
        return ImageStorageViewController.create(with: self.makeImageStorageViewModel())
    }
    
}
