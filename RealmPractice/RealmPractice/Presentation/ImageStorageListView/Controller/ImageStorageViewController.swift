//
//  ImageStorageViewController.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/25.
//

import UIKit

final class ImageStorageViewController: UIViewController {
    
    private var imageStorageViewModel: ImageStorageViewModel!
    private let imageStorageTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
        self.configureLayout()
        self.registerCellId()
        self.imageStorageViewModel.didFetch()
        self.imageStorageTableView.dataSource = self
        self.imageStorageTableView.delegate = self
        self.bind()
    }
    
    private func bind() {
        self.imageStorageViewModel.imageUnit.bind { [weak self] _ in
            guard let self = self else { return }
            self.imageStorageTableView.reloadData()
        }
        self.imageStorageViewModel.isError.bind { [weak self] isError in
            guard let self = self else { return }
            guard let error = self.imageStorageViewModel.error.value else { return }
            if isError {
                self.presentErrorAlert(of: error)
            }
        }
    }
    
    static func create(with viewModel: ImageStorageViewModel) -> ImageStorageViewController {
        let viewController = ImageStorageViewController()
        viewController.imageStorageViewModel = viewModel
        return viewController
    }
    
    private func presentErrorAlert(of error: Error) {
        let errorAlert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
        let addErrorAlertAction = UIAlertAction(title: "OK", style: .default)
        errorAlert.addAction(addErrorAlertAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
}

extension ImageStorageViewController {
    
    private func registerCellId() {
        self.imageStorageTableView.register(ImageStorageCell.self, forCellReuseIdentifier: "ImageStorageCellID")
    }
    
}

extension ImageStorageViewController {
    
    private func addSubviews() {
        self.view.addSubview(self.imageStorageTableView)
    }
    
    private func configureLayout() {
        self.imageStorageTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension ImageStorageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageStorageViewModel.imageUnit.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageStorageCellID", for: indexPath) as? ImageStorageCell else { return UITableViewCell() }
        cell.configure(at: indexPath.row, imageUnits: self.imageStorageViewModel.imageUnit.value)
        return cell
    }
    
}

extension ImageStorageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "지워라") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            DispatchQueue.main.async {
                self.imageStorageViewModel.didRemove(at: indexPath.row)
                self.imageStorageViewModel.didFetch()
                self.imageStorageTableView.reloadData()
            }
            success(true)
        }
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
