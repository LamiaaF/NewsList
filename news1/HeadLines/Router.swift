//
//  Router.swift
//  news1
//
//  Created by Lamiaa on 2023-12-11.
//

import Foundation
import UIKit

typealias EntryPoint = HeadLinesView & UIViewController
protocol HeadLinesRouter {
    var entry:EntryPoint?  { get }
    static func start() -> HeadLinesRouter
    func navigateToArticleDetail(with article: HeadLines)

    
}

class NewsListRouter : HeadLinesRouter {


    var entry: EntryPoint?
    static func start() -> HeadLinesRouter{
        let router = NewsListRouter()
        
        
        
     
        
        // asign vip
        var view : HeadLinesView = NewsListViewController()
        var presenter : HeadLinesPresenter = NewsListPresenter()
        var interactor : HeadLinesInteractor = NewsListInteractor()
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        router.entry = view as? EntryPoint
        return router
    }
    func navigateToArticleDetail(with headline: HeadLines) {
        let detailViewController = NewsDetailViewController()
        detailViewController.selectedHeadline = headline
        print("Pushing to detail view controller")
        entry?.present(detailViewController, animated: true, completion: nil)
    }
      
}

 
