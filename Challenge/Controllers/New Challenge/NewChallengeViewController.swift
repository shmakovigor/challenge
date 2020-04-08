//
//  NewChallengeViewController.swift
//  Challenge
//
//  Created by Igor Shmakov on 05/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit
import UITextView_Placeholder

final class NewChallengeViewController: UIViewController, Instantinable {

    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var backButton: RoundedButton!
    @IBOutlet weak var postButton: GradientButton!
    @IBOutlet weak var keyboardButton: UIButton!
    @IBOutlet weak var keyboardConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var answerTextView: DynamicFontTextView!
    
    @IBOutlet weak var fontPickerView: UICollectionView!
    @IBOutlet weak var backgroundPickerView: UICollectionView!
    @IBOutlet weak var colorPickerView: ColorPickerView!
    
    var fontDataSource: FontStyleViewDataSource?
    var backgroundDataSource: BackgroundStyleViewDataSource?
    
    var challenge: Challenge?
    var font: FontStyle?
    var background: BackgroundStyle?
    var color: ColorStyle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        challengeNameLabel.text = challenge?.name
        keyboardButton.isHidden = true
        postButton.isEnabled = false
        
        navigationBar.layer.shadowColor = UIColor.myGray.cgColor
        navigationBar.layer.shadowOpacity = 0
        navigationBar.layer.shadowRadius = 8
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        fontDataSource = FontStyleViewDataSource(
            collection: fontPickerView,
            delegate: self
        )
        
        backgroundDataSource = BackgroundStyleViewDataSource(
            collection: backgroundPickerView,
            colorStyle: ColorStyle.defaultColors.first!,
            delegate: self
        )
        
        colorPickerView.delegate = self
        
        font = fontDataSource?.selected
        background = backgroundDataSource?.selected
        color = colorPickerView.defaultColors.first
        
        updateStyle()
        setupNotifications()
    }
    
    func setupNotifications() {
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(NewChallengeViewController.keyboardNotification(_:)),
                           name: UIResponder.keyboardWillChangeFrameNotification,
                           object: nil)
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func updateStyle() {
        
        guard
            let font = font,
            let background = background,
            let color = background.type == .color ? color : background.color 
        else {
            return
        }
        
        challengeNameLabel.textColor = color.foreground
        
        answerTextView.font = UIFont(name: font.name, size: answerTextView.font?.pointSize ?? 20)
        answerTextView.textColor = color.foreground
        answerTextView.tintColor = color.foreground
        answerTextView.placeholderColor = color.foreground.withAlphaComponent(0.3)
        
        backgroundImageView.backgroundColor = color.background
        backgroundImageView.image = background.image
    }
    
    @objc func keyboardNotification(_ notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            guard let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            guard let animationCurveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw.uintValue)
            
            didChangeKeyboardAppearence(withEndFrame: endFrame, animationDuration: duration, animationCurve: animationCurve)
        }
    }

    func didChangeKeyboardAppearence(withEndFrame frame: CGRect, animationDuration: TimeInterval, animationCurve: UIView.AnimationOptions) {
        
        guard let scrollView = scrollView else { return }
        
        let inset = scrollView.frame.height - frame.origin.y
        keyboardConstraint.constant = inset + 8
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: animationCurve, animations: {
            self.scrollView.contentInset.bottom = inset
            self.keyboardButton.isHidden = inset <= 0
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        
        view.endEditing(true)
    }
    
    @IBAction func backDidPress(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func postDidPress(_ sender: Any) {
        
        show(message: "Post pressed.", title: "Info")
    }
}


extension NewChallengeViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        postButton.isEnabled = !textView.text.isEmpty
    }
}


extension NewChallengeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        navigationBar.layer.shadowOpacity = scrollView.contentOffset.y > 0 ? 1 : 0
    }
}


extension NewChallengeViewController: FontStyleDelegate {
    
    func fontStyleDidSelect(style: FontStyle) {
        
        font = style
        updateStyle()
    }
}


extension NewChallengeViewController: BackgroundStyleDelegate {
    
    func backgroundStyleDidSelect(style: BackgroundStyle) {
        
        background = style
        updateStyle()
        
        if style.type == .image {
            colorPickerView.selectDefault(at: nil)
        } else if let color = style.color {
            colorPickerView.selectDefault(style: color)
        }
    }
    
    func backgroundStyleGetPro() {
        
        show(message: "Get Pro.", title: "Info")
    }
}


extension NewChallengeViewController: ColorPickerViewDelegate {
    
    func colorPickerDidSelect(style: ColorStyle) {
        
        backgroundDataSource?.update(colorStyle: style)
        
        color = style
        background = backgroundDataSource?.selected
        updateStyle()
    }
}
