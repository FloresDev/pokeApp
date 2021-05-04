

import UIKit
import WebKit
class WebViewController: UIViewController, WKNavigationDelegate {

        
        var webView: WKWebView!

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            let url = URL(string: "https://www.pokemongolive.com")!
            self.webView.load(URLRequest(url: url))
            
            let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self.webView, action: #selector(webView.reload))
            self.toolbarItems = [refreshBarButtonItem]
            self.navigationController?.isToolbarHidden = false
        }
        
        override func loadView() {
            self.webView = WKWebView()
            self.webView.navigationDelegate = self
            self.view = self.webView
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.title = self.webView.title
        }

    }
