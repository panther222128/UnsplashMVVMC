//
//  ImageUnitStorage.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import Foundation

protocol ImagesStorage {
    func insert(imageSourceStorageEntity: ImageSourceStorageEntity, completion: @escaping (Result<ImageSourceStorageEntity, Error>) -> Void)
    func fetch(completion: @escaping (Result<[ImageSourceStorageEntity], Error>) -> Void)
    func remove(at index: Int, completion: @escaping (Result<ImageSourceStorageEntity, Error>) -> Void)
}
