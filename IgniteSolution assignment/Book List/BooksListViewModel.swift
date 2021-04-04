//
//  BooksListViewModel.swift
//  IgniteSolution assignment
//
//  Created by Rahul Patil on 04/04/21.
//

import Foundation

protocol BooksListViewProtocol: class {
  func reloadData()
  func openWebWith(url: String, with _title: String)
  func showAlert(title: String, msg: String)
  func loader(startLoading: Bool)
}

class BooksListViewModel {
  private let category: BooksCategories
  private weak var view: BooksListViewProtocol?
  private var network: NetworkClient?
  private var booksList = [MovieDetails]()
  private var nextURL: String?
  var isDataRequested = false
  
  init(_category: BooksCategories, _view: BooksListViewProtocol) {
    category = _category
    view = _view
    network = NetworkClient()
  }
}

extension BooksListViewModel {
  var listCount: Int {
    get {
      return booksList.count
    }
  }
  
  func getBookData(for index: Int) -> MovieDetails {
    return booksList[index]
  }
  
  func getBooksData() {
    isDataRequested = true
    let url = APIConstants.DOMAIN.rawValue + APIConstants.BOOKS_WITH_CATEGORY.rawValue + category.rawValue
    network?.fetch(url: url, object: BooksBaseModel.self, callBack: { [weak self] (data) in
      guard let self = self else {return}
      self.nextURL = data.next
      if let list = data.results {
        self.booksList = list
        self.view?.reloadData()
        self.view?.loader(startLoading: false)
        self.isDataRequested = false
      }
    })
  }
  
  func getNextData() {
    isDataRequested = true
    if let url = nextURL {
      network?.fetch(url: url, object: BooksBaseModel.self, callBack: { [weak self] (data) in
        guard let self = self else {return}
        self.nextURL = data.next
        if let list = data.results {
          self.booksList.append(contentsOf: list)
          self.view?.reloadData()
          self.view?.loader(startLoading: false)
          self.isDataRequested = false
        }
      })
    }
  }
  
  func searchBook(for text: String) {
    isDataRequested = true
    let url = APIConstants.DOMAIN.rawValue + APIConstants.BOOKS_WITH_CATEGORY.rawValue + category.rawValue + "&search=" + text
    network?.fetch(url: url, object: BooksBaseModel.self, callBack: { [weak self] (data) in
      guard let self = self else {return}
      self.nextURL = data.next
      if let list = data.results {
        self.booksList = list
        self.view?.reloadData()
        self.view?.loader(startLoading: false)
        self.isDataRequested = false
      }
    })
  }
  
  func getItem(for index: Int) {
    let item = booksList[index]
    if let path = item.formats?.htmlPath {
      view?.openWebWith(url: path, with: item.title!)
    } else if let path = item.formats?.pdfPath {
      view?.openWebWith(url: path, with: item.title!)
    } else if let path = item.formats?.textPath {
      view?.openWebWith(url: path, with: item.title!)
    } else {
      view?.showAlert(title: "Alert", msg: "Book is not available!")
    }
  }
}


