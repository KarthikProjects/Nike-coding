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
    func showAlertMessage()
}

class AlbumsViewViewModel {
    private var service = AlbumNetworkManager()
    var albumResponse = AlbumResponse()
    var errorMessage: String?
    weak var delegate: AlbumsViewViewModelProtocol?

    // Do the APi call
    func fetchAlbums() {
        service.dataRequest(with: Constants.URL, objectType: AlbumResponse.self) { [unowned self] (result, error) in
            guard let _ = error else {
                guard let result = result else {
                    self.showAlert()
                    return
                }
                self.albumResponse = result
                // Reload the table view with data
                self.delegate?.updateTableView()
                return
            }
            self.showAlert()
        }
    }
    
    // Show alertView if service returns any error
   private func showAlert() {
        self.errorMessage = Constants.ErrorMessage
        self.delegate?.showAlertMessage()
    }
}
