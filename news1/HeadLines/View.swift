//
//  View.swift
//  news1
//
//  Created by Lamiaa on 2023-12-11.
//

import Foundation
import UIKit
//ref prsenter


protocol HeadLinesView{
    var presenter : HeadLinesPresenter? {get set }
    
    func update (with news: [HeadLines])
    func update (with error: String )
    func navigateToArticleDetail(with article: HeadLines)

}



class NewsListViewController: UIViewController, HeadLinesView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func navigateToArticleDetail(with article: HeadLines) {
            presenter?.router?.navigateToArticleDetail(with: article)
        }    
    

    var presenter: HeadLinesPresenter?

    private let headlinesLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Headlines"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal  // Set scroll direction to horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    var newsList: [HeadLines] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeadlinesLabel()
        setupCollectionView()
    }

    private func setupHeadlinesLabel() {
        view.addSubview(headlinesLabel)
        headlinesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headlinesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headlinesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headlinesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "cell")

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headlinesLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    func update(with newsList: [HeadLines]) {
        print("news ")
        DispatchQueue.main.async {
            self.newsList = newsList
            self.collectionView.reloadData()
        }
    }

    func update(with error: String) {
        print(error)
    }

   

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCell
        let currentHeadline = newsList[indexPath.item]

        // Configure the custom cell with data
        cell.titleLabel.text = currentHeadline.title
        cell.authorLabel.text = "Author: \(currentHeadline.author ?? "Unknown")"
        cell.descriptionLabel.text = currentHeadline.description

        // Load and display the image asynchronously
        if let imageUrlString = currentHeadline.urlToImage, let imageUrl = URL(string: imageUrlString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        // Update the cell's image view on the main thread
                        cell.newsImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item at index: \(indexPath.item)")

         let selectedHeadline = newsList[indexPath.item]
         presenter?.router?.navigateToArticleDetail(with: selectedHeadline)
     }
}

class NewsCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    let authorLabel = UILabel()
    let descriptionLabel = UILabel()
    let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel, descriptionLabel, newsImageView])
        stackView.axis = .vertical
        stackView.spacing = 8
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}


    // ...

    
