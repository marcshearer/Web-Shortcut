//
//  SettingsViewController.swift
//  Web Shortcut
//
//  Created by Marc Shearer on 21/04/2019.
//  Copyright © 2019 Marc Shearer. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController, NSControlTextEditingDelegate {

    private var editSettings: Settings!
    public var exitIfCancel = false

    @IBOutlet private weak var urlTextField: NSTextField!
    @IBOutlet private weak var titleTextField: NSTextField!
    @IBOutlet private weak var showHomeCheckBox: NSButton!
    @IBOutlet private weak var bannerColorWell: NSColorWell!
    @IBOutlet private weak var saveButton: NSButton!
    
    @IBAction func urlChanged(_ sender: NSTextField) {
        self.editSettings.url = self.urlTextField.stringValue
        self.checkValues()
    }
    
    @IBAction func titleChanged(_ sender: NSTextField) {
        self.editSettings.title = self.titleTextField.stringValue
        self.checkValues()
    }
    
    @IBAction func showHomeChanged(_ sender: NSButton) {
        self.editSettings.showHome = (self.showHomeCheckBox.intValue != 0)
        self.checkValues()
    }
    
    @IBAction func bannerColorChanged(_ colorWell: NSColorWell) {
        self.editSettings.bannerColor = colorWell.color
        self.checkValues()
    }
    
    @IBAction func savePressed(_ sender: NSButton) {
        Settings.current = self.editSettings.copy() as! Settings
        Settings.current.save()
        self.view.window?.close()
        // Refresh settings
        BrowserWindowController.controller.applySettings()
        BrowserViewController.controller.browsePage()
    }
    
    @IBAction func cancelPressed(_ sender: NSButton) {
        self.view.window?.close()
        if self.exitIfCancel {
            for window in NSApp.windows {
                window.close()
            }
            NSApp.terminate(nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.editSettings = Settings.current.copy() as? Settings
        self.reflectValues()
        self.checkValues()

    }
    
    func controlTextDidChange(_ notification: Notification) {
        
        if let textField = notification.object as? NSTextField {
            
            switch textField.tag {
            case 1:
                // URL
                self.editSettings.url = self.urlTextField.stringValue
            case 2:
                // Title
                self.editSettings.title = self.titleTextField.stringValue
            default:
                break
            }
            self.checkValues()
        }
    }
    
   private func checkValues() {
        self.saveButton.isEnabled = (self.editSettings.url != "")
    }
    
    private func reflectValues() {
        self.urlTextField.stringValue = self.editSettings.url
        self.titleTextField.stringValue = self.editSettings.title
        self.showHomeCheckBox.intValue = (self.editSettings.showHome ? 1 : 0)
        self.bannerColorWell.color = self.editSettings.bannerColor
    }
    
}
