//
//  interactor.swift
//  news1
//
//  Created by Lamiaa on 2023-12-11.
//

import Foundation
// ref presenter

protocol HeadLinesInteractor{
    var presenter : HeadLinesPresenter?{get set}
    func getNewsList()
}

class NewsListInteractor: HeadLinesInteractor {
    var presenter: HeadLinesPresenter?

    func getNewsList() {
        let key = "1e720f9e9cd845bea37152f911eb5dd9"
        print("Start fetching")

        // Print the URL for debugging
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(key)"
        print("URL: \(urlString)")

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            self.presenter?.InteractorDidFetchList(with: .failure(FetchError.failed))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown Error")")
                self?.presenter?.InteractorDidFetchList(with: .failure(FetchError.failed))
                return
            }

            do {
                let response = try JSONDecoder().decode(NewsApiResponse.self, from: data)
                let articles = response.articles
                self?.presenter?.InteractorDidFetchList(with: .success(articles))
            } catch {
                print("Error decoding data: \(error)")
                self?.presenter?.InteractorDidFetchList(with: .failure(error))
            }
        }

        task.resume()
    }
}




