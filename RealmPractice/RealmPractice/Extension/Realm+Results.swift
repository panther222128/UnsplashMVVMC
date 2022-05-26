//
//  Realm+Results.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/25.
//

import RealmSwift

extension Results {
    
    func convertToArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
