//
//  UItableView+Extension.swift
//  BaseSourceCode
//
//  Created by hasam on 8/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        self.register(T.self, forCellReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }
    
    func registerXibFile<T: UITableViewCell>(_ type: T.Type) {
        self.register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: String(describing: T.self))
    }
    
    func register(header: UITableViewHeaderFooterView.Type) {
        self.register(header.self, forHeaderFooterViewReuseIdentifier: String(describing: header.self))
    }
    
    //------
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                             for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        return cell
    }
    
    func dequeueCell(reuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    func dequeue<T: UITableViewHeaderFooterView>(header: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as! T
    }
}
