//
//  ViewController.swift
//  Game1
//
//  Created by Sanjay Katta on 09/04/19.
//  Copyright © 2019 Sahiti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var posA = 0, posB = 0
    var turnOfA = true // 0->A,1->B
    @IBOutlet var bLabel: UILabel!
    @IBOutlet var aLabel: UILabel!
    @IBOutlet var turnLabel: UILabel!
    @IBOutlet var boardView: UIView!
    @IBOutlet var diceValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        boardView.layer.borderWidth = 5
        boardView.layer.borderColor = UIColor.white.cgColor
        let playerALabel = createLabel(name: "A", posX: 0, posY: 10 , tag: 200)
        let playerBLabel = createLabel(name: "B", posX: 0 , posY: 11, tag: 300)
        
        var counter = 1
        for j in 0..<10{
            for i in 0..<10{
                boardView.addSubview(createLabel(name: "\(counter)", posX: i, posY:j,tag:counter))
                counter += 1
            }
        }
        playerALabel.layer.backgroundColor = UIColor.green.cgColor
        playerBLabel.layer.backgroundColor = UIColor.blue.cgColor
        boardView.addSubview(playerALabel)
        boardView.addSubview(playerBLabel)
    }
    func createLabel(name:String,posX:Int,posY:Int,tag:Int) -> UILabel {
        let w = boardView.frame.width/9
        let h = boardView.frame.height/9
        let width = Int(w)
        let height = Int(h)
        let label = UILabel(frame: CGRect(x: posX*width, y: posY*height, width: width, height: height))
        label.text = name
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        label.tag = tag
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.white.cgColor
        if(tag.isPrime){
            label.layer.backgroundColor = UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0).cgColor
        }
        return label
    }

    @IBAction func throwDice(_ sender: Any) {
        let diceValue = Int.random(in: 1...6)
        print(diceValue)
        diceValueLabel.text = "the value of dice is :\(diceValue)"
        if(turnOfA){
            posA += diceValue
        }else{
            posB += diceValue
        }
        if posA >= 100 {
            posA = 100
        }
        else if posB >= 100{
            posB = 100
        }
        UIView.animate(withDuration: 1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            if(self.posA != 0 && self.posA <= 100){
                self.boardView.viewWithTag(200)?.frame = (self.boardView.viewWithTag(self.posA)?.frame)!
            }
            if(self.posB != 0 && self.posA <= 100){
                self.boardView.viewWithTag(300)?.frame = (self.boardView.viewWithTag(self.posB)?.frame)!
            }
        }, completion: nil)
        
        if(posA.isPrime && posA != 100){
            posA -= 2*diceValue
            if posA<=0{
                posA = 1
            }
            UIView.animate(withDuration: 0.5, delay: 1.2, options: UIView.AnimationOptions.curveEaseIn, animations: {
                if(self.posA != 0 && self.posA <= 100){
                    self.boardView.viewWithTag(200)?.frame = (self.boardView.viewWithTag(self.posA)?.frame)!
                }
            }, completion: nil)
            
            
        }else if(posB.isPrime && posB != 100){
            posB -= 2*diceValue
            if posB<=0{
                posB = 1
            }
            UIView.animate(withDuration: 0.5, delay: 1.2, options: UIView.AnimationOptions.curveEaseIn, animations: {
                if(self.posB != 0 && self.posA <= 100){
                    self.boardView.viewWithTag(300)?.frame = (self.boardView.viewWithTag(self.posB)?.frame)!
                }
            }, completion: nil)
            
        }
        
        turnOfA = !turnOfA
        if(turnOfA){
            turnLabel.text = "PLAYER A's TURN"
        }else{
            turnLabel.text = "PLAYER B's TURN"
        }
        print("posA: \(posA), posB: \(posB)")
        aLabel.text = "posA: \(posA)"
        bLabel.text = "posB: \(posB)"
        if posA >= 100 {
            print("Player A won")
            let alert = UIAlertController(title: "GAME OVER", message: "Player A Won", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "New Game", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            turnLabel.text = "PLAYER A's TURN"
            diceValueLabel.text = "the value of dice is :"
            posA = 0
            posB = 0
            aLabel.text = "posA: \(posA)"
            bLabel.text = "posB: \(posB)"
            let w = boardView.frame.width/9
            let h = boardView.frame.height/9
            let width = Int(w)
            let height = Int(h)
            boardView.viewWithTag(200)?.frame = CGRect(x: 0, y: (10-1)*height, width: width, height: height)
            boardView.viewWithTag(300)?.frame = CGRect(x: 0, y: (11-1)*height, width: width, height: height)
        }
        else if posB >= 100{
            print("Player B won")
            let alert = UIAlertController(title: "GAME OVER", message: "Player B Won", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "New Game", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            diceValueLabel.text = "the value of dice is :"
            turnLabel.text = "PLAYER A's TURN"
            posA = 0
            posB = 0
            aLabel.text = "posA: \(posA)"
            bLabel.text = "posB: \(posB)"
            let w = boardView.frame.width/9
            let h = boardView.frame.height/9
            let width = Int(w)
            let height = Int(h)
            boardView.viewWithTag(200)?.frame = CGRect(x: 0, y: (10-1)*height, width: width, height: height)
            boardView.viewWithTag(300)?.frame = CGRect(x: 0, y: (11-1)*height, width: width, height: height)
        }
        
    }
    
}
extension Int{
    var isPrime: Bool {
        let n = self
        if n <= 1 {
            return false
        }
        if n <= 3 {
            return true && self>10 // prime more than 10
            
        }
        var i = 2
        while i*i <= n {
            if n % i == 0 {
                return false
            }
            i = i + 1
        }
        return true && self>10
    }
}
    
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
