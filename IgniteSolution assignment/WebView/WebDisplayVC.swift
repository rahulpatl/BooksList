//
//  WebDisplayVC.swift
//  IgniteSolution assignment
//
//  Created by Rahul Patil on 04/04/21.
//

import UIKit

class WebDisplayVC: UIViewController {
  private var url: String?
  private lazy var webView: UIWebView = {
    let webView = UIWebView()
    let request = URLRequest(url: URL(string: url!)!)
    webView.loadRequest(request)
    webView.delegate = self
    return webView
  }()
  
  convenience init(_url: String) {
    self.init()
    url = _url
  }
  
  override func loadView() {
    super.loadView()
    view = webView
  }
  

  override func viewDidLoad() {
    super.viewDidLoad()
    let request = URLRequest(url: URL(string: url!)!)
    webView.loadRequest(request)
    
    let close = UIBarButtonItem(image: UIImage(named: "Cancel"), style: .plain, target: self, action: #selector(closeTapped))
    navigationItem.leftBarButtonItem = close
  }
  
  @objc private func closeTapped() {
    dismiss(animated: true)
  }
  
}

extension WebDisplayVC: UIWebViewDelegate {
  func webViewDidStartLoad(_ webView: UIWebView) {
    
  }
  
  func webViewDidFinishLoad(_ webView: UIWebView) {
    
  }
}
