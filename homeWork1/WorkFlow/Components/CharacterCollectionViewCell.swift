//
//  CharacterCollectionViewCell.swift
//  homeWork1
//
//  Created by Chinara on 6/19/23.
//

import UIKit
import SnapKit

class CharacterCollectionViewCell: UICollectionViewCell {
    

    
    static let reuseID = String(describing: CharacterCollectionViewCell.self)
    
    private lazy var nameLabel = UILabel()
    private lazy var genderLabel = UILabel()
    private lazy var characterImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(characterImageView)
        view.addArrangedSubview(vStackView)
        view.distribution = .fillProportionally
        view.axis = .horizontal
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(nameLabel)
        view.addArrangedSubview(genderLabel)
        view.distribution = .fillEqually
        view.axis = .vertical
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(hStackView)
        hStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        characterImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
    }
    
    func display(item: Character) {
        nameLabel.text = item.name.characterMask
        genderLabel.text = item.gender
            ImageDownloader.downloadImage(with: item.image) { result in
                if case .success(let image) = result {
                    DispatchQueue.main.async {
                    self.characterImageView.image = image
                }
            }
        }
    }
}
