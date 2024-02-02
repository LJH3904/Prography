//
//  LatestPostsViewCell.swift
//  PrographyTest
//
//  Created by LJh on 2/2/24.
//

import SwiftUI

struct LatestPostsViewCell: View {
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
                    .frame(minWidth: UIScreen.main.bounds.width / 2 - 20
                           , maxWidth: UIScreen.main.bounds.width / 2 - 20
                           , maxHeight: 300)
                    .cornerRadius(10)
            } placeholder: {
                SkeletonView(size: CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: 300))
            }.overlay(
                VStack(alignment: .leading) {
                    Text("\(unsplash.title)")
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                .padding(5),
                alignment: .bottomLeading
            )
        })
        .fullScreenCover(isPresented: $isSheet, content: {
            DetailView(bookmarkStore: bookmarkStore, unsplash: unsplash, id: "", isSheet: $isSheet)
        })
    }
}

