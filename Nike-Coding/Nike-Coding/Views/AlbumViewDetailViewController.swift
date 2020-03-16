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
        view.addSubview(scrollView)
        
        scrollView.setConstraints(top: safeArea.topAnchor, bottom: safeArea.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, topSpace: 0, bottomSpace: 0, leadingSpace: 0, trailingSpace: 0, width: width, height: 0)
        
        albumImage.setConstraints(top: nil, bottom: nil, left: nil, right: nil, topSpace: 0, bottomSpace: 0, leadingSpace: 0, trailingSpace: 0, width: 350, height: 350)
        contentStackView = UIStackView(arrangedSubviews: [albumImage, albumName, artistName, genreName, releaseDate, copyRight])
        
        scrollView.addSubview(contentStackView)
        
        contentStackView.distribution = .fillProportionally
        contentStackView.axis = .vertical
        contentStackView.alignment = .center
        
        contentStackView.setConstraints(top: scrollView.topAnchor, bottom: nil, left: scrollView.leadingAnchor, right: scrollView.trailingAnchor, topSpace: 20, bottomSpace: 0, leadingSpace: 20, trailingSpace: 20, width: 0, height: 0)
        setDescriptionToLabels()
        
        scrollView.addSubview(itunesButton)
        itunesButton.setConstraints(top: contentStackView.bottomAnchor, bottom: scrollView.bottomAnchor, left: scrollView.leadingAnchor, right: scrollView.trailingAnchor, topSpace: 50, bottomSpace: 20, leadingSpace: 20, trailingSpace: 20, width: 0, height: 44)
        itunesButton.addTarget(self, action: #selector(iTunesButtonTapped(_:)), for: .touchUpInside)
    }
    
    func setDescriptionToLabels() {
        guard let album = viewModel.results else { return }
        albumImage.loadImageWithUrl(album.artworkUrl100)
        albumName.text = album.name
        artistName.text = album.artistName
        genreName.text = album.genres?.first?.name
        releaseDate.text = album.releaseDate
        copyRight.text = album.copyright
        itunesButton.url = album.artistUrl
    }
    
    @objc func iTunesButtonTapped(_ sender: ItunesButton) {
        guard let urlStr = sender.url else{
            print("url is nil")
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
