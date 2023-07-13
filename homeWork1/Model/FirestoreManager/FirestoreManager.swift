//
//  FirestoreManager.swift
//  homeWork1
//
//  Created by Chinara on 7/9/23.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    
    enum Collections: String {
        case character
        case book
    }
    
    static let shared = FirestoreManager()
    
    private let db = Firestore.firestore()
    
    private init () { }
    
    func addData(
        with collection: Collections,
        data: [String: Any]
    ) {
        db.collection(collection.rawValue).addDocument(data: data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added")
            }
        }
    }
    
    func readData(
        with collection: Collections,
        completion: @escaping(Result<[[String: Any]], Error>) -> Void
    ) {
        db.collection(collection.rawValue).getDocuments() { (querySnapshot, err) in
            if let err = err {
                completion(.failure(err))
            } else {
                let data = querySnapshot!.documents.map { $0.data() }
                completion(.success(data))
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}
