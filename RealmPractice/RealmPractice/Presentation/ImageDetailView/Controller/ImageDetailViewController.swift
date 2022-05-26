//
//  ImageViewController.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import UIKit
import SnapKit

final class ImageDetailViewController: UIViewController {
    
    private var imageDetailViewModel: ImageDetailViewModel!
    private let imageDetailImageView = CacheImageView()
    private let saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageDetailViewModel.didFetchImage()
        self.configureBackground()
        self.addSubviews()
        self.configureLayout()
        self.configureImage()
        self.configureSaveButton()
        self.bind()
    }
    
    static func create(with viewModel: ImageDetailViewModel) -> ImageDetailViewController {
        let viewController = ImageDetailViewController()
        viewController.imageDetailViewModel = viewModel
        return viewController
    }
    
    private func bind() {
        self.imageDetailViewModel.observableImageUnit.bind { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.configureImage()
            }
        }
        self.imageDetailViewModel.isError.bind { [weak self] isError in
            guard let self = self else { return }
            guard let error = self.imageDetailViewModel.error.value else { return }
            if isError {
                self.presentErrorAlert(of: error)
            }
        }
        self.imageDetailViewModel.isSaveSuccess.bind { [weak self] isSaveSuccess in
            guard let self = self else { return }
            guard let isSaveSuccess = isSaveSuccess else { return }
            if isSaveSuccess {
                self.presentSaveSuccessAlert()
            } else {
                self.presentSaveFailureAlert()
            }
        }
    }
    
    @objc func pressSaveButton() {
        self.imageDetailViewModel.didSaveImageUnit()
    }
    
}

// MARK: - Result handling

extension ImageDetailViewController {
    
    private func presentErrorAlert(of error: Error) {
        let errorAlert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
        let addErrorAlertAction = UIAlertAction(title: "OK", style: .default)
        errorAlert.addAction(addErrorAlertAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    private func presentSaveSuccessAlert() {
        let errorAlert = UIAlertController(title: "Save Success", message: "Save Success", preferredStyle: UIAlertController.Style.alert)
        let addErrorAlertAction = UIAlertAction(title: "OK", style: .default)
        errorAlert.addAction(addErrorAlertAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    private func presentSaveFailureAlert() {
        let errorAlert = UIAlertController(title: "Save Failure", message: "Save Failure", preferredStyle: UIAlertController.Style.alert)
        let addErrorAlertAction = UIAlertAction(title: "OK", style: .default)
        errorAlert.addAction(addErrorAlertAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
}

// MARK: - Configure subviews

extension ImageDetailViewController {
    
    private func configureImage() {
        self.imageDetailImageView.contentMode = .scaleAspectFit
        let imageUrl = self.imageDetailViewModel.observableImageUnit.value.urls.small
        self.imageDetailImageView.loadImageUsingUrlString(urlString: imageUrl)
    }
    
    private func configureSaveButton() {
        self.saveButton.backgroundColor = .systemBlue
        self.saveButton.setTitle("즈장", for: .normal)
        self.saveButton.setTitleColor(.white, for: .normal)
        self.saveButton.layer.cornerRadius = 10
        self.saveButton.addTarget(self, action: #selector(self.pressSaveButton), for: .touchUpInside)
    }
    
}

// MARK: - Add subviews and layout

extension ImageDetailViewController {
    
    private func configureBackground() {
        self.view.backgroundColor = .white
    }
    
    private func addSubviews() {
        self.view.addSubview(imageDetailImageView)
        self.view.addSubview(saveButton)
    }
    
    private func configureLayout() {
        self.imageDetailImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.saveButton.safeAreaLayoutGuide)
        }
        self.saveButton.snp.makeConstraints {
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(40)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-40)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
}
