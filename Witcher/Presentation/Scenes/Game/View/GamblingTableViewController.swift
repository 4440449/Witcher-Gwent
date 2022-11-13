//
//  GamblingTableViewController.swift
//  Witcher
//
//  Created by Maxim Terpugov on 02.11.2022.
//

import UIKit


final class GamblingTableViewController: UIViewController,
                                   UICollectionViewDelegate,
                                   UICollectionViewDataSource {
    
    // MARK: - Dependencies
    
    private let viewModel: GamblingTableViewModelProtocol
    
    
    // MARK: - Init
    
    init(viewModel: GamblingTableViewModelProtocol,
         nibName nibNameOrNil: String? = nil,
         bundle nibBundleOrNil: Bundle? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupObservers()
        viewModel.viewDidLoad()
    }
    
    
    // MARK: - Input data flow
    
    private func setupObservers() {
        viewModel.roundScore.subscribe(observer: self) { [weak self] (ai, player) in
            self?.roundScore.text = "\(player) - \(ai)"
        }
        viewModel.aiScore.subscribe(observer: self) { [weak self] aiScore in
            self?.aiScore.text = String(aiScore)
        }
        viewModel.aiFoldButtonState.subscribe(observer: self) { [weak self] isEnabled in
            if isEnabled {
                self?.aiFoldButton.backgroundColor = .clear
            } else {
                self?.aiFoldButton.backgroundColor = .red
            }
        }
        viewModel.playerScore.subscribe(observer: self) { [weak self] playerScore in
            self?.playerScore.text = String(playerScore)
        }
        viewModel.playerIsMoveAvaiable.subscribe(observer: self) { [weak self] isAvailable in
            self?.playerFoldButton.isEnabled = isAvailable
            self?.collection.isHidden = !isAvailable
        }
        viewModel.playerFoldButtonState.subscribe(observer: self) { [weak self] isEnabled in
            self?.playerFoldButton.isEnabled = isEnabled
            if isEnabled {
                self?.playerFoldButton.backgroundColor = .clear
            } else {
                self?.playerFoldButton.backgroundColor = .red
            }
        }
        viewModel.availableCards.subscribe(observer: self) { [weak self] cards in
            self?.collection.reloadSections(IndexSet(integer: 0))
        }
        viewModel.currentRound.subscribe(observer: self) { [weak self] round in
            self?.currentRound.text = "Раунд: \(round)"
        }
        viewModel.playerGameScore.subscribe(observer: self) { [weak self] playerScore in
            self?.playerGameScore.text = "Победы: \(playerScore)"
        }
        viewModel.aiGameScore.subscribe(observer: self) { [weak self] aiScore in
            self?.aiGameScore.text = "Победы: \(aiScore)"
        }
    }
    
    
    // MARK: - UI
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.09444957227, green: 0.4422525764, blue: 0.2939453125, alpha: 1)
    }
    
    // Prop
    private lazy var playerGameScore: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aiGameScore: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currentRound: UILabel = {
        let label = UILabel()
        label.transform = .init(rotationAngle: -CGFloat.pi / 2)
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.black.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var roundScore: UILabel = {
        let label = UILabel()
        label.transform = .init(rotationAngle: -CGFloat.pi / 2)
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.black.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var aiScore: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.black.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aiFoldButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Пас",
                        for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19,
                                                    weight: .semibold)
        button.tintColor = #colorLiteral(red: 0.1818821728, green: 0.6090895534, blue: 0.9920215011, alpha: 1)
        button.layer.borderWidth = 2
        button.layer.borderColor = #colorLiteral(red: 0.1818821728, green: 0.6090895534, blue: 0.9920215011, alpha: 1).cgColor
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var playerScore: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.black.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var playerFoldButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Пас",
                        for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19,
                                                    weight: .semibold)
        button.tintColor = #colorLiteral(red: 0.1818821728, green: 0.6090895534, blue: 0.9920215011, alpha: 1)
        button.layer.borderWidth = 2
        button.layer.borderColor = #colorLiteral(red: 0.1818821728, green: 0.6090895534, blue: 0.9920215011, alpha: 1).cgColor
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(foldButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func foldButtonTapped() {
        viewModel.foldButtonTapped()
    }
    
    private lazy var collection: UICollectionView = {
        
        let collection = UICollectionView(frame: .zero
                                          ,collectionViewLayout: setupCollectionViewLayout())
        collection.register(GamblingTableCollectionViewCell.self,
                            forCellWithReuseIdentifier: GamblingTableCollectionViewCell.identifier)
        collection.backgroundColor = #colorLiteral(red: 0.09444957227, green: 0.4422525764, blue: 0.2939453125, alpha: 1)
        collection.alwaysBounceVertical = false
        collection.alwaysBounceHorizontal = true
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    // MARK: - Layout
    
    private func setupLayout() {
        view.addSubview(currentRound)
        view.addSubview(roundScore)
        view.addSubview(aiScore)
        view.addSubview(aiFoldButton)
        view.addSubview(playerScore)
        view.addSubview(playerFoldButton)
        view.addSubview(collection)
        view.addSubview(playerGameScore)
        view.addSubview(aiGameScore)
        
        currentRound.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        currentRound.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -25).isActive = true
        currentRound.widthAnchor.constraint(equalToConstant: 120).isActive = true
        currentRound.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        roundScore.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        roundScore.leadingAnchor.constraint(equalTo: currentRound.trailingAnchor, constant: -72).isActive = true
        roundScore.widthAnchor.constraint(equalToConstant: 120).isActive = true
        roundScore.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        aiScore.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        aiScore.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        aiScore.widthAnchor.constraint(equalToConstant: 120).isActive = true
        aiScore.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        aiFoldButton.topAnchor.constraint(equalTo: aiScore.bottomAnchor, constant: 20).isActive = true
        aiFoldButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        aiFoldButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        aiFoldButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collection.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        playerScore.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playerScore.bottomAnchor.constraint(equalTo: collection.topAnchor, constant: -10).isActive = true
        playerScore.widthAnchor.constraint(equalToConstant: 120).isActive = true
        playerScore.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        playerFoldButton.bottomAnchor.constraint(equalTo: playerScore.topAnchor, constant: -20).isActive = true
        playerFoldButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        playerFoldButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        playerFoldButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        playerGameScore.centerYAnchor.constraint(equalTo: playerFoldButton.centerYAnchor).isActive = true
        playerGameScore.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        playerGameScore.widthAnchor.constraint(equalToConstant: 120).isActive = true
        playerGameScore.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        aiGameScore.centerYAnchor.constraint(equalTo: aiFoldButton.centerYAnchor).isActive = true
        aiGameScore.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        aiGameScore.widthAnchor.constraint(equalToConstant: 120).isActive = true
        aiGameScore.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //CollectionView
    private func setupCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 2.5, bottom: 5, trailing: 2.5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    // MARK: - Collection Data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.availableCards.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamblingTableCollectionViewCell.identifier, for: indexPath) as? GamblingTableCollectionViewCell else { fatalError() }
        let cardDamage = String(viewModel.availableCards.value[indexPath.row].type.params().damage)
        cell.setContent(cardDamage)
        return cell
    }
    
    
    // MARK: - Collection Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectCard(at: indexPath.row)
    }
    
}

