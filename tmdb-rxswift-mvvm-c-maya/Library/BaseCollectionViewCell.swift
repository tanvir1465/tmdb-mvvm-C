//
//  BaseCollectionViewCell.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import UIKit
import SDWebImage

class BaseCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .systemGray5
        
        setupUI()
        
    }
    
    func setupUI() {
        
        setupImageView()
        
    }
    
    func setupImageView() {
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    func configureCell(with imageUrl: String) {
        
        guard let url = URL(string: "\(Constants.imageBasePath)/w185\(imageUrl)") else { return }
        imageView.sd_setImage(with: url)
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        imageView.image = nil
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
