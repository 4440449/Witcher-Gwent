//
//  GamblingTableCollectionViewCell.swift
//  Witcher
//
//  Created by Maxim Terpugov on 02.11.2022.
//

import UIKit


final class GamblingTableCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: GamblingTableCollectionViewCell.self)
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
    }
    
    // Prop
    private var quoteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Layout
    
    private func setupLayout() {
        contentView.addSubview(quoteLabel)
        quoteLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        quoteLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    
    // MARK: - Interface
    
    func setContent(_ text: String) {
        quoteLabel.text = text
    }
    
}
