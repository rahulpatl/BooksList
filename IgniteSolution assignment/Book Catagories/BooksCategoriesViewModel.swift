//
//  BooksCategoriesViewModel.swift
//  IgniteSolution assignment
//
//  Created by Rahul Patil on 04/04/21.
//

import Foundation
protocol BooksCategoriesViewModelProtocol {
  var categoryCount: Int {get}
  
}

enum BooksCategories: String, CaseIterable {
  case FICTION = "FICTION"
  case DRAMA = "DRAMA"
  case HUMOR = "HUMOR"
  case POLITICS = "POLITICS"
  case PHILOSOPHY = "PHILOSOPHY"
  case HISTORY = "HISTORY"
  case ADVANTURE = "ADVANTURE"
}


class BooksCategoriesViewModel {
  private var categories: [BooksCategories]
  
  init() {
    categories = BooksCategories.allCases
  }
}

extension BooksCategoriesViewModel: BooksCategoriesViewModelProtocol {
  var categoryCount: Int {
    get {
      return categories.count
    }
  }
  
  func elementAt(index: Int) -> BooksCategories {
    categories[index]
  }
}
