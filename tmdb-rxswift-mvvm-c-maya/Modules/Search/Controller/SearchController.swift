//
//  SearchController.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import UIKit
import RxSwift
import RxCocoa

class SearchController: UIViewController {
    
    lazy var searchBar: UISearchBar = {
        
        let view = UISearchBar()
        view.tintColor = .systemPink
        view.placeholder = "Search ..."
        view.showsCancelButton = false
        return view
        
    }()
    
    lazy var searchScopeBar: UISegmentedControl = {
        
        let view = UISegmentedControl(items: ["Movies", "TV Shows"])
        view.selectedSegmentIndex = 0
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayouts.grid)
        view.backgroundColor = .systemBackground
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        
        let view = UIActivityIndicatorView()
        view.style = .medium
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
        view.hidesWhenStopped = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var errorLabel: UILabel = {
        let view = UILabel()
        view.text = "No results found"
        view.textAlignment = .center
        view.textColor = .label
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    
    private let disposeBag = DisposeBag()
    
    var viewModel: SearchListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupBinding()
    }
    
    private func setupUI() {
        
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
        
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupSearchScopeBar()
        setupCollectionView()
        setupErrorLabel()
        setupActivityIndicatorView()
        
    }
    
    private func setupBinding() {
        
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchObserver)
            .disposed(by: disposeBag)
        
        searchScopeBar.rx.value
            .bind(to: viewModel.scopeObserver)
            .disposed(by: disposeBag)
        
        viewModel.isLoading.asDriver()
            .drive(activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
                
        viewModel.content
            .drive(collectionView.rx.items) { (collectionView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as! SearchCollectionViewCell
                cell.configureCell(with: element.posterImage)
                return cell
            }
            .disposed(by: disposeBag)
        
        // very bad way to bind data or view models // must be changed // need to be done from coordinators
        collectionView.rx.modelSelected(SearchViewModel.self)
            .observe(on: MainScheduler.instance)
            .subscribe { [unowned self] (event) in
                guard let model = event.element else { return }
                switch model.type {
                case 0:
                    let controller = MovieDetailController()
                    let viewModel = MovieDetailViewModel()
                    controller.movieId = model.id
                    controller.viewModel = viewModel
                    self.present(controller, animated: true, completion: nil)
                case 1:
                    let controller = TVShowsDetailController()
                    let viewModel = TVShowDetailViewModel()
                    controller.tvShowId = model.id
                    controller.viewModel = viewModel
                    self.present(controller, animated: true, completion: nil)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)

        
    }
    
    private func setupActivityIndicatorView() {
        
        view.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatorView.widthAnchor.constraint(equalTo: view.widthAnchor),
            activityIndicatorView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
    }
    
    private func setupSearchScopeBar() {
        
        view.addSubview(searchScopeBar)
        NSLayoutConstraint.activate([
            searchScopeBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchScopeBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchScopeBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchScopeBar.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    private func setupCollectionView() {
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchScopeBar.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func setupErrorLabel() {
        
        view.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: searchScopeBar.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: searchScopeBar.trailingAnchor),
            errorLabel.topAnchor.constraint(equalTo: searchScopeBar.bottomAnchor, constant: 16),
        ])
        
    }
    
}
