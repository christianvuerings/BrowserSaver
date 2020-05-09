//
//  BrowserSaver.swift
//  BrowserSaver
//
//  Created by Christian Vuerings on 5/9/20.
//  Copyright © 2020 Christian Vuerings. All rights reserved.
//

import ScreenSaver
import WebKit

class BrowserSaverView: ScreenSaverView, WKNavigationDelegate {

    var wkWebView:WKWebView?

    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }

    override func startAnimation() {
        super.startAnimation()
        let webViewConfiguration = WKWebViewConfiguration.init()
        //webViewConfiguration.suppressesIncrementalRendering = true
        //webViewConfiguration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        let wkWebView = WKWebView.init(frame: self.bounds, configuration: webViewConfiguration)
        wkWebView.navigationDelegate = self
        self.wkWebView = wkWebView
        
        let url = URL(string: "https://christianvuerings.com")!
        wkWebView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.addSubview(webView)
    }
    
    override func stopAnimation() {
        super.stopAnimation()
        if let wkWebView = self.wkWebView {
            wkWebView.stopLoading()
            wkWebView.removeFromSuperview()
            wkWebView.navigationDelegate = nil
            self.wkWebView = nil
        }
    }
}
