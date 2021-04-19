//
//  ViewController.swift
//  Add1
//
//  Created by Jimmy on 2021/4/17.
//

import UIKit

class GameController: UIViewController {
    var randomNumberString = String.randomInt(lenth: 4)
    var isCorrect = false
    var timer:Timer?
    var seconds = 60
    var score = 0
    var gameView = GameView()
    var buttonNumbers: [Int] =
        {
            var numberArray: [Int] = []
            for number in 1...9
            {
                numberArray.append(number)
            }
            return numberArray
        }()
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
    
    func resetAllStatus()
    {
        self.score = 0
        self.seconds = 60
        self.gameView.timeLabel.text = "00:00"
        self.gameView.scoreLabel.text = "0"
        self.gameView.numberLabel.text = randomNumberString
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 40) / 3
        let height = (collectionView.frame.size.width - 40) / 3
        let size = CGSize(width: width, height: height)
        return size
    }
    
}
