//
//  NetworkClient.swift
//  IgniteSolution assignment
//
//  Created by Rahul Patil on 03/04/21.
//


import Foundation
class NetworkClient {
  let session: URLSession
  
  init() {
    session = URLSession.shared
  }
  
  
  func fetch<T: Decodable>(url: String, object: T.Type, callBack: @escaping (T) -> Void) {
    let url = URL(string: url)!
    let task = session.dataTask(with: url) { (data, response, error) in
      if error == nil {
        let json = try! JSONDecoder().decode(object, from: data!)
        callBack(json)
      }
    }
  
    task.resume()
  }
  
}
