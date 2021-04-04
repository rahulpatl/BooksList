//
//  BooksListVC.swift
//  IgniteSolution assignment
//
//  Created by Rahul Patil on 04/04/21.
//

import UIKit

class BooksListVC: UIViewController {
  private lazy var layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    let width = (view.bounds.width / 3) - 8
    let height = width + (width / 2)
    layout.itemSize = CGSize(width: width, height: 230)
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 4
    return layout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let collection = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
    collection.register(UINib(nibName: "BookDetailsCell", bundle: nil), forCellWithReuseIdentifier: "BookDetailsCell")
    collection.contentInset = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
    collection.delegate = self
    collection.dataSource = self
    collection.scrollsToTop = true
    collection.backgroundColor = .white
    return collection
  }()
  
  private lazy var searchBar: UISearchBar = {
    let search = UISearchBar()
    search.searchBarStyle = UISearchBar.Style.default
    search.placeholder = " Search..."
    search.sizeToFit()
    search.isTranslucent = false
    search.backgroundImage = UIImage()
    search.delegate = self
    return search
  }()
  
  private var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.midX - 25, y: UIScreen.main.bounds.midY - 25, width: 50, height: 50))
//  private lazy var activityIndicator: UIActivityIndicatorView = {
//    let bounds = UIScreen.main.bounds
//    let activity = UIActivityIndicatorView(frame: CGRect(x: bounds.midX - 25, y: bounds.midY - 25, width: 50, height: 50))
//    return activity
//  }()
  var viewModel: BooksListViewModel!
  
  convenience init(category: BooksCategories) {
    self.init()
    viewModel = BooksListViewModel(_category: category, _view: self)
    title = category.rawValue
  }
  
  override func loadView() {
    super.loadView()
    view = collectionView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  private func configureUI() {
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationItem.titleView = searchBar
    viewModel.getBooksData()
    view.addSubview(activityIndicator)
    loader(startLoading: true)
  }
}

extension BooksListVC: BooksListViewProtocol {
  func loader(startLoading: Bool) {
    DispatchQueue.main.async {
      if startLoading {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
      } else {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
      }
    }
  }
  
  func openWebWith(url: String) {
    let vc = WebDisplayVC(_url: url)
    let nc = UINavigationController(rootViewController: vc)
    nc.modalPresentationStyle = .fullScreen
    present(nc, animated: true)
  }
  
  func showAlert(title: String, msg: String) {
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  func reloadData() {
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
}

extension BooksListVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.listCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookDetailsCell", for: indexPath) as? BookDetailsCell
    cell?.update(data: viewModel.getBookData(for: indexPath.row))
    return cell!
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if (viewModel.listCount - 6) < indexPath.item, !viewModel.isDataRequested {
      loader(startLoading: true)
      viewModel.getNextData()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.getItem(for: indexPath.item)
  }
}

extension BooksListVC: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.count > 2 {
      loader(startLoading: true)
      viewModel.searchBook(for: searchText)
    }
  }
}
