//
//  RealmError.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import Foundation

enum RealmError: Error {
    case instantiateError
    case saveError
    case fetchError
    case deleteError
    case removeError
    case removeCacheError
    case cleanUpError
}
