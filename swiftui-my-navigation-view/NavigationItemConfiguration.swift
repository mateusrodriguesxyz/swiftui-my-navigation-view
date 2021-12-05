//
//  NavigationItem.swift
//  swiftui-my-navigation-view
//
//  Created by Mateus Rodrigues on 01/06/21.
//

import SwiftUI


struct NavigationConfiguration: Equatable {
    
    var id: String = UUID().uuidString
    var leading: AnyView?
    var trailing: AnyView?
    var appearance: UINavigationBarAppearance = .init()
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
}

struct NavigationConfigurationKey: PreferenceKey {
    
    typealias Value = NavigationConfiguration
    
    static var defaultValue: Value = .init()
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
    
}

extension View {
    
    func navigationActions<L: View, T: View>(leading: L, trailing: T) -> some View {
        preference(key: NavigationConfigurationKey.self, value: .init(leading: .init(leading), trailing: .init(trailing)))
    }
    
    func navigationItem<L: View>(leading: L) -> some View {
        transformPreference(NavigationConfigurationKey.self) {
            $0.leading = .init(leading)
        }
        
    }
    
    func navigationItem<T: View>(trailing: T) -> some View {
        transformPreference(NavigationConfigurationKey.self) {
            $0.trailing = .init(trailing)
        }
    }
    
    func navigationBarBackgroundColor(_ color: UIColor) -> some View {
        transformPreference(NavigationConfigurationKey.self) {
            $0.appearance.backgroundColor = color
        }
    }
    
}
