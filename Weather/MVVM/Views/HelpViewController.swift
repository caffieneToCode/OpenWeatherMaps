//
//  HelpViewController.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHelpPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        loadHelpPage()
    }
    
    private func loadHelpPage() {
        if let request = HelpPageService.makeRequest(for: .helpPage) {
            webView?.load(request)
        }
    }
}
