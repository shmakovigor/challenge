//
//  RandomAnswerViewController.swift
//  Challenge
//
//  Created by Igor Shmakov on 08/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

final class RandomAnswerViewController: UIViewController {

    @IBOutlet weak var messageIconView: UIImageView!
    @IBOutlet weak var wheelView: UIImageView!
    
    @IBOutlet weak var anotherTaskButton: RoundedButton!
    @IBOutlet weak var goButton: GradientButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var taskCard: UIView!
    @IBOutlet weak var taskLabel: UILabel!
   
    var challenge: Challenge? {
        didSet {
            taskLabel.text = challenge?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskCard.layer.shadowColor = UIColor.myBlue.cgColor
        taskCard.layer.shadowOpacity = 0.3
        taskCard.layer.shadowRadius = 10.0
        taskCard.layer.shadowOffset = CGSize(width: 0, height: 15)
        
        prepareInitalAnimation()
        
        // Just for demonstration
        delay(0.5, closure: startInitialAnimation)
    }
    
    func prepareInitalAnimation() {
     
        taskCard.setOpacity(value: 0)
        messageIconView.setOpacity(value: 0)
        wheelView.setOpacity(value: 0)
        infoLabel.setOpacity(value: 0)
        goButton.setOpacity(value: 0)
        anotherTaskButton.setOpacity(value: 0)
    }
    
    func startInitialAnimation() {
        
        messageIconView.animateOpacity(to: 1, duration: 0.3)
        wheelView.animateScale(from: 1.4, duration: 0.25)
            
        wheelView.animateOpacity(to: 1, duration: 0.3) {
            self.startLookingForTask()
        }
    }
    
    @IBAction func backDidPress(_ sender: Any) {
        
        show(message: "Back pressed.", title: "Info")
    }
    
    @IBAction func anotherTaskDidPress(_ sender: Any) {
        
        startLookingForTask()
    }
    
    @IBAction func goDidPress(_ sender: Any) {
        
        let controller = NewChallengeViewController.controller
        controller.challenge = challenge
        navigationController?.pushViewController(controller, animated: true)
    }

    func startLookingForTask() {
        
        wheelView.rotate(duration: 1.2) {
            self.stopLookingForTask()
        }
        
        let duration: CFTimeInterval = 0.2
        
        anotherTaskButton.hide(beginTime: 0.05, scale: 0.8, duration: duration)
        goButton.hide(to: 20, duration: duration)
        taskCard.hide(scale: 0.8, to: -30, duration: duration)
        infoLabel.show(from: -20, duration: duration)
    }
    
    func stopLookingForTask() {
        
        let duration: CFTimeInterval = 0.2
        
        challenge = .random
        
        anotherTaskButton.show(beginTime: 0.05, scale: 0.8, duration: duration)
        goButton.show(from: -20, duration: duration)
        taskCard.show(scale: 0.8, from: 30, duration: duration)
        infoLabel.hide(to: 20, duration: duration)
    }
}
