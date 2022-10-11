//
//  RealmRepository.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 10.10.22.
//

import Foundation
import RealmSwift

final class RealmRepository: QuestionsRepository {
  
  static let instance = RealmRepository()
  private var realm: Realm!
  
  private init() {
    do {
      realm = try Realm()
      
    } catch(let error) {
      print("Error - \(error)")
    }
  }
  
  func save(_ question: Question) {
    do {
      try realm.write {
        realm.add(question)
      }
      
    } catch(let error) {
      print("Error - \(error)")
    }
  }
  
  func delete(_ question: Question) {
    do {
      try realm.write {
        realm.delete(question)
      }
      
    } catch(let error) {
      print("Error - \(error)")
    }
  }
  
  func update(_ question: Question) {
    guard let questionToUpdate = getQuestion(id: question._id) else { return }
    do {
      try realm.write {
        questionToUpdate.russianString = question.russianString
        questionToUpdate.englishString = question.englishString
      }
      
    } catch(let error) {
      print("Error - \(error)")
    }
  }
  
  func getQuestion(id: ObjectId) -> Question? {
    return realm.objects(Question.self).filter({ $0._id == id }).first
  }
  
  func getAll() -> [Question] {
    return Array(realm.objects(Question.self))
  }
  
  func getAllRussian() -> [String] {
    let questions = Array(realm.objects(Question.self))
    let russianStrings = questions.map { $0.russianString }
    return russianStrings
  }
  
  
  func getAllEnglish() -> [String] {
    let questions = Array(realm.objects(Question.self))
    let englishStrings = questions.map { $0.englishString }
    return englishStrings
  }
}
