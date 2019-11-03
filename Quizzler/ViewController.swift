//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
  let questions = QuestionBank()
  var questionIndex = 0
  var correctAnswerCount = 0
  var answerSelected = false
  
  //Place your instance variables here
  
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet var progressBar: UIView!
  @IBOutlet weak var progressLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }

  @IBAction func answerPressed(_ sender: AnyObject) {
    if sender.tag == 1 {
      answerSelected = true;
    } else {
      answerSelected = false;
    }
    checkAnswer()
    nextQuestion()
    updateUI()
  }
  
  func updateUI() {
    questionLabel.text = questions.list[questionIndex].questionText
    progressLabel.text = "\(questionIndex + 1) / \(questions.list.count)"
    scoreLabel.text = "Score: \(correctAnswerCount * 10)"
  }

  func nextQuestion() {
    if questionIndex + 1 < questions.list.count {
      questionIndex += 1
    } else {
      let alert = UIAlertController(
        title: "You're Done!",
        message: "Want to go again?",
        preferredStyle: .alert
      )
      
      let didRestart = UIAlertAction(
        title: "Restart",
        style: .default,
        handler: { (UIAlertAction) in
          self.startOver()
      })
      
      alert.addAction(didRestart)
      present(alert, animated: true, completion: nil)
    }
  }
  
  func checkAnswer() {
    let answerCorrect = questions.list[questionIndex].answer
    if answerSelected == answerCorrect {
      correctAnswerCount += 1
      ProgressHUD.showSuccess("Correct!")
    } else {
      ProgressHUD.showError("Wrong")
    }
  }
  
  func startOver() {
    questionIndex = 0
    correctAnswerCount = 0
    updateUI()
  }
}
