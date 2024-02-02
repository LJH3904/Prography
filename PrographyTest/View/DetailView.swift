//
//  DetailView.swift
//  PrographyTest
//
//  Created by LJh on 2/2/24.
//

import SwiftUI
import UIKit

struct DetailView: View {
    @ObservedObject var unsplashStore: UnsplashStore = UnsplashStore()
    @ObservedObject var bookmarkStore: BookmarkStore
    @State var unsplash: Unsplash
    @State var id: String
    @State private var isBookmark: Bool = false
    @Binding var isSheet: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        bookmarkStore.updateBookmarkedPhotos()
                        isSheet = false
                    }, label: {
                        Image("CloseButton")
                    })
                    .padding(.horizontal)
                    
                    Text("\(unsplash.user.username)")
                        .foregroundColor(Color(.white))
                        .font(.title2)
                        .bold()
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image("Group")
                    })
                    Button(action: {
                        if isBookmark {
                            bookmarkStore.removeBookmarkedUnsplash(unsplash)
                        } else {
                            bookmarkStore.addBookmarkedUnsplash(unsplash)
                        }
                        
                        isBookmark.toggle()
                        UserDefaults.standard.set(isBookmark, forKey: "isBookmark_\(unsplash.id)")
                    }, label: {
                        Image("bookmark")
                            .opacity(isBookmark ? 1 : 0.3)
                    })
                    .padding(.horizontal)
                }
                .padding(3)
                Spacer()
                AsyncImage(url: URL(string: unsplash.urls.regular)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: UIScreen.main.bounds.width - 20
                               , maxWidth: UIScreen.main.bounds.width - 20
                        )
                        .cornerRadius(10)
                } placeholder: {
                    SkeletonView(size: CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: 300))
                }
                .padding()
                Spacer()
                
                Group {
                    VStack {
                        HStack {
                            Text(unsplash.title)
                                .font(.title)
                                .foregroundColor(Color(.white))
                            Spacer()
                        }
                        HStack {
                            Text("\(unsplash.description ?? "No Description")")
                                .lineLimit(2)
                                .foregroundColor(Color(.white))
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                if let tags = unsplashStore.searchPhoto.tags {
                                    ForEach(tags, id: \.self) { tag in
                                        Text("#\(tag.title)")
                                            .foregroundColor(Color(.white))
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }.padding(20)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.black).opacity(0.8)
        )
        .background(ClearBackground())
        .onAppear() {
            unsplashStore.fetchSearchPhoto(id: unsplash.id)
            isBookmark = UserDefaults.standard.bool(forKey: "isBookmark_\(unsplash.id)")
        }
    }
}

