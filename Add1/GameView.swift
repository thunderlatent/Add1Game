//
//  GameView.swift
//  Add1
//
//  Created by Jimmy on 2021/4/17.
//

import UIKit
import SnapKit
import Lottie
class GameView: UIView {
    //MARK: - 背景圖片
    var backgroundImageView: UIImageView =
        {
            let imageView = UIImageView()
            imageView.contentMode = ContentMode.scaleAspectFill
            imageView.image = UIImage(named: "background")
            return imageView
        }()
    
    //MARK: - 分數背景圖片
    var scoreImageView: UIImageView =
        {
           let imageView = UIImageView()
            imageView.image = UIImage(named: "score")
            return imageView
        }()
    
    //MARK: - 分數標籤
    var scoreLabel: UILabel =
        {
           let label = UILabel()
            label.textColor = .white
            label.font = UIFont(name: "HVDComicSerifPro", size: 30)
            label.textAlignment = .right
            label.text = "0"
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
    
    //MARK: - 時間背景圖片
    var timeImageView: UIImageView =
        {
           let imageView = UIImageView()
            imageView.image = UIImage(named: "time")
            return imageView
        }()
    
    //MARK: - 時間標籤
    var timeLabel: UILabel =
        {
           let label = UILabel()
            label.textColor = .white
            label.font = UIFont(name: "HVDComicSerifPro", size: 30)
            label.textAlignment = .left
            label.text = "00:00"
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
    
    //MARK: - 數字背景圖片
    var numberImageView: UIImageView =
        {
           let imageView = UIImageView()
            imageView.image = UIImage(named: "number")
            return imageView
        }()
    
    //MARK: - 數字標籤
    var numberLabel: UILabel =
        {
           let label = UILabel()
            label.textColor = UIColor(red: 135/255, green: 79/255, blue: 33/255, alpha: 1)
            label.font = UIFont(name: "HVDComicSerifPro", size: 70)
            label.textAlignment = .center
            label.text = "1234"
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
    
    //MARK: - 輸入框
    var inputNumberLabel: UILabel =
        {
            let label = UILabel()

            label.textColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
            label.font = UIFont(name: "HVDComicSerifPro", size: 70)
            label.textAlignment = .center
            label.text = ""
            label.adjustsFontSizeToFitWidth = true
            label.backgroundColor = #colorLiteral(red: 0.631191766, green: 1, blue: 0.4405755412, alpha: 1)
            return label
        }()
    
    //MARK: - 答案正確提示
    var correctImageView: UIImageView =
        {
            let imageView = UIImageView(image: UIImage(named: "correct"))
            imageView.isHidden = true
            return imageView
        }()
    
    //MARK: - 答案錯誤提示
    var failImageView: UIImageView =
        {
            let imageView = UIImageView(image: UIImage(named: "fail"))
            imageView.isHidden = true
            return imageView
        }()

    //MARK: - 按鍵集合
     var buttonCollectionView: UICollectionView =
        {
            
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            
            //        設定collectionView的大小
            let collectionView = UICollectionView(frame: .zero ,collectionViewLayout: layout)
            // section與section之間的距離(如果只有一個section，可以想像成frame)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            // cell與cell的間距
            layout.minimumLineSpacing = 10
            
            // cell與邊界的間距，我調整過，但是不會更改，預設值是10
            layout.minimumInteritemSpacing = CGFloat(integerLiteral: 10)
            
            //滑動方向預設為垂直。注意若設為垂直，則cell的加入方式為由左至右，滿了才會換行；若是水平則由上往下，滿了才會換列
            layout.scrollDirection = UICollectionView.ScrollDirection.vertical
            
//            collectionView.isScrollEnabled = false
            
            //MARK: - 這邊暫時隨便設定，最後會在UICollectionViewDelegateFlowlayout設定cell的寬、高
            layout.itemSize = .zero
            
            collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "ButtonCollectionViewCell")
            collectionView.backgroundColor = .clear
            
           return collectionView
        }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAllUserInterface()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - 配置所有UI
    private func configureAllUserInterface()
    {
        configureBackgroundImageView()
        configureScoreImageView()
        configureScoreLabel()
        configureTimeImageView()
        configureTimeLabel()
        configureNumberImageView()
        configureNumberLabel()
        configureInputNumberLabel()
        configureAnswerCorrectImageView()
        configureAnswerFailImageView()
        configureButtonCollectionView()
    }
    
    //MARK: - 配置背景
    private func configureBackgroundImageView()
    {
        self.addSubview(backgroundImageView)
        
        self.backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        

    }

    
    //MARK: - 配置分數背景圖片
    private func configureScoreImageView()
    {
        self.addSubview(scoreImageView)
        self.scoreImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.snp.topMargin).offset(10)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalToSuperview().multipliedBy(0.06)
        }
    }
    
    //MARK: - 配置分數標籤
    private func configureScoreLabel()
    {
        self.scoreImageView.addSubview(scoreLabel)
        let inset = UIScreen.main.bounds.width * 0.06
        self.scoreLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scoreImageView).inset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().inset(inset)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
    }
    
    //MARK: - 配置時間背景圖片
    private func configureTimeImageView()
    {
        self.addSubview(timeImageView)
        self.timeImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.snp.topMargin).offset(10)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalToSuperview().multipliedBy(0.06)
        }
    }
    
    //MARK: - 配置時間標籤
    private func configureTimeLabel()
    {
        self.timeImageView.addSubview(timeLabel)
        let inset = UIScreen.main.bounds.width * 0.06
        print(inset)
        self.timeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().inset(inset)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
    }
    
    //MARK: - 配置數字背景圖片
    private func configureNumberImageView()
    {
        self.addSubview(numberImageView)
        self.numberImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
    }
    
    //MARK: - 配置數字標籤
    private func configureNumberLabel()
    {
        self.numberImageView.addSubview(numberLabel)
        
        self.numberLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(25)
//            make.center.equalToSuperview()
        }
        
    }
    
  
    
    //MARK: - 配置要顯示的數字框
    private func configureInputNumberLabel()
    {
        self.addSubview(inputNumberLabel)
        self.inputNumberLabel.snp.makeConstraints { (make) in
            make.size.equalTo(numberLabel)
            make.centerX.equalToSuperview()
            make.top.equalTo(numberImageView.snp.bottom).offset(20)
        }
        
    }
    
    //MARK: - 答案正確的提示
    private func configureAnswerCorrectImageView()
    {
        self.addSubview(correctImageView)
        
        self.correctImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(inputNumberLabel.snp.top)
            make.centerX.equalTo(inputNumberLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(correctImageView.snp.width)
            
        }
    }
    
    //MARK: - 答案錯誤的提示
    private func configureAnswerFailImageView()
    {
        self.addSubview(failImageView)
        
        self.failImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(inputNumberLabel.snp.top)
            make.centerX.equalTo(inputNumberLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(failImageView.snp.width)
            
        }
    }
    
    //MARK: - 配置按鈕CollectionView
    private func configureButtonCollectionView()
    {
        
        self.addSubview(buttonCollectionView)
        self.buttonCollectionView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview().inset(30)
            make.height.equalToSuperview().multipliedBy(0.45)
        }
        
        
    }
    
    
}
