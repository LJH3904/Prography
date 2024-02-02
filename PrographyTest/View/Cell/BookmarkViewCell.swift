//
//  BookmarkViewCell.swift
//  PrographyTest
//
//  Created by LJh on 2/2/24.
//

import SwiftUI

struct BookmarkViewCell: View {
    @ObservedObject var bookmarkStore: BookmarkStore
    @State var unsplash: Unsplash
    @State private var isSheet: Bool = false
    
    var body: some View {
        Button(action: {
            isSheet = true
        }, label: {
            AsyncImage(url: URL(string: unsplash.urls.regular)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 100, maxWidth: 200, maxHeight: 150)
                    .cornerRadius(10)
            } placeholder: {
                SkeletonView(size: CGSize(width: 200, height: 150))
            }
        })
        .fullScreenCover(isPresented: $isSheet, content: {
            DetailView(bookmarkStore: bookmarkStore, unsplash: unsplash, id: "", isSheet: $isSheet)
        })
    }
}

