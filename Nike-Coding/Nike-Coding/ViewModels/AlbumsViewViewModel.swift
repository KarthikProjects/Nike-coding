//
//  AlbumsViewViewModel.swift
//  Nike-Coding
//
//  Created by karthik  kumar padala on 3/12/20.
//  Copyright © 2020 Nike. All rights reserved.
//

import Foundation

protocol AlbumsViewViewModelProtocol: class {
    func updateTableView()
}

class AlbumsViewViewModel {
    private var service = AlbumNetworkManager()
    var albumResponse = AlbumResponse()
    weak var delegate: AlbumsViewViewModelProtocol?

    func fetchAlbums() {
        service.dataRequest(with: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json", objectType: AlbumResponse.self) { [unowned self] (result, error) in
            guard let result = result else { return }
            self.albumResponse = result
            self.delegate?.updateTableView()
        }
    }
}
