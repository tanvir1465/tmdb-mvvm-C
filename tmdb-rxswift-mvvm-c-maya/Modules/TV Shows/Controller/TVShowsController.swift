//
//  TVShowsController.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import UIKit
import RxSwift
import RxCocoa

class TVShowsController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayouts.grid)
        view.backgroundColor = .systemBackground
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    private let disposeBag = DisposeBag()
    
    var viewModel: TVShowListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = viewModel.title
        
        collectionView.register(TVShowCollectionViewCell.self, forCellWithReuseIdentifier: TVShowCollectionViewCell.id)
        
        setupUI()
        setupBinding()

    }
    
    private func setupUI() {
        
        setupCollectionView()
        
    }
    
    private func setupBinding() {
        
        viewModel.fetchTVShowViewModel()
            .observe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items) { (collectionView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCollectionViewCell.id, for: indexPath) as! TVShowCollectionViewCell
                cell.configureCell(with: element.posterImage)
                return cell
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(TVShowViewModel.self)
            .bind(to: viewModel.selectShow)
            .disposed(by: disposeBag)
        
    }
    
    private func setupCollectionView() {
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}
