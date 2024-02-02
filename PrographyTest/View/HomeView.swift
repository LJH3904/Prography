//
//  HomeView.swift
//  PrographyTest
//
//  Created by LJh on 2/2/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var unsplahStore: UnsplashStore
    @ObservedObject var bookmarkStore: BookmarkStore = BookmarkStore()
    @State private var isLoading: Bool = true
    @State private var pageCount: Int = 1
    
    var body: some View {
        VStack {
            Image("Logo")
                .padding(.vertical, 10)
            Divider()
            
            ScrollView(showsIndicators: false) {
                if !bookmarkStore.bookmarkedPhotos.isEmpty {
                    VStack {
                        HStack {
                            Text("북마크")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(bookmarkStore.bookmarkedPhotos.reversed()) { photo in
                                    BookmarkViewCell(bookmarkStore: bookmarkStore, unsplash: photo)
                                        .setSkeletonView(opacity: 0.5, shouldShow: isLoading)
                                }
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 12)
                }
                LazyVStack {
                    HStack {
                        Text("최신 이미지")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            ForEach(unsplahStore.photos.indices, id: \.self) { index in
                                if index % 2 == 0 {
                                    LatestPostsViewCell(bookmarkStore: bookmarkStore, unsplash: unsplahStore.photos[index])
                                        .setSkeletonView(opacity: 0.5, shouldShow: isLoading)
                                }
                            }
                        }
                        VStack(alignment: .leading) {
                            ForEach(unsplahStore.photos.indices, id: \.self) { index in
                                if index % 2 != 0 {
                                    LatestPostsViewCell(bookmarkStore: bookmarkStore, unsplash: unsplahStore.photos[index])
                                        .setSkeletonView(opacity: 0.5, shouldShow: isLoading)
                                }
                            }
                        }
                    }
                    Spacer()
                    ProgressView()
                        .onAppear() {
                            if !unsplahStore.pageEnd {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                    pageCount += 1
                                    print(pageCount)
                                    unsplahStore.fetchNextAllPhoto(page: pageCount, per_page: 10)
                                    if pageCount == 5 {
                                        print(self.unsplahStore.photos.count)
                                        self.unsplahStore.pageEnd = true
                                    }
                                }
                            }
                        }
                }
                .padding()
            }
            .onAppear {
                Task {
                    if unsplahStore.photos.isEmpty {
                        unsplahStore.fetchNextAllPhoto(page: pageCount, per_page: 10)
                    }
                    try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    HomeView(unsplahStore: UnsplashStore(), bookmarkStore: BookmarkStore())
}

