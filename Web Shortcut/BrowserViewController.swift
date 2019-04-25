//
//  ViewController.swift
//  Toodledo
//
//  Created by Marc Shearer on 19/04/2019.
//  Copyright © 2019 Marc Shearer. All rights reserved.
//

import Cocoa
import WebKit

class BrowserViewController: NSViewController, WKUIDelegate {
    
    public static var controller: BrowserViewController!
    private var webView: WKWebView!
    
    @IBAction func homePressed(_ sender: NSButton) {
        // Browse the site again
        self.browsePage()
    }
    
    @IBAction func settingsPressed(_ sender: Any?) {
        // Settings
        self.showSettings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        BrowserViewController.controller = self
        
        // Set up web kit view
        let config = WKWebViewConfiguration()
        self.webView = WKWebView(frame: self.view.frame, configuration: config)
        self.view.addSubview(webView)
        self.webView.uiDelegate = self
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        if Settings.current.url == "" {
            // Pop-up settings - this will refresh page if saved
            self.showSettings(exitIfCancel: true)
        } else if AppDelegate.refreshPage {
            // Browse the site
            self.browsePage()
        }
        AppDelegate.refreshPage = false
    }
    
    override func viewDidLayout() {
        // Resize web view
        webView.setFrameSize(self.view.frame.size)
    }
    
    public func browsePage() {
        let urlString = Settings.current.url
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
    
    private func showSettings(exitIfCancel: Bool = false) {
        let settingsViewController: SettingsViewController = self.storyboard!.instantiateController(withIdentifier: "SettingsViewController") as! SettingsViewController
        settingsViewController.exitIfCancel = exitIfCancel
        self.presentAsSheet(settingsViewController)
    }
}
