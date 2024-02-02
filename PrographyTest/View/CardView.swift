//
//  CardView.swift
//  PrographyTest
//
//  Created by LJh on 2/2/24.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var unsplashStore: UnsplashStore
    @ObservedObject var bookmarkStore: BookmarkStore = BookmarkStore()
    @State private var selectedTab = 0
    @State var isSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .padding(.vertical, 10)
                Divider()
                
                if unsplashStore.randomphotos.isEmpty {
                    Spacer()
                    Text("No random photos available")
                        .foregroundColor(.red)
                        .padding()
                    Spacer()
                } else {
                    TabView(selection: $selectedTab) {
                        ForEach(unsplashStore.randomphotos.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                let geometryWidth = geometry.size.width
                                let geometryHeight = geometry.size.height
                                let geometrydd = geometry.safeAreaInsets.bottom + 10
                                
                                VStack {
                                    Rectangle()
                                        .frame(minWidth: geometryWidth, maxWidth: geometryWidth, maxHeight: geometryHeight * 0.9)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .overlay(alignment: .top, content: {
                                            Rectangle()
                                                .frame(minWidth: geometryWidth * 0.9, maxWidth: geometryWidth * 0.9, maxHeight: geometryHeight * 0.7)
                                                .foregroundColor(.black)
                                                .cornerRadius(10)
                                                .padding(.top, 10)
                                            AsyncImage(url: URL(string: unsplashStore.randomphotos[index].urls.regular)) { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(CGSize(width: geometryWidth * 0.9, height: geometryHeight * 0.5), contentMode: .fill)
                                                    .frame(width: geometryWidth * 0.9, height: geometryHeight * 0.5)
                                            } placeholder: {
                                                SkeletonView(size: CGSize(width: geometryWidth * 0.9, height: geometryHeight * 0.4))
                                            }
                                            
                                            .padding(.top, 10)
                                        })
                                        .overlay(alignment: .bottom) {
                                            VStack {
                                                HStack {
                                                    Spacer()
                                                    Button {
                                                        withAnimation {
                                                            selectedTab = max(0, selectedTab - 1)
                                                        }
                                                    } label: {
                                                        Image("NotInterestedButton")
                                                    }
                                                    
                                                    Spacer()
                                                    Button {
                                                        let nowPhoto = unsplashStore.randomphotos[selectedTab]
                                                        if !bookmarkStore.getBookmarkedUnsplash().contains(where: { $0.id == nowPhoto.id }) {
                                                            bookmarkStore.addBookmarkedUnsplash(nowPhoto)
                                                            UserDefaults.standard.set(true, forKey: "isBookmark_\(nowPhoto.id)")
                                                        }
                                                        if selectedTab < unsplashStore.randomphotos.count - 1 {
                                                            withAnimation {
                                                                selectedTab += 1
                                                            }
                                                        }
                                                    } label: {
                                                        Image("BookmarkButton")
                                                    }
                                                    Spacer()
                                                    Button {
                                                        isSheet = true
                                                    } label: {
                                                        Image("InformationButton")
                                                    }
                                                    .fullScreenCover(isPresented: $isSheet, content: {
                                                        DetailView(bookmarkStore: bookmarkStore, unsplash: unsplashStore.randomphotos[selectedTab],
                                                                   id: unsplashStore.randomphotos[selectedTab].id,
                                                                   isSheet: $isSheet)
                                                    })
                                                    Spacer()
                                                }
                                            }
                                            .padding(.bottom, geometrydd)
                                        }
                                    Spacer()
                                }
                            }
                            .padding()
                        }
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                }
            }.onAppear(perform: {
                unsplashStore.randomphotos.removeAll()
                unsplashStore.fetchRandomPhoto(count: 5)
            })
        }
    }
}
