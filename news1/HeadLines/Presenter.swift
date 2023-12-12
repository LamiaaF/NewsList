//
//  Presenter.swift
//  news1
//
//  Created by Lamiaa on 2023-12-11.
//

import Foundation
//vir

enum FetchError : Error{
    case failed
}
protocol HeadLinesPresenter{
    
    var router : HeadLinesRouter? {get set}
    var interactor : HeadLinesInteractor? {get set}
    var view : HeadLinesView? {get set }
    
    func InteractorDidFetchList( with result: Result<[HeadLines], Error>)
}



class NewsListPresenter : HeadLinesPresenter {
    var router: HeadLinesRouter?
    
    var interactor: HeadLinesInteractor?{
        didSet{
            interactor?.getNewsList()
        }
    }
    
    var view: HeadLinesView?
    
    
    
    func InteractorDidFetchList( with result: Result<[HeadLines], Error>){
        switch result {
        case.success(let newsList):
            view?.update(with: newsList)
            
        case.failure:
            view?.update(with: "Something went wrong")
        }
        
    }

}
