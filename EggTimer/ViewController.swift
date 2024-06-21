//
//  ViewController.swift
//  EggTimer
//
//  Created by Anna Pavlova on 29.05.2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleEgg: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTime = ["Soft": 300,
                   "Medium": 420,
                   "Hard": 720]
    // 300, 420, 720
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    var sound = URL(fileURLWithPath: Bundle.main.path(forResource: "alarm_sound", ofType: "mp3")!)
    var audio = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progressBar.progress = 0.0
        timer.invalidate()
        secondPassed = 0
        let hardness = sender.currentTitle!
        totalTime = eggTime[hardness]!
        titleEgg.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        
        if secondPassed < totalTime {
            progressBar.progress += 1.0/Float(totalTime)
            secondPassed += 1
            
        }
        if secondPassed == totalTime {
            timer.invalidate()
            titleEgg.text = "Done!"
            do {
                        audio = try AVAudioPlayer(contentsOf: sound)
                        audio.play()
                   } catch {
                      print("Error sound")
                   }
        }
    }
}

