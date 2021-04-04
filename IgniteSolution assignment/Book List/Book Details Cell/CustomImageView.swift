//
//  CustomImageView.swift
//  IgniteSolution assignment
//
//  Created by Rahul Patil on 04/04/21.
//

import UIKit
let imagesCache = NSCache<NSString, AnyObject>()
class CustomImageView: UIImageView {
  var urlString: String?
  func setImg(from url: String) {
    urlString = url
    if let _image = imagesCache.object(forKey: NSString(string: url)) as? UIImage {
      image = _image
      return
    }
    
    if let url = URL(string: urlString!) {
      let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
        if let imageData = data {
          self.set(imgData: imageData, for: url.description)
        }
      }
      task.resume()
    }
  }
  
  func set(imgData: Data, for url: String) {
    if let _image = UIImage(data: imgData) {
      DispatchQueue.main.async {
        self.image = _image
        imagesCache.setObject(_image, forKey: NSString(string: url.description))
      }
    }
  }
}
