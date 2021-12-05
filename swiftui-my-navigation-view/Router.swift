//
//  Router.swift
//  swiftui-my-navigation-view
//
//  Created by Mateus Rodrigues on 01/06/21.
//

import SwiftUI


class Router: ObservableObject {
    
    var navigationController: UINavigationController?

    func push<Content: View>(_ content: Content, onWillDisappear: @escaping () -> Void) {
        let controller = RouterController(rootView: content, onWillDisappear: onWillDisappear)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
