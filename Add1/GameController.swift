//
//  ViewController.swift
//  Add1
//
//  Created by Jimmy on 2021/4/17.
//

import UIKit

class GameController: UIViewController {
    var randomNumberString = String.randomInt(lenth: 4)
    {
        didSet
        {
            self.gameView.numberLabel.text = randomNumberString
        }
    }
    var isCorrect = false
    var timer:Timer?
    var seconds = 60
    var score = 0
    {
        didSet
        {
            self.gameView.scoreLabel.text = String(score)
        }
    }
    var gameView = GameView()
    
    
    var buttonNumbers: [String] = ["1","2","3","4","5","6","7","8","9","","0","",]
    
    
    //MARK: - 輸入框的文字
    var inputString = ""
    {
        didSet
        {
            self.gameView.inputNumberLabel.text = inputString
            
            if inputString.count == 4
            {
                verifyAnswer()
            }
        }
    }
    func verifyAnswer()
    {
        if inputString == randomNumberString.getAnswerForAdd1()
        {
            addScore(scoreDistance:1)
            randomNumberString = String.randomInt(lenth: 4)
            self.gameView.correctImageView.isHidden = false
            self.gameView.failImageView.isHidden = true
            
            
        }else
        {
            self.gameView.correctImageView.isHidden = true
            self.gameView.failImageView.isHidden = false
            
        }
    }
    
    func addScore(scoreDistance: Int)
    {
        self.score += scoreDistance
    }
    override func loadView() {
        self.view = gameView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTime()
        updateScoreLabel()
        updateRandomNumber()
        configureButtonCollectionView()
        
    }
    func updateTime()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdownTimer), userInfo: nil, repeats: true)
    }
    
    @objc func countdownTimer()
    {
        self.seconds -= 1
        updateTimeLabel()
        if seconds == 0 
        {
            timer?.invalidate()
            gameOver()
        }
    }
    
    
    func updateTimeLabel() {
        let min = seconds / 60
        let sec = seconds % 60
        self.gameView.timeLabel.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec)
    }
    
    
    func updateScoreLabel()
    {
        self.gameView.scoreLabel.text = String(self.score)
    }
    
    func updateRandomNumber()
    {
        self.randomNumberString = String.randomInt(lenth: 4)
        self.gameView.numberLabel.text = randomNumberString
    }
    
    func gameOver()
    {
        let gameOverView: UIView = UIView()
        gameOverView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        self.gameView.addSubview(gameOverView)
        gameOverView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let resetButton = UIButton()
        resetButton.backgroundColor = .systemPink
        resetButton.setTitle("重新開始", for: .normal)
        resetButton.titleLabel?.textColor = .white
        resetButton.titleLabel?.font = UIFont(name:"HVDComicSerifPro", size: 30)
        resetButton.addTarget(self, action: #selector(resetGame(sender:)), for: .touchUpInside)
        gameOverView.addSubview(resetButton)
        resetButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(gameOverView.snp.width).multipliedBy(0.3)
        }
    }
    
    @objc func resetGame(sender: UIButton)
    {
        self.score = 0
        self.seconds = 60
        self.gameView.timeLabel.text = "01:00"
        
        self.gameView.numberLabel.text = randomNumberString
        sender.superview!.removeFromSuperview()
        clearInputArea()
        
        //TODO: - 沒寫到重新計時
        updateTime()
    }
    
    func configureButtonCollectionView()
    {
        self.gameView.buttonCollectionView.delegate = self
        self.gameView.buttonCollectionView.dataSource = self
    }
}

extension GameController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    //MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        buttonNumbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as! ButtonCollectionViewCell
        cell.configureCellContent(number: buttonNumbers[indexPath.row])
        return cell
    }
    
    
    //MARK: - DelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 40) / 3
        let height = (collectionView.frame.size.height - 50) / 4
        let size = CGSize(width: width, height: height)
        return size
    }
    
    
    //MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if inputString.count == 4
        {
            clearInputArea()
        }
        inputString += String(buttonNumbers[indexPath.row])
    }
    
    func clearInputArea()
    {
        inputString = ""
        self.gameView.correctImageView.isHidden = true
        self.gameView.failImageView.isHidden = true
    }
}
