//
//  Acronym.swift
//  App
//
//  Created by 李杰 on 2018/11/25.
//

import Vapor
import FluentPostgreSQL

final class Acronym: Codable {
  var id: Int?
  var short: String
  var long: String
  
  init(short: String, long: String) {
    self.short = short
    self.long = long
  }
}

extension Acronym: PostgreSQLModel {}
extension Acronym: Migration {}
extension Acronym: Content {}
extension Acronym: Parameter {}
