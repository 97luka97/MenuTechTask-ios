//
//  NibReusableCell.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit

protocol NibReusableCell: AnyObject {
    static var nib: UINib? { get }
    static var cellIdentifier: String { get }
}

extension NibReusableCell {
    static var nib: UINib? { UINib(nibName: String(describing: self), bundle: Bundle(for: self)) }
    static var cellIdentifier: String { String(describing: self) }
}

extension UITableView {
    func register<T: UITableViewCell>(_ class: T.Type) where T: NibReusableCell {
        self.register(T.nib, forCellReuseIdentifier: T.cellIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ class: T.Type, for indexPath: IndexPath) -> T
        where T: NibReusableCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as? T else {
            fatalError("🔴 ")
        }
        return cell
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ class: T.Type) where T: NibReusableCell {
        self.register(T.nib, forCellWithReuseIdentifier: T.cellIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ class: T.Type, for indexPath: IndexPath) -> T
        where T: NibReusableCell {
            guard let cell = self.dequeueReusableCell(
                withReuseIdentifier: T.cellIdentifier,
                for: indexPath) as? T else {
                fatalError("🔴 ")
            }
            return cell
    }
}
