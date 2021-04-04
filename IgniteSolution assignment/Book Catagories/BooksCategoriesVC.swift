//
//  ViewController.swift
//  IgniteSolution assignment
//
//  Created by Rahul Patil on 03/04/21.
//

import UIKit

class BooksCategoriesVC: UIViewController {
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
    tableView.separatorStyle = .none
    return tableView
  }()
  private var viewModel = BooksCategoriesViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }

  override func loadView() {
    super.loadView()
    view = setupUI()
  }
  
  private func setupUI() -> UIView {
    let parentView = UIView()
    let projectDescriprionView = UIView()
    let backgroundImage = UIImageView()
    let backgroundText = UILabel()
    let titleText = UILabel()
    
    parentView.addSubview(projectDescriprionView)
    parentView.addSubview(tableView)
    projectDescriprionView.addSubview(backgroundImage)
    projectDescriprionView.addSubview(backgroundText)
    projectDescriprionView.addSubview(titleText)
    
    projectDescriprionView.translatesAutoresizingMaskIntoConstraints = false
    backgroundImage.translatesAutoresizingMaskIntoConstraints = false
    backgroundText.translatesAutoresizingMaskIntoConstraints = false
    titleText.translatesAutoresizingMaskIntoConstraints = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    projectDescriprionView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
    projectDescriprionView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
    projectDescriprionView.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
    projectDescriprionView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    
    backgroundImage.leadingAnchor.constraint(equalTo: projectDescriprionView.leadingAnchor).isActive = true
    backgroundImage.trailingAnchor.constraint(equalTo: projectDescriprionView.trailingAnchor).isActive = true
    backgroundImage.topAnchor.constraint(equalTo: projectDescriprionView.topAnchor).isActive = true
    backgroundImage.bottomAnchor.constraint(equalTo: projectDescriprionView.bottomAnchor).isActive = true
    
    titleText.leadingAnchor.constraint(equalTo: projectDescriprionView.leadingAnchor, constant: 8).isActive = true
    titleText.trailingAnchor.constraint(equalTo: projectDescriprionView.trailingAnchor, constant: 8).isActive = true
    titleText.topAnchor.constraint(equalTo: projectDescriprionView.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
    
    backgroundText.leadingAnchor.constraint(equalTo: projectDescriprionView.leadingAnchor, constant: 8).isActive = true
    backgroundText.trailingAnchor.constraint(equalTo: projectDescriprionView.trailingAnchor, constant: 8).isActive = true
    backgroundText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 8).isActive = true
    backgroundText.leadingAnchor.constraint(equalTo: projectDescriprionView.leadingAnchor, constant: 8).isActive = true
    
    tableView.topAnchor.constraint(equalTo: projectDescriprionView.bottomAnchor, constant: 8).isActive = true
    tableView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
    
    backgroundText.text = "A social cataloging website that allows you to freely search it's database of books, annotations and reviews."
    backgroundText.font = UIFont(name: "Montserrat-SemiBold", size: 17)
    backgroundText.textColor = .darkGray
    
    titleText.text = "Gutenberg \nProject"
    titleText.font = UIFont(name: "Montserrat-SemiBold", size: 34)
    titleText.textColor = UIColor(named: "Theme")
    titleText.numberOfLines = 0
    
    backgroundImage.image = UIImage(named: "ProjectBG")?.withRenderingMode(.alwaysTemplate)
    backgroundImage.tintColor = .lightGray
    backgroundText.numberOfLines = 0
    backgroundImage.contentMode = .scaleToFill
    
    projectDescriprionView.backgroundColor = .white
    parentView.backgroundColor = .white
    
    navigationController?.setNavigationBarHidden(true, animated: true)
    return parentView
  }

}

extension BooksCategoriesVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.categoryCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell
    cell?.update(category: viewModel.elementAt(index: indexPath.row))
    return cell!
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let category = viewModel.elementAt(index: indexPath.row)
    let vc = BooksListVC(category: category)
    navigationController?.pushViewController(vc, animated: true)
  }
}
