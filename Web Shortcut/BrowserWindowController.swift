//
//  BrowserWindowController.swift
//  Web Shortcut
//
//  Created by Marc Shearer on 21/04/2019.
//  Copyright © 2019 Marc Shearer. All rights reserved.
//

import Cocoa

class BrowserWindowController: NSWindowController {

    static var controller: BrowserWindowController!
    
    @IBOutlet public weak var bannerTitle: NSTextField!
    @IBOutlet private weak var homeButton: NSButton!
    @IBOutlet private weak var appTitle: NSMenu!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Load settings
        Settings.current.load()
        
        if let window = window, let screen = window.screen {
            
            BrowserWindowController.controller = self
            
            let offsetFromLeftOfScreen: CGFloat = 100
            let offsetFromTopOfScreen: CGFloat = 100
            
            let screenRect = screen.visibleFrame
 
            let newOriginY = screenRect.maxY - window.frame.height - offsetFromTopOfScreen
            let newHeight = screenRect.height - 200
            let newWidth = screenRect.width - 200
            
            window.setFrame(NSRect(x: offsetFromLeftOfScreen, y: newOriginY, width: newWidth, height: newHeight), display: true)
            
            window.titlebarAppearsTransparent = true
            
            // Apply settings
            self.applySettings()
        }
    }
    
    public func applySettings() {
        window?.backgroundColor = Settings.current.bannerColor
        self.bannerTitle.stringValue = Settings.current.title
        self.homeButton.isHidden = !Settings.current.showHome
    }
}
