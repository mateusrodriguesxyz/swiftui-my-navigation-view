//
//  RouterController.swift
//  swiftui-my-navigation-view
//
//  Created by Mateus Rodrigues on 01/06/21.
//

import SwiftUI


class RouterController<Content: View>: UIViewController {
    
    private let rootView: Content
    
    private let onWillDisappear: () -> Void
    
    internal init(rootView: Content, onWillDisappear: @escaping () -> Void = {}) {
        self.rootView = rootView
        self.onWillDisappear = onWillDisappear
        super.init(nibName: nil, bundle: nil)
        run(rootView.onPreferenceChange(NavigationConfigurationKey.self, perform: configure(_:)))
    }
    
    func configure(_ configuration: NavigationConfiguration) {
     
        if let leading = configuration.leading {
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIHostingView(rootView: leading))
        }

        if let trailing = configuration.trailing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIHostingView(rootView: trailing))
        }
        
        navigationItem.standardAppearance = configuration.appearance
        navigationItem.compactAppearance = configuration.appearance
        navigationItem.scrollEdgeAppearance = configuration.appearance
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupSwiftUIView()
    }
    
    func setupSwiftUIView() {
        
        let hostingController = UIHostingController(rootView: rootView)
        
        addChild(hostingController)
        
        hostingController.didMove(toParent: self)
        
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onWillDisappear()
    }
    
}


fileprivate func run<T: View>(_ target: T) {
    let controller = UIHostingController(rootView: target)
    let keyWindow = UIApplication.shared.windows.first(where: \.isKeyWindow)
    keyWindow?.rootViewController?.addChild(controller)
    controller.view.sizeToFit()
    DispatchQueue.main.async {
        controller.removeFromParent()
    }
}
