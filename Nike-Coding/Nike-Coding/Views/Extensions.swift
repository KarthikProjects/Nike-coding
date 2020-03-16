//
//  Extensions.swift
//  Nike-Coding
//
//  Created by karthik  kumar padala on 3/14/20.
//  Copyright © 2020 Nike. All rights reserved.
//

import UIKit

extension UIView {
    func setConstraints(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, topSpace: CGFloat, bottomSpace: CGFloat, leadingSpace: CGFloat, trailingSpace: CGFloat, width: CGFloat, height: CGFloat, isTopConstraintActive: Bool? = true) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topSpace).isActive = isTopConstraintActive ?? true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: bottomSpace).isActive = true
        }
        if let left = left {
            self.leadingAnchor.constraint(equalTo: left, constant: leadingSpace).isActive = true
        }
        if let right = right {
            self.trailingAnchor.constraint(equalTo: right, constant: trailingSpace).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension UIButton {
    func BuildButton(backgroundColor: UIColor, buttonText: String, buttonTextColor: UIColor) -> ItunesButton {
        let button = ItunesButton(type: .system)
        button.frame = frame
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 1
        button.backgroundColor = backgroundColor
        button.setTitle(buttonText, for: .normal)
        button.setTitleColor(buttonTextColor, for: .normal)
        return button
    }
}

extension UILabel {
    func createBoldLabel(fontSize: CGFloat, fontColor: UIColor) -> UILabel {
        let boldLabel = UILabel()
        boldLabel.font = .boldSystemFont(ofSize: fontSize)
        boldLabel.textColor = fontColor
        boldLabel.numberOfLines = 0
        return boldLabel
    }
    
    func createLabel(fontSize: CGFloat, fontColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize)
        label.textColor = fontColor
        label.numberOfLines = 0
        return label
    }
}

private var imageCache = NSCache<NSString, UIImage>()
let activityIndicator = UIActivityIndicatorView()

extension UIImageView {
    
    func loadImageWithUrl(_ url: String?) {
        guard let url = url else {
            setImage(albumImage: UIImage(named: ""))
            return
        }
        guard let imageURL = URL(string: url) else { return }
        
        // setup activityIndicator...
        activityIndicator.color = .white
        
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        activityIndicator.startAnimating()
        
        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: NSString(string: url)) {
            setImage(albumImage: imageFromCache)
        } else {
            DispatchQueue.global().async {
                URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                    if let data = data {
                        imageCache.setObject(UIImage(data: data) ?? UIImage(), forKey: NSString(string: url))
                        DispatchQueue.main.async {
                            self.setImage(albumImage: UIImage(data: data))
                        }
                    }
                }.resume()
            }
        }
    }
    
    func setImage(albumImage: UIImage?) {
        guard let albumImage = albumImage else { return }
        DispatchQueue.main.async {
            self.image = albumImage
            activityIndicator.stopAnimating()
        }
    }
}
