//
//  AELayout.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit

// MARK: - Layout API

extension UIView {
    func addSubview(_ view: UIView, constraints: NSLayoutConstraint...) {
        addSubview(view, constraints: Array(constraints))
    }
    func addSubview(_ view: UIView, constraints: [NSLayoutConstraint]) {
        addSubview(view)
        view.activateConstraints(constraints)
    }

    func addSubviews(_ constraints: [UIView: [NSLayoutConstraint]]) {
        constraints.keys.forEach { addSubview($0) }
        constraints.forEach { $0.activateConstraints($1) }
    }

    func insertSubview(_ view: UIView, belowSubview subview: UIView, constraints: [NSLayoutConstraint]) {
        insertSubview(view, belowSubview: subview)
        view.activateConstraints(constraints)
    }

    func activateConstraints(_ constraints: NSLayoutConstraint...) { activateConstraints(Array(constraints)) }

    func activateConstraints(_ constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Anchor

protocol Anchorable {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension Anchorable {
    func constrainHorizontally<T: Anchorable>(
        to anchor: T,
        leadingInset: CGFloat = 0,
        trailingInset: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        [
            leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: leadingInset),
            anchor.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingInset)
        ]
    }

    func constrainVertically<T: Anchorable>(
        to anchor: T,
        topInset: CGFloat = 0,
        bottomInset: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        [
            topAnchor.constraint(equalTo: anchor.topAnchor, constant: topInset),
            anchor.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomInset)
        ]
    }

    func constrainEdges<T: Anchorable>(to anchor: T, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        let horizontally = constrainHorizontally(to: anchor, leadingInset: insets.left, trailingInset: insets.right)
        let vertically = constrainVertically(to: anchor, topInset: insets.top, bottomInset: insets.bottom)
        return horizontally + vertically
    }

    func constrainCenter<T: Anchorable>(to anchor: T) -> [NSLayoutConstraint] {
        [
            centerXAnchor.constraint(equalTo: anchor.centerXAnchor),
            centerYAnchor.constraint(equalTo: anchor.centerYAnchor)
        ]
    }

    func constrainCenter<T: Anchorable>(to anchor: T, offset: CGPoint) -> [NSLayoutConstraint] {
        [
            centerXAnchor.constraint(equalTo: anchor.centerXAnchor, constant: offset.x),
            centerYAnchor.constraint(equalTo: anchor.centerYAnchor, constant: offset.y)
        ]
    }

    func constrainSize(to size: CGSize) -> [NSLayoutConstraint] {
        [
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height)
        ]
    }
}

extension UIView: Anchorable {}
extension UILayoutGuide: Anchorable {}

// MARK: - Layout Helpers

extension NSLayoutConstraint {
    func prioritized(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

extension UIEdgeInsets {
    init(_ size: CGFloat) { self.init(top: size, left: size, bottom: size, right: size) }
}

// MARK: - UIView Helpers

extension UIView {
    convenience init(_ backgroundColor: UIColor?, frame: CGRect = .zero) {
        self.init(frame: frame)
        self.backgroundColor = backgroundColor
    }

    func embedToEdges(_ view: UIView, insets: UIEdgeInsets = .zero) {
        addSubview(view, constraints: view.constrainEdges(to: self, insets: insets))
    }

    func embedToSafeAreaLayoutGuide(_ view: UIView, insets: UIEdgeInsets = .zero) {
        addSubview(view, constraints: view.constrainEdges(to: self.safeAreaLayoutGuide, insets: insets))
    }

    func embedAtCenter(_ view: UIView) { addSubview(view, constraints: view.constrainCenter(to: self)) }

    func embedAtCenter(_ view: UIView, offset: CGPoint) {
        addSubview(view, constraints: view.constrainCenter(to: self, offset: offset))
    }

    func makeCircle() {
        layer.cornerRadius = bounds.width / 2
        clipsToBounds = true
    }
}

// MARK: - UIStackView Helpers

extension UIStackView {
    func addArrangedSubview(_ view: UIView, constraints: NSLayoutConstraint...) {
        addArrangedSubview(view, constraints: Array(constraints))
    }
    func addArrangedSubview(_ view: UIView, constraints: [NSLayoutConstraint]) {
        addArrangedSubview(view)
        view.activateConstraints(constraints)
    }

    func addArrangedSubviews(_ views: UIView...) { views.forEach { addArrangedSubview($0) } }

    func addArrangedSubviews(_ views: [UIView]) { views.forEach { addArrangedSubview($0) } }

    func reverseArrangedSubviews() {
        let reversed: [UIView] = arrangedSubviews.reversed()
        arrangedSubviews.forEach({ removeArrangedSubview($0) })
        addArrangedSubviews(reversed)
    }

    func embedWithRelativeMargins(_ view: UIView, padding: UIEdgeInsets? = nil) {
        isLayoutMarginsRelativeArrangement = true
        addArrangedSubview(view)
        if let padding = padding { layoutMargins = padding }
    }
}

// MARK: - UIViewController Helpers

/// - See: https://www.swiftbysundell.com/posts/using-child-view-controllers-as-plugins-in-swift
extension UIViewController {
    @discardableResult
    func embed<T: UIViewController>(_ child: T, customView: UIView? = nil) -> T {
        guard let presentingView = customView ?? view else { fatalError("🔴") }
        return add(
            child,
            constraints: child.view.constrainEdges(to: presentingView),
            customView: presentingView
        )
    }

    @discardableResult
    func add<T: UIViewController>(
        _ child: T,
        constraints: [NSLayoutConstraint]? = nil,
        customView: UIView? = nil
    ) -> T {
        guard let presentingView = customView ?? view else { fatalError("🔴") }
        addChild(child)
        presentingView.addSubview(child.view)
        if let constraints = constraints {
            child.view.activateConstraints(constraints)
            child.view.setNeedsUpdateConstraints()
            child.view.setNeedsLayout()
            child.view.updateConstraintsIfNeeded()
            child.view.layoutIfNeeded()
        }
        child.didMove(toParent: self)
        return child
    }

    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
        viewDidDisappear(false)
    }
}

// MARK: - UINib Helpers

/// - See: https://github.com/alisoftware/Reusable/
extension UIView {
    class func fromNib<T: UIView>() -> T {
        if let view = Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as? T {
            return view
        }
        fatalError("Failed to load view with type: \(String(describing: self))")
    }

    static func loadFromNib<T: UIView>() -> T {
        if let view = nib.instantiate(withOwner: nil, options: nil).first as? T { return view }
        fatalError("Failed to load view with type: \(String(describing: self))")
    }

    static var nib: UINib { UINib(nibName: String(describing: self), bundle: Bundle(for: self)) }
}
