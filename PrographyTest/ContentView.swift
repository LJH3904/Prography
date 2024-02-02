//
//  ContentView.swift
//  PrographyTest
//
//  Created by LJh on 2/2/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var unsplashStore = UnsplashStore()
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            if selectedTab == 0 {
                HomeView(unsplahStore: unsplashStore)
            }
            else if selectedTab == 1 {
                CardView(unsplashStore: unsplashStore)
            }
            TabBarView(unsplashStore: unsplashStore, selectedTab: $selectedTab)
        }
    }
}

#Preview {
    ContentView()
}


#Preview {
    ContentView()
}
