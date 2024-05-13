//
//  ViewController.swift
//  GithubFollowers
//
//  Created by Antriksh Singh on 10/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var imageView : UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "githubImage")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var animatedIcons : UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(systemName: "wifi.router")
        image.addSymbolEffect(.variableColor.iterative.reversing)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var githubText: UILabel = {
        let label = UILabel()
        label.text = "Let's Build from here"
        label.font = UIFont(name: "Avenir", size: 44)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    
    private lazy var searchInput : UITextField = {
        let input = UITextField()
        input.placeholder = "Enter Github User"
        input.borderStyle = .roundedRect
        input.textAlignment = .left
        input.autocorrectionType = .no
        input.minimumFontSize = 12
        input.autocapitalizationType = .none
        return input
    }()
    
    private lazy var searchButton : UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loadingOverlay : UIView = {
        let overlay = UIView(frame: view.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .blue
        activityIndicator.center = overlay.center
        activityIndicator.startAnimating()
        
        overlay.addSubview(activityIndicator)
        return overlay
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(animatedIcons)
        view.addSubview(imageView)
        view.addSubview(githubText)
        view.addSubview(searchInput)
        view.addSubview(searchButton)
        
        animatedIcons.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animatedIcons.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            animatedIcons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            animatedIcons.widthAnchor.constraint(equalToConstant: 50),
            animatedIcons.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        
        githubText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            githubText.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            githubText.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            githubText.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        ])
        
        
        searchInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchInput.topAnchor.constraint(equalTo: githubText.bottomAnchor, constant: 20),
            searchInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: searchInput.trailingAnchor, constant: 10),
            searchButton.centerYAnchor.constraint(equalTo: searchInput.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 75),
            searchButton.heightAnchor.constraint(equalToConstant: 35),
        ])
        
    }
    
    @objc func searchButtonTapped(){
        guard let searchText = searchInput.text, !searchText.isEmpty else{
            return
        }
        
        view.addSubview(loadingOverlay)
        
        let urlString = "https://api.github.com/users/\(searchText)/followers"
        
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            DispatchQueue.main.async {
                self?.loadingOverlay.removeFromSuperview()
            }
            
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            guard let data = data else{
                print("No Data returned")
                return
            }
            
            do {
                let followers = try JSONDecoder().decode([Followers].self, from: data)
                
                let favoritesVC = FavoritesViewController()
                favoritesVC.followers = followers
                DispatchQueue.main.async {
                    self?.navigationController?.pushViewController(favoritesVC, animated: true)
                }
                
            } catch {
                print("Error decoding data: \(error)")
            }
        
        }
        task.resume()
    }

}

