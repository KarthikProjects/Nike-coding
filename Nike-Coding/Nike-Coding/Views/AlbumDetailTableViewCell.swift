//
//  AlbumDetailTableViewCell.swift
//  Nike-Coding
//
//  Created by karthik  kumar padala on 3/12/20.
//  Copyright © 2020 Nike. All rights reserved.
//

import UIKit

class AlbumDetailTableViewCell: UITableViewCell {
    
    let albumImage = UIImageView()
    let albumName = UILabel().createBoldLabel(fontSize: 18, fontColor: .white)
    let artistName = UILabel().createLabel(fontSize: 16, fontColor: .gray)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        addSubViewsToView()
        addConstraints()
    }
    
    func addSubViewsToView() {
        contentView.addSubview(albumImage)
        contentView.addSubview(albumName)
        contentView.addSubview(artistName)
    }
        
    func addConstraints() {
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        albumName.translatesAutoresizingMaskIntoConstraints = false
        artistName.translatesAutoresizingMaskIntoConstraints = false

        albumImage.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        albumImage.setConstraints(top: nil, bottom: nil, left: self.contentView.leadingAnchor, right: nil, topSpace: 0, bottomSpace: 0, leadingSpace: 10, trailingSpace: 0, width: 70, height: 70)
        albumName.setConstraints(top: self.contentView.topAnchor, bottom: self.artistName.topAnchor, left: self.albumImage.trailingAnchor, right: self.contentView.trailingAnchor, topSpace: 20, bottomSpace: -5, leadingSpace: 10, trailingSpace: -10, width: 0, height: 0)
        artistName.setConstraints(top: self.albumName.bottomAnchor, bottom: self.contentView.bottomAnchor, left: self.albumImage.trailingAnchor, right: self.contentView.trailingAnchor, topSpace: 0, bottomSpace: -15, leadingSpace: 10, trailingSpace: -10, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
