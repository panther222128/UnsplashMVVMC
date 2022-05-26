//
//  RealmImageUnitStorage.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import Foundation
import RealmSwift

final class RealmImageSourceStorage: ImagesStorage {
 
    func insert(imageSourceStorageEntity: ImageSourceStorageEntity, completion: @escaping (Result<ImageSourceStorageEntity, Error>) -> Void) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                do {
                    try realm.write {
                        realm.add(imageSourceStorageEntity)
                        completion(.success(imageSourceStorageEntity))
                    }
                } catch {
                    let error = RealmError.saveError
                    completion(.failure(error))
                }
            } catch {
                let error = RealmError.instantiateError
                completion(.failure(error))
            }
        }
    }
    
    func fetch(completion: @escaping (Result<[ImageSourceStorageEntity], Error>) -> Void) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                let realmObjects = realm.objects(ImageSourceStorageEntity.self)
                let data = realmObjects.convertToArray(ofType: ImageSourceStorageEntity.self)
                completion(.success(data))
            } catch {
                let error = RealmError.instantiateError
                completion(.failure(error))
            }
        }
    }
    
    func remove(at index: Int, completion: @escaping (Result<ImageSourceStorageEntity, Error>) -> Void) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                do {
                    try realm.write {
                        let realmObjects = realm.objects(ImageSourceStorageEntity.self)
                        let data = realmObjects.convertToArray(ofType: ImageSourceStorageEntity.self)
                        guard let target = realmObjects.filter( { $0._id == data[index]._id } ).first else { return }
                        realm.delete(target)
                    }
                } catch {
                    let error = RealmError.removeError
                    completion(.failure(error))
                }
            } catch {
                let error = RealmError.instantiateError
                completion(.failure(error))
            }
        }
    }

}
