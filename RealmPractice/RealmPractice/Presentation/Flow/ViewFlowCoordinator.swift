//
//  ViewFlowCoordinator.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import UIKit

protocol ViewFlowCoordinatorDependencies {
    func makeImageSourcesViewController(action: ImageSourcesViewModelAction) -> ImageSourcesViewController
    func makeImageDetailViewController(imageUnit: ImageSource) -> ImageDetailViewController
    func makeImageStorageViewController() -> ImageStorageViewController
}

final class ViewFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: ViewFlowCoordinatorDependencies
    
    private weak var imageSourcesViewController: ImageSourcesViewController?
    
    init(navigationController: UINavigationController, dependencies: ViewFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let action = ImageSourcesViewModelAction(showImageDetail: self.showImageDetail(of:), showStorage: self.showStorage)
        let viewController = dependencies.makeImageSourcesViewController(action: action)
        
        self.navigationController?.pushViewController(viewController, animated: true)
        self.imageSourcesViewController = viewController
    }
    
    private func showImageDetail(of imageUnit: ImageSource) {
        let viewController = dependencies.makeImageDetailViewController(imageUnit: imageUnit)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showStorage() {
        let viewController = dependencies.makeImageStorageViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

