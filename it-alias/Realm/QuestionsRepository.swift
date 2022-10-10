//
//  Repository.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 10.10.22.
//

import Foundation
import RealmSwift

protocol QuestionsRepository {
  func save(_ question: Question)
  func delete(_ question: Question)
  func update(_ question: Question)
  func getAll() -> [Question]
  func getQuestion(id: ObjectId) -> Question?
}
