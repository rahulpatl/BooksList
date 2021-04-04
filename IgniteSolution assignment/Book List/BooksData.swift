//
//  BooksData.swift
//  IgniteSolution assignment
//
//  Created by Rahul Patil on 04/04/21.
//

import Foundation
struct BooksBaseModel: Codable {
  var count: Int?
  var next: String?
  var previous: String?
  var results: [MovieDetails]?
  
  enum CodingKeys: String, CodingKey {
    case count = "count"
    case next = "next"
    case previous = "previous"
    case results = "results"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    count = try? values.decode(Int.self, forKey: .count)
    next = try? values.decode(String.self, forKey: .next)
    previous = try? values.decode(String.self, forKey: .previous)
    results = try? values.decode([MovieDetails].self, forKey: .results)
  }
}

struct MovieDetails: Codable {
  var id: Int?
  var title: String?
  var authors: [AuthorDetails]?
  var formats: FormatsModel?
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case authors = "authors"
    case formats = "formats"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try? values.decode(Int.self, forKey: .id)
    title = try? values.decode(String.self, forKey: .title)
    authors = try values.decode([AuthorDetails].self, forKey: .authors)
    formats = try values.decode(FormatsModel.self, forKey: .formats)
  }
}

struct AuthorDetails: Codable {
  var name: String?
  var birth_year: Int?
  var death_year: Int?
  
  enum CodingKeys: String, CodingKey {
    case name = "name"
    case birth_year = "birth_year"
    case death_year = "death_year"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try? values.decode(String.self, forKey: .name)
    birth_year = try? values.decode(Int.self, forKey: .birth_year)
    death_year = try? values.decode(Int.self, forKey: .death_year)
  }
}

struct FormatsModel: Codable {
  var imagePath: String?
  var htmlPath: String?
  var textPath: String?
  var pdfPath: String?
  
  enum CodingKeys: String, CodingKey {
    case imagePath = "image/jpeg"
    case htmlPath = "text/html; charset=utf-8"
    case textPath = "text/plain; charset=utf-8"
    case pdfPath = "application/pdf"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    imagePath = try? values.decode(String.self, forKey: .imagePath)
    htmlPath = try? values.decode(String.self, forKey: .htmlPath)
    textPath = try? values.decode(String.self, forKey: .textPath)
    pdfPath = try? values.decode(String.self, forKey: .pdfPath)
  }
}
