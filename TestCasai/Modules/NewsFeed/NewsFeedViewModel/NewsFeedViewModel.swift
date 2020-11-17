//
//  NewsFeedViewModel.swift
//  TestCasai
//
//  Created by Ezequiel Barreto on 17/11/20.
//

import SwiftUI

class NewsFeedViewModel: ObservableObject {
    @Published var articles: [Article] = []
    
    init() {
        getNewsFeed()
    }
}

// MARK: PUBLIC
extension NewsFeedViewModel {
    func getAcfObject(acgUnion: AcfUnion) -> AcfClass? {
        switch acgUnion {
        case .acfClass(let acfClass): return acfClass
        case.bool(_): return nil
        }
    }
    
    func getDateStringFormatted(from acgUnion: AcfUnion) -> String {
        guard let acf = getAcfObject(acgUnion: acgUnion) else { return "" }
        // MARK: TODO
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
        if let date = dateFormatter.date(from: acf.publishedAt) {
            let resultDateFormatter = DateFormatter()
            resultDateFormatter.dateFormat = "MMM dd,yyyy"
            return resultDateFormatter.string(from: date)
        }
        
        return acf.publishedAt
    }
}

// MARK: PRIVATE
extension NewsFeedViewModel {
    private func getNewsFeed() {
        guard let url = URL(string: "https://run.mocky.io/v3/2bb175de-c274-4df9-88b0-6010a4fcca6f") else { return }
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {  [weak self] in
                    do {
                        let newsFeed = try JSONDecoder().decode(NewsFeed.self, from: data)
                        self?.articles = newsFeed.articles

                    } catch  {
                        print(error.localizedDescription)
                    }
                }
            }
            
        }.resume()
    }
}
