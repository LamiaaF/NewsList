//
//  DetailViewController.swift
//  news1
//
//  Created by Lamiaa on 2023-12-12.
//
// DetailsViewController.swift
import Foundation
import UIKit

class NewsDetailViewController: UIViewController {

    var selectedHeadline: HeadLines?

    // Your UI components for displaying details
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        return label
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let publishedAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Detail view loaded")

        view.backgroundColor = .white
        setupUI()
        displayArticleDetails()
    }

    private func setupUI() {
        // Add your UI components to the view hierarchy using constraints

        // Example:
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

        view.addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

        view.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200), // Adjust the height as needed
        ])

        view.addSubview(publishedAtLabel)
        publishedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            publishedAtLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            publishedAtLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            publishedAtLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }



    private func displayArticleDetails() {
        guard let article = selectedHeadline else {
            return
        }

        print("Title: \(article.title ?? "No Title")")
        print("Author: \(article.author ?? "No Author")")
        print("Description: \(article.description ?? "No Description")")
        print("Image URL: \(article.urlToImage ?? "No Image URL")")
        print("Published At: \(article.publishedAt ?? "No Published Date")")

        titleLabel.text = article.title
        authorLabel.text = "Author: \(article.author ?? "Unknown")"
        contentLabel.text = article.description

        // Load and display the image asynchronously
        if let imageUrlString = article.urlToImage, let imageUrl = URL(string: imageUrlString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: imageData)
                    }
                }
            }
        }

        // Add code to display the published date
        publishedAtLabel.text = "Published at: \(article.publishedAt ?? "Unknown Date")"
    }
}
