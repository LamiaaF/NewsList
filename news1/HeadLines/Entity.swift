//
//  Entity.swift
//  news1
//
//  Created by Lamiaa on 2023-12-11.
//

import Foundation

struct NewsApiResponse: Codable {
    let articles: [HeadLines]
    // Add other properties if needed
}

struct HeadLines: Codable {
   
    let author: String?
    let title: String?
    let description: String?
    let urlToImage:String?
    let content: String?
    let publishedAt: String?
    
  
}
