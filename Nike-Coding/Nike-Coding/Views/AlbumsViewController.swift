//
//  ViewController.swift
//  Nike-Coding
//
//  Created by karthik  kumar padala on 3/12/20.
//  Copyright © 2020 Nike. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView!
    private var albumsTableView = UITableView()
    private var service = AlbumNetworkManager()
    private var viewModel = AlbumsViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpNavigationBar()
        setUpTableView()
        addActivityIndicator()
        activityIndicator.startAnimating()
        viewModel.fetchAlbums()
        viewModel.delegate = self
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "Top Albums"
        navigationController?.navigationBar.barTintColor = .orange
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func setUpTableView() {
        albumsTableView.separatorStyle = .none
        albumsTableView.separatorColor = .gray
        albumsTableView.backgroundColor = .black
        view.addSubview(albumsTableView)
        addConstraintsToTableView()
        
        // set delegate and datasource
        albumsTableView.delegate = self
        albumsTableView.dataSource = self
        
        // register reusable cell
        albumsTableView.register(AlbumDetailTableViewCell.self, forCellReuseIdentifier: "AlbumDetailTableViewCell")
    }
    
    private func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.color = .white
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }

    func addConstraintsToTableView() {
        albumsTableView.translatesAutoresizingMaskIntoConstraints = false
        albumsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        albumsTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        albumsTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        albumsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}


extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albumResponse.feed?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumDetailTableViewCell", for: indexPath) as! AlbumDetailTableViewCell
        guard let result = viewModel.albumResponse.feed?.results else { return cell}
        let album = result[indexPath.row]
        cell.selectionStyle = .none
        cell.albumImage.loadImageWithUrl(album.artworkUrl100)
        cell.albumName.text  = album.name
        cell.artistName.text = album.artistName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let results = viewModel.albumResponse.feed?.results else { return }
        let detailVC = AlbumViewDetailViewController()
        let detailViewModel = AlbumViewDetailViewModel(results: results[indexPath.row])
        detailVC.viewModel = detailViewModel
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension AlbumsViewController: AlbumsViewViewModelProtocol {
    func updateTableView() {
        DispatchQueue.main.async {
            self.albumsTableView.reloadData()
            self.albumsTableView.separatorStyle = .singleLine
            self.activityIndicator.stopAnimating()
        }
    }
}
