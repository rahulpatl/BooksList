//
//  CategoryCell.swift
//  IgniteSolution assignment
//
//  Created by Rahul Patil on 04/04/21.
//

import UIKit

class CategoryCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var titleView: UIView!
  @IBOutlet weak var categoryImage: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    prepareUI()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  private func prepareUI() {
    titleView.layer.cornerRadius = 5
    titleView.layer.shadowRadius = 4
    titleView.layer.shadowOffset = CGSize(width: -1, height: 1)
    titleView.layer.shadowOpacity = 0.4
    titleView.layer.shadowColor = UIColor(named: "Theme")?.cgColor
  }
  
  func update(category: BooksCategories) {
    titleLabel.text = category.rawValue
    categoryImage.image = UIImage(named: category.rawValue)
  }
  
}
