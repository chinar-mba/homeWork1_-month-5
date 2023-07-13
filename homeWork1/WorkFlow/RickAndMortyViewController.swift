//
//  RickAndMortyViewController.swift
//  homeWork1
//
//  Created by Chinara on 6/19/23.
//

import UIKit

class RickAndMortyViewController: UIViewController {
    
    private let refreshControl = UIRefreshControl()
    
    let keyChainService = KeyChainService.shared
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width, height: 90)
        layout.minimumLineSpacing = 20
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        view.delegate = self
        view.dataSource = self
        view.register(
            CharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseID
        )
        return view
    }()
    
    private let viewModel = CharactersViewModel()
    
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchCharacters()
        
        // for homework note make a 2 screen for authorization
//        viewModel.signIn(with: "996709055845") { result in
//            if case .success(let success) = result {
//                // self.viewModel.signInVerificationCode(with: <#T##String#>, completion: <#T##<<error type>>#>) how to make it 1:44
//                //refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
//            }
//        }

//        if let readPassword = keyChainService.readPassword(service: serviceName, account: accountName) {
//            print("Your password is: \(readPassword)")
//        } else {
//            print("Password not found")
//        }
//        let newPassword = "user500"
//        print(keyChainService.updatePassword(service: serviceName, account: accountName, newPassword: newPassword))
    }
    
    private func setup() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func fetchCharacters() {
        Task {
            do {
                characters = try await viewModel.fetchCharacters()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
    
//    @objc private func refresData() {
//        viewModel.didFinishFetching = { [weak self] in
//            DispatchQueue.main.async {
//                self?.refreshControl.endRefreshing()
//                self?.collectionView.reloadData()
//            }
//        }
//    }
}

private func fetchCharactersFromFirestore() {
//    FirestoreManager.shared.readData(with: .character) { result in
//        let characters = SplashUtility.mapData(data: model)
//        self.characters.append(contentsOf: characters)
//        self.collectionView.reloadData()
//    }
}

extension RickAndMortyViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return characters.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.reuseID,
            for: indexPath
        ) as! CharacterCollectionViewCell
        let model = characters[indexPath.item]
        cell.display(item: model)
        collectionView.refreshControl = refreshControl
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let selectedCharacter = characters[indexPath.item]
        let detailViewController = CharacterDetailViewController(character: selectedCharacter)
        present(detailViewController, animated: true, completion: nil)
    }
}


