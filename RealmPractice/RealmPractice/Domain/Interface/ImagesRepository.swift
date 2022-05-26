//
//  ImageUnitRepository.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import Foundation

protocol ImagesRepository {
    func saveImageSource(imageSource: ImageSource, completion: @escaping (Result<ImageSourceStorageEntity, Error>) -> Void)
    func fetchImageSource(completion: @escaping (Result<[ImageSource], Error>) -> Void)
    func deleteImageSource(at index: Int, completion: @escaping (Result<ImageSourceStorageEntity, Error>) -> Void)
}
