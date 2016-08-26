//
//  ViewController.swift
//  RollDice
//
//  Created by greendoralvdora on 16/8/24.
//  Copyright © 2016年 lvdora. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var labRoll: UILabel!
    
    @IBOutlet var imgDice1: UIImageView!
    @IBOutlet var imgDice2: UIImageView!
    var restaurant = [1: "易众园", 2: "奇顺美食城",3: "地铁美食城",4:"黄太吉",5:"面兑面",6:"其它"]
    var timer : NSTimer?
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    var imageNumber=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareAudios();
        // Do any additional setup after loading the view.
    }
    func prepareAudios() {
        
        let coinSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("dice", ofType: "mp3")!)
        do{
            audioPlayer = try AVAudioPlayer(contentsOfURL:coinSound)
            audioPlayer.prepareToPlay()
//            audioPlayer.play()
        }catch {
            print("Error getting the audio file")
        }
    }
    func getNumber() -> UInt32{
        return arc4random()%6+1
    }
    
    func changeImage(){
        let iDice1=getNumber()
        var txtDice=String(iDice1)
        imgDice1.image=UIImage(named:"dice"+txtDice)
        let iDice2=getNumber()
        txtDice=String(iDice2)
        var iSum=(Int)(iDice1+iDice2)
        iSum = iSum%6+1
        labRoll.text=restaurant[iSum]
        imgDice2.image=UIImage(named:"dice"+txtDice)
        //播放声音
         audioPlayer.play()
        imageNumber += 1
        if imageNumber>20{
            timer?.invalidate()
            imageNumber=0
        }
    }
    func rollDice(){
        timer?.invalidate()
        timer=NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(ViewController.changeImage), userInfo: nil, repeats: true)
    }
    @IBAction func doRoll(sender: AnyObject) {
        rollDice()
    }
    
    //开始摇晃
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
         print("摇晃开始")
    }
    //摇晃结束
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        rollDice()
    }
    //禁止转屏🈲
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.Portrait
    }
}

