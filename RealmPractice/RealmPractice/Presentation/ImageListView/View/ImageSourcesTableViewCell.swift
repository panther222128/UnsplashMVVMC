//
//  StickerListTableViewCell.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import UIKit

final class ImageSourcesTableViewCell: UITableViewCell {

    lazy var imageUnitImageView: CacheImageView = {
        let imageUnitImageView = CacheImageView()
        imageUnitImageView.contentMode = .scaleAspectFit
        return imageUnitImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubviews()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubviews()
        self.configureLayout()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension ImageSourcesTableViewCell {
    
    func configure(at index: Int, with imageUnit: ImageSource) {
        self.imageUnitImageView.loadImageUsingUrlString(urlString: imageUnit.urls.small)
    }
    
    private func addSubviews() {
        self.addSubview(self.imageUnitImageView)
    }
    
    private func configureLayout() {
        self.imageUnitImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
