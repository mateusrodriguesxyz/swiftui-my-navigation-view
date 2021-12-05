//
//  ContentView.swift
//  swiftui-my-navigation-view
//
//  Created by Mateus Rodrigues on 27/05/21.
//

import SwiftUI
import Combine

struct iOSNavigationView<Content: View>: UIViewControllerRepresentable {
    
    @StateObject var router = Router()
    
    @ViewBuilder let content: Content
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let contentController = RouterController(rootView: content.environmentObject(router))
        return UINavigationController(rootViewController: contentController)
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        router.navigationController = uiViewController
    }
    
}

struct ContentView: View {
    
    @State var isActive = false
    
    var body: some View {
        iOSNavigationView {
            iOSNavigationLink(destination: Page1(), isActive: $isActive) {
                Text("Push")
            }
            .navigationItem(leading: Text("L"))
            .navigationItem(trailing: Button("Save") { print("save") })
            .navigationBarBackgroundColor(.systemRed)
        }
        .ignoresSafeArea()
    }
    
}

struct Page1: View {
    
    @Environment(\.self)
    var environmentVales
    
    @State var isActive = false
    
    var body: some View {
        VStack {
            Text("Page 1")
            iOSNavigationLink(destination: Page2(), isActive: $isActive) {
                Text("Push")
            }
        }
        .navigationItem(trailing: Button("Save") { print("save") })
        .navigationBarBackgroundColor(.systemGreen)
    }
    
}

struct Page2: View {
    
    var body: some View {
        Text("Hello World")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
