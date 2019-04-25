//
//  Settings.swift
//  Cloud Database Maintenance
//
//  Created by Marc Shearer on 29/07/2018.
//  Copyright © 2018 Marc Shearer. All rights reserved.
//

import Foundation
import Cocoa

class Settings: NSObject, NSCopying {
    
    public static var current = Settings()
    
    var url: String
    var title: String
    var showHome: Bool
    var bannerColor: NSColor
    
    init(url: String! = "",
         title: String! = "",
         showHome: Bool! = true,
         bannerColor: NSColor = NSColor.blue) {
        
        self.url = url
        self.title = title
        self.showHome = showHome
        self.bannerColor = bannerColor
    }
    
    public func load() {
        self.url = UserDefaults.standard.string(forKey: Settings.key("url")) ?? ""
        self.title = UserDefaults.standard.string(forKey: Settings.key("title")) ?? ""
        self.showHome = UserDefaults.standard.bool(forKey: Settings.key("showHome"))
        self.bannerColor = NSColor(red: CGFloat(UserDefaults.standard.double(forKey: Settings.key("bannerColorRed"))),
                                 green: CGFloat(UserDefaults.standard.double(forKey: Settings.key("bannerColorGreen"))),
                                  blue: CGFloat(UserDefaults.standard.double(forKey: Settings.key("bannerColorBlue"))),
                                 alpha: CGFloat(UserDefaults.standard.double(forKey: Settings.key("bannerColorAlpha"))))
        
        if self.url == "" {
            // Set initial values
            self.title = ""
            self.showHome = true
            self.bannerColor = NSColor(red: 24/255, green: 88/255, blue: 142/255, alpha: 1.0)
        }
    }
    
    public func save() {
        UserDefaults.standard.set(self.url, forKey: Settings.key("url"))
        UserDefaults.standard.set(self.title, forKey: Settings.key("title"))
        UserDefaults.standard.set(self.showHome, forKey: Settings.key("showHome"))
        UserDefaults.standard.set(self.bannerColor.redComponent, forKey: Settings.key("bannerColorRed"))
        UserDefaults.standard.set(self.bannerColor.greenComponent, forKey: Settings.key("bannerColorGreen"))
        UserDefaults.standard.set(self.bannerColor.blueComponent, forKey: Settings.key("bannerColorBlue"))
        UserDefaults.standard.set(self.bannerColor.alphaComponent, forKey: Settings.key("bannerColorAlpha"))
    }
    
    public static func key(_ value: String) -> String {
        return "\((NSRunningApplication.current.executableURL?.absoluteString)!)/\(value)"
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = Settings(url: self.url,
                            title: self.title,
                            showHome: self.showHome,
                            bannerColor: self.bannerColor)
        return copy
    }
}
