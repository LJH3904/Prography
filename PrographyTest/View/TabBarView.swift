//
//  TabBarView.swift
//  PrographyTest
//
//  Created by LJh on 2/2/24.
//

import SwiftUI

struct TabBarView: View {
    @ObservedObject var unsplashStore: UnsplashStore
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                selectedTab = 0
            }) {
                Image(selectedTab == 0 ? "House" : "offHouse")
            }
            Spacer()
            Button(action: {
                selectedTab = 1
            }) {
                Image(selectedTab == 1 ? "Cards" : "offCards")
            }
            Spacer()
        }
        .font(.largeTitle)
        .padding()
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height * 0.1)
        .background(Color.black)
        .edgesIgnoringSafeArea(.bottom)
    }
}
