//
//  ImageUnitEntity.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import Foundation
import RealmSwift

final class ImageSourceStorageEntity: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var urls: UrlsStorageEntity?

    convenience init(urls: UrlsStorageEntity) {
        self.init()
        self.urls = urls
    }
    
}

final class UrlsStorageEntity: EmbeddedObject {
    
    @Persisted var raw: String?
    @Persisted var full: String?
    @Persisted var regular: String?
    @Persisted var small: String?

}

