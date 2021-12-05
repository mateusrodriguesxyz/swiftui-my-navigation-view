//
//  UIHostingView.swift
//  swiftui-my-navigation-view
//
//  Created by Mateus Rodrigues on 01/06/21.
//

import SwiftUI

open class UIHostingView<Content: View>: UIView {
    class _UIHostingController: UIHostingController<Content> {
        weak var _navigationController: UINavigationController?
        
        override var navigationController: UINavigationController? {
            super.navigationController ?? _navigationController
        }
    }
    
    private let rootViewHostingController: _UIHostingController
    
    public var rootView: Content {
        get {
            return rootViewHostingController.rootView
        } set {
            rootViewHostingController.rootView = newValue
        }
    }
    
    public required init(rootView: Content) {
        self.rootViewHostingController = .init(rootView: rootView)
        
        super.init(frame: .zero)
        
        rootViewHostingController.view.backgroundColor = .clear
        
        addSubview(rootViewHostingController.view)
        
        rootViewHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        rootViewHostingController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        rootViewHostingController.view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        rootViewHostingController.view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rootViewHostingController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    deinit {
        print(#function)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        rootViewHostingController.sizeThatFits(in: size)
    }
    
    override open func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        rootViewHostingController.sizeThatFits(in: targetSize)
    }
    
    override open func sizeToFit() {
        if let superview = superview {
            frame.size = rootViewHostingController.sizeThatFits(in: superview.frame.size)
        }
    }
}
