//
//  NewsFeedView.swift
//  TestCasai
//
//  Created by Ezequiel Barreto on 17/11/20.
//

import SwiftUI

struct NewsFeedView: View {
    @ObservedObject private var viewModel = NewsFeedViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.articles) { article in
                    if let article = viewModel.getAcfObject(acgUnion: article.acf) {
                        
                    }
                    NewCard(sourceName: (viewModel.getAcfObject(acgUnion: article.acf)?.source.name ?? "¿?"),
                            newsTime: viewModel.getDateStringFormatted(from: article.acf),
                            newsTitle: (viewModel.getAcfObject(acgUnion: article.acf)?.title ?? "¿?"))
                }
            }
        }
    }
}


struct NewCard: View {
    let sourceName: String
    let newsTime: String
    let newsTitle: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(Color.gray)
            VStack {
                Spacer()
                Spacer()
                HStack {
                    Text(sourceName)
                    Text(" - ")
                    Text(newsTime)
                    Spacer()
                    Spacer()
                }
                HStack {
                    Text(newsTitle)
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    Spacer()
                }
            }.padding()
        }.padding()
    }
}

struct Loader: View {
    var body: some View {
        Text("")
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
