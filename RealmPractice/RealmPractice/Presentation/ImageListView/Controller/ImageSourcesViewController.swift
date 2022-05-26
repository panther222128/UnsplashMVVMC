//
//  ImageListViewController.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import UIKit
import SnapKit

final class ImageSourcesViewController: UIViewController {

    private var imageSourcesViewModel: ImageSourcesViewModel!
    private let imageSourcesTableView = UITableView()
    private let moveToStorageViewButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageSourcesTableView.dataSource = self
        self.imageSourcesTableView.delegate = self
        
        self.imageSourcesViewModel.didFetchUsingMoya()
        
        self.convigureBackground()
        self.addSubviews()
        self.configureLayout()
        self.configureMoveToStorageViewButton()
        self.registerCellId()
        self.bind()
    }
    
    static func create(with viewModel: ImageSourcesViewModel) -> ImageSourcesViewController {
        let viewController = ImageSourcesViewController()
        viewController.imageSourcesViewModel = viewModel
        return viewController
    }
    
    private func bind() {
        self.imageSourcesViewModel.imageSources.bind { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imageSourcesTableView.reloadData()
            }
        }
        self.imageSourcesViewModel.isError.bind { [weak self] isError in
            guard let self = self else { return }
            guard let error = self.imageSourcesViewModel.error.value else { return }
            if isError {
                self.presentErrorAlert(of: error)
            }
        }
    }
    
    private func presentErrorAlert(of error: Error) {
        let errorAlert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
        let addErrorAlertAction = UIAlertAction(title: "OK", style: .default)
        errorAlert.addAction(addErrorAlertAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    @objc func pressMoveToStorageViewButton() {
        self.imageSourcesViewModel.didMoveToStorageView()
    }
    
}

// MARK: - Configure subviews

extension ImageSourcesViewController {
    
    private func configureMoveToStorageViewButton() {
        self.moveToStorageViewButton.backgroundColor = .systemBlue
        self.moveToStorageViewButton.setTitle("Go to Storage", for: .normal)
        self.moveToStorageViewButton.setTitleColor(.white, for: .normal)
        self.moveToStorageViewButton.layer.cornerRadius = 10
        self.moveToStorageViewButton.addTarget(self, action: #selector(self.pressMoveToStorageViewButton), for: .touchUpInside)
    }
    
}

// MARK: - Add subviews and layout

extension ImageSourcesViewController {
    
    private func convigureBackground() {
        self.view.backgroundColor = .white
    }
    
    private func addSubviews() {
        self.view.addSubview(self.imageSourcesTableView)
        self.view.addSubview(self.moveToStorageViewButton)
    }
    
    private func configureLayout() {
        self.imageSourcesTableView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.moveToStorageViewButton.safeAreaLayoutGuide)
        }
        self.moveToStorageViewButton.snp.makeConstraints {
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(40)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-40)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
}

extension ImageSourcesViewController {
    
    private func registerCellId() {
        self.imageSourcesTableView.register(ImageSourcesTableViewCell.self, forCellReuseIdentifier: "ImageListTableViewCellID")
    }
    
}

// MARK: - TableView Protocol

extension ImageSourcesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageSourcesViewModel.imageSources.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageListTableViewCellID", for: indexPath) as? ImageSourcesTableViewCell else { return UITableViewCell() }
        cell.configure(at: indexPath.row, with: self.imageSourcesViewModel.imageSources.value[indexPath.row])
        return cell
    }
    
}

extension ImageSourcesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageUnit = self.imageSourcesViewModel.imageSources.value[indexPath.row]
        self.imageSourcesViewModel.didSelectItem(of: imageUnit)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
