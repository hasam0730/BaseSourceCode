//
//  UIWindow+Extension.swift
//  BaseSourceCode
//
//  Created by hasam on 8/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

extension UIWindow {
    class func topViewController() -> UIViewController? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window,
            let rootView = window.rootViewController else { return nil }
        if let nav = rootView as? UINavigationController {
            return nav.visibleViewController
        }
        if let tabbar = rootView as? UITabBarController {
            return tabbar.selectedViewController
        }
        return rootView
    }
}
