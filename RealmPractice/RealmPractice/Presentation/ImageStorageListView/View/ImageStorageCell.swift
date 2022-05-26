//
//  ImageStorageImageCell.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/25.
//

import UIKit

class ImageStorageCell: UITableViewCell {
    
    private let imageUrlLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubviews()
        self.configureLayout()
        self.configureImageUrlLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubviews()
        self.configureLayout()
        self.configureImageUrlLabel()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension ImageStorageCell {
    
    func configure(at index: Int, imageUnits: [ImageSource]) {
        self.imageUrlLabel.text = imageUnits[index].urls.small
    }
    
    private func configureImageUrlLabel() {
        self.imageUrlLabel.textColor = .black
    }
    
    private func addSubviews() {
        self.addSubview(self.imageUrlLabel)
    }
    
    private func configureLayout() {
        self.imageUrlLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide)
        }
    }
    
}
