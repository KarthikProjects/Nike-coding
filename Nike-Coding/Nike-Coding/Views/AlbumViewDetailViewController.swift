//
//  AlbumViewDetailViewController.swift
//  Nike-Coding
//
//  Created by karthik  kumar padala on 3/12/20.
//  Copyright © 2020 Nike. All rights reserved.
//

import UIKit

class AlbumViewDetailViewController: UIViewController {
    var viewModel: AlbumViewDetailViewModel!
    let albumImage = UIImageView()
    let albumName = UILabel().createBoldLabel(fontSize: 20, fontColor: .white)
    let artistName = UILabel().createLabel(fontSize: 16, fontColor: .gray)
    let genreName = UILabel().createLabel(fontSize: 16, fontColor: .gray)
    let releaseDate = UILabel().createLabel(fontSize: 16, fontColor: .gray)
    let copyRight = UILabel().createLabel(fontSize: 16, fontColor: .gray)
    let itunesButton: ItunesButton = ItunesButton().BuildButton(backgroundColor: UIColor(red: 235.0/255, green: 68.0/255, blue: 90.0/255, alpha: 1.0), buttonText: "itunes Store", buttonTextColor: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildScreen()
    }
    
    func buildScreen() {
        view.backgroundColor = .black
        let scrollView = UIScrollView()
        var contentStackView = UIStackView()
        
        var safeArea = UILayoutGuide()
        safeArea = view.layoutMarginsGuide
        let width = safeArea.layoutFrame.size.width
        let height = safeArea.layoutFrame.size.height
        
        view.addSubview(scrollView)
        
        scrollView.setConstraints(top: safeArea.topAnchor, bottom: safeArea.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, topSpace: 0, bottomSpace: 0, leadingSpace: 0, trailingSpace: 0, width: width, height: height)
        
        albumImage.setConstraints(top: nil, bottom: nil, left: nil, right: nil, topSpace: 0, bottomSpace: 0, leadingSpace: 0, trailingSpace: 0, width: 350, height: 350)
        contentStackView = UIStackView(arrangedSubviews: [albumImage, albumName, artistName, genreName, releaseDate, copyRight])
        
        scrollView.addSubview(contentStackView)
        scrollView.addSubview(itunesButton)
        
        contentStackView.distribution = .equalSpacing
        contentStackView.spacing = 10
        contentStackView.axis = .vertical
        contentStackView.alignment = .center
        
        contentStackView.setConstraints(top: scrollView.topAnchor, bottom: nil, left: scrollView.leadingAnchor, right: scrollView.trailingAnchor, topSpace: 20, bottomSpace: 0, leadingSpace: 20, trailingSpace: 20, width: width - 40, height: 0)
        setDescriptionToLabels()
        
        itunesButton.setConstraints(top: nil, bottom: nil, left: scrollView.leadingAnchor, right: scrollView.trailingAnchor, topSpace: 0, bottomSpace: 0, leadingSpace: 20, trailingSpace: 20, width: width - 40, height: 44)
        
        NSLayoutConstraint(item: contentStackView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: itunesButton, attribute: .top, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: itunesButton, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: safeArea, attribute: .bottom, multiplier: 1.0, constant: -20.0).isActive = true
        NSLayoutConstraint(item: itunesButton, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true

        itunesButton.addTarget(self, action: #selector(iTunesButtonTapped(_:)), for: .touchUpInside)
    }
    
    func setDescriptionToLabels() {
        guard let album = viewModel.results else { return }
        albumImage.loadImageWithUrl(album.artworkUrl100)
        albumName.text = album.name
        artistName.text = "Artist name: \(album.artistName ?? "")"
        genreName.text = "Genre: \(album.genres?.first?.name ?? "")"
        releaseDate.text = "Release date: \(album.releaseDate ?? "")"
        copyRight.text = "Copy right: \(album.copyright ?? "")"
        itunesButton.url = album.artistUrl
    }
    
    @objc func iTunesButtonTapped(_ sender: ItunesButton) {
        guard let urlStr = sender.url else{
            return
        }
        
        if let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

public class ItunesButton: UIButton {
    var url : String?
}
