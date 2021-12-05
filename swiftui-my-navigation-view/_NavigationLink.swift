//
//  _NavigationLink.swift
//  swiftui-my-navigation-view
//
//  Created by Mateus Rodrigues on 30/05/21.
//

import SwiftUI

struct iOSNavigationLink<Label: View, Destination: View>: View {
    
    @Environment(\.self)
    private var environmentValues
    
    @EnvironmentObject
    private var router: Router
    
    @Binding
    var isActive: Bool
    
    var destination: Destination
    
    var label: () -> Label
    
    
    internal init(destination: Destination, isActive: Binding<Bool>, label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
        self._isActive = isActive
    }
    
    var body: some View {
        Button(action: { isActive = true }, label: label)
            .onChange(of: isActive) {
                switch $0 {
                    case true:
                        router.push(_destination, onWillDisappear: { isActive = false })
                    case false:
                        return
                }
            }
    }
    
    private var _destination: some View {
        destination.environment(\.self, environmentValues)
    }
    
}
