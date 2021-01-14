//
//  MovieDetailController.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import UICircularProgressRing

class MovieDetailController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .systemBackground
        view.showsVerticalScrollIndicator = false
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bannerImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemGray5
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bannerImageOverlayView: GradientView = {
        let view = GradientView()
        view.colors = [UIColor.clear.cgColor, UIColor.systemBackground.withAlphaComponent(0.9).cgColor]
        view.endPoint = CGPoint(x: 0, y: 1)
        view.locations = [0.2, 0.8]
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .label
        view.font = .preferredFont(forTextStyle: .headline)
        view.numberOfLines = 0
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var taglineLabel: UILabel = {
        
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .secondaryLabel
        view.font = .preferredFont(forTextStyle: .caption2)
        view.numberOfLines = 0
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var durationLabel: UILabel = {
        
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .secondaryLabel
        view.font = .preferredFont(forTextStyle: .caption2)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var genresLabel: UILabel = {
        
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .tertiaryLabel
        view.font = .preferredFont(forTextStyle: .caption2)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var ratingCircle: UICircularProgressRing = {
        
        let view = UICircularProgressRing()
        view.isClockwise = true
        view.style = .ontop
        view.outerRingColor = .systemGray5
        view.outerRingWidth = 2
        view.innerRingColor = .systemPink
        view.innerRingWidth = 2
        view.startAngle = -90
        view.fontColor = .label
        view.font = UIFont.systemFont(ofSize: 8)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var overviewTitleLabel: UILabel = {
        
        let view = UILabel()
        view.text = "Overview".uppercased()
        view.textAlignment = .left
        view.textColor = .secondaryLabel
        view.font = .preferredFont(forTextStyle: .subheadline)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var overviewLabel: UILabel = {
        
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .label
        view.font = .preferredFont(forTextStyle: .body)
        view.numberOfLines = 0
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var imdbButton: UIButton = {
        
        let view = UIButton(type: .system)
        view.backgroundColor = .systemYellow
        view.setTitle("See on IMDB".uppercased(), for: .normal)
        view.setTitleColor(.label, for: .normal)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.addTarget(self, action: #selector(handleImdbTap), for: .touchUpInside) // non rx
        return view
        
    }()
    
    private let disposeBag = DisposeBag()
    
    var movieId: Int = 0
    
    var imdbId: String = "" // non rx way
    
    var viewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupBinding()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        var contentHeight: CGFloat = 0
        for view in scrollView.subviews {
            contentHeight += view.frame.height
        }
        scrollView.contentSize = .init(width: view.frame.width, height: contentHeight - 100)
        
    }
    
    private func setupUI() {
        
        setupScrollView()
        setupBannerImageView()
        setupBannerImageOverlayView()
        setupRatingCircle()
        setupGenresLabel()
        setupDurationLabel()
        setupTaglineLabel()
        setupTitleLabel()
        setupOverviewTitleLabel()
        setupOverviewLabel()
        setupImdbButton()
        
    }
    
    private func setupBinding() {
        
        viewModel.fetchMovieDetailModel(id: movieId)
            .observe(on: MainScheduler.instance)
            .subscribe { [unowned self] (event) in
                guard let model = event.element else { return }
                self.configureData(with: model)
            }
            .disposed(by: disposeBag)
        
    }
    
    private func configureData(with model: MovieDetailModel) {
        
        titleLabel.text = model.title
        taglineLabel.text = model.tagline
        durationLabel.text = model.runtime
        genresLabel.text = model.genres
        ratingCircle.value = model.rating
        overviewLabel.text = model.overview
        imdbId = model.imdbId
        guard let url = URL(string: "\(Constants.imageBasePath)/w500\(model.backdropPath)") else { return }
        bannerImageView.sd_setImage(with: url)
        
    }
    
    private func setupScrollView() {
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func setupBannerImageView() {
        
        scrollView.addSubview(bannerImageView)
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.56)
        ])
        
    }
    
    private func setupBannerImageOverlayView() {
        
        scrollView.addSubview(bannerImageOverlayView)
        NSLayoutConstraint.activate([
            bannerImageOverlayView.leadingAnchor.constraint(equalTo: bannerImageView.leadingAnchor),
            bannerImageOverlayView.topAnchor.constraint(equalTo: bannerImageView.topAnchor),
            bannerImageOverlayView.trailingAnchor.constraint(equalTo: bannerImageView.trailingAnchor),
            bannerImageOverlayView.heightAnchor.constraint(equalTo: bannerImageView.heightAnchor)
        ])
        
    }
    
    private func setupRatingCircle() {
        
        scrollView.addSubview(ratingCircle)
        NSLayoutConstraint.activate([
            ratingCircle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            ratingCircle.bottomAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: -12),
            ratingCircle.widthAnchor.constraint(equalToConstant: 36),
            ratingCircle.heightAnchor.constraint(equalToConstant: 36)
        ])
        
    }
    
    private func setupGenresLabel() {
        
        scrollView.addSubview(genresLabel)
        NSLayoutConstraint.activate([
            genresLabel.bottomAnchor.constraint(equalTo: ratingCircle.bottomAnchor),
            genresLabel.leadingAnchor.constraint(equalTo: bannerImageView.leadingAnchor, constant: 12)
        ])
        
    }
    
    private func setupDurationLabel() {
        
        scrollView.addSubview(durationLabel)
        NSLayoutConstraint.activate([
            durationLabel.bottomAnchor.constraint(equalTo: genresLabel.topAnchor, constant: -4),
            durationLabel.leadingAnchor.constraint(equalTo: genresLabel.leadingAnchor)
        ])
        
    }
    
    private func setupTaglineLabel() {
        
        scrollView.addSubview(taglineLabel)
        NSLayoutConstraint.activate([
            taglineLabel.bottomAnchor.constraint(equalTo: durationLabel.topAnchor, constant: -8),
            taglineLabel.leadingAnchor.constraint(equalTo: genresLabel.leadingAnchor)
        ])
        
    }
    
    private func setupTitleLabel() {
        
        scrollView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: genresLabel.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: taglineLabel.topAnchor, constant: -4),
            titleLabel.trailingAnchor.constraint(equalTo: ratingCircle.leadingAnchor, constant: -12)
        ])
        
    }
    
    private func setupOverviewTitleLabel() {
        
        scrollView.addSubview(overviewTitleLabel)
        NSLayoutConstraint.activate([
            overviewTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewTitleLabel.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 16)
        ])
        
    }
    
    private func setupOverviewLabel() {
        
        scrollView.addSubview(overviewLabel)
        NSLayoutConstraint.activate([
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 6),
            overviewLabel.trailingAnchor.constraint(equalTo: ratingCircle.trailingAnchor)
        ])
        
    }
    
    private func setupImdbButton() {
        
        scrollView.addSubview(imdbButton)
        NSLayoutConstraint.activate([
            imdbButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            imdbButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            imdbButton.widthAnchor.constraint(equalToConstant: 140),
            imdbButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    @objc
    private func handleImdbTap() {
        
        guard let url = URL(string: "https://www.imdb.com/title/\(imdbId)") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
}
