//
//  ListWithoutSepatorsAndMargins.swift
//  TestCasai
//
//  Created by Ezequiel Barreto on 17/11/20.
//

import SwiftUI

struct ListWithoutSepatorsAndMargins<Content: View>: View {
    let content: () -> Content
    var body: some View {
        if #available(iOS 14.0, *) {
            ScrollView {
                LazyVStack(spacing: 0) {
                    self.content()
                }
            }
        } else {
            List {
                self.content()
            }
            .listStyle(PlainListStyle())
        }
    }
}
