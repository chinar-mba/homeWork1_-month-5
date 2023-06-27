//
//  CharacterDetailViewController.swift
//  homeWork1
//
//  Created by Chinara on 6/20/23.
//
import UIKit

class CharacterDetailViewController: UIViewController {
    private let character: Character
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(genderLabel)
        
        setUp()
        
        nameLabel.text = character.name
        genderLabel.text = character.gender
        
//        if let imageView = character.image {
//            //imgview.image = UIImage(named: imageName)
//            ImageDownloader.downloadImage(with: imageView) { [weak self] image in
//                guard let self = self else { return }
//                DispatchQueue.main.async {
//                    self.imageView.image = image
                
        ImageDownloader.downloadImage(with: character.image) { result in
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    private func setUp() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.height.equalTo(200)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
    }
}
