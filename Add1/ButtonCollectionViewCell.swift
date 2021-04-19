//
//  ButtonCollectionViewCell.swift
//  Add1
//
//  Created by Jimmy on 2021/4/18.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    var backgroundImageView: UIImageView =
        {
             let imageView = UIImageView(image: UIImage(named: "number"))
            
            return imageView
        }()
    
    var numberLabel: UILabel =
        {
            let label = UILabel()
            label.font = UIFont(name: "HVDComicSerifPro", size: 65)
            label.textAlignment = .center
            label.textColor = .brown
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBackgroundImageView()
        configureNumberLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackgroundImageView()
    {
        self.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureNumberLabel()
    {
        backgroundImageView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview().multipliedBy(0.9)
        }
        
    }
    
    func configureCellContent(number: Int)
    {
        numberLabel.text = "\(number)"
    }
}
