//
//  ImageListRepository.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import Foundation

protocol ImageSourcesRepository {
    func fetchImageSource(completion: @escaping (Result<[ImageSource], Error>) -> Void)
    func fetchImageSourceUsingMoya(completion: @escaping (Result<[ImageSource], Error>) -> Void)
}
