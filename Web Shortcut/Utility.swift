//
//  Utility.swift
//  Web Shortcut
//
//  Created by Marc Shearer on 21/04/2019.
//  Copyright © 2019 Marc Shearer. All rights reserved.
//

import Cocoa

// MARK: - Functions to get view controllers, use main thread and wrapper system level stuff ==============

class Utility {

    public static var appDelegate: AppDelegate? {
        get {
            if let delegate = NSApplication.shared.delegate as? AppDelegate {
                return delegate
            } else {
                return nil
            }
        }
    }
}
