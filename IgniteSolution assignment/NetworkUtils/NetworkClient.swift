//
//  NetworkClient.swift
//  IgniteSolution assignment
//
//  Created by Rahul Patil on 03/04/21.
//

enum NetworkError: Swift.Error {
  
}

struct Abc: Codable {
  var aaa: String?
  
  enum CodingKeys: String, CodingKey {
    case aaa = "aaa"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    aaa = try values.decode(String.self, forKey: .aaa)
  }
}

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
