//
//  CollectionViewCell.swift
//  IgniteSolution assignment
//
//  Created by Rahul Patil on 04/04/21.
//

import UIKit

class BookDetailsCell: UICollectionViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var coverImage: CustomImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureUI()
  }
  
  private func configureUI() {
    coverImage.layer.cornerRadius = 5
    coverImage.layer.borderWidth = 0.5
    coverImage.layer.borderColor = UIColor.lightGray.cgColor
  }
  
  func update(data: MovieDetails) {
    coverImage.image = nil
    titleLabel.text = data.title
    authorLabel.text = data.authors?.first?.name
    if let path = data.formats?.imagePath {
      coverImage.setImg(from: path)
    }
  }
}
