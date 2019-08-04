//
//  ViewController.swift
//  MarubatuApp
//
//  Created by 小平恭兵 on 2019/08/03.
//  Copyright © 2019 kk-project. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // クイズの問題を表示
    @IBOutlet weak var questionLabel: UILabel!

    // クイズの問題を管理する
    var currentQuestionNum: Int = 0

    // 正解数
    var answerCount: Int = 0

    // ヒント管理
    var isHint: Bool = false

    // 問題を管理
    let questions: [[String: Any]] = [
        [ "question": "iPhoneアプリを開発する統合環境はZcodeである",
          "answer": false,
          "hint": "バツだよ！"
        ],
        [ "question": "Xcode画面の右側にはユーティリティーズがある",
          "answer": true,
          "hint": "マルだよ！"
        ],
        [ "question": "UILabelは文字列を表示する際に利用する",
          "answer": true,
          "hint": "マルだよ！"
        ],
        [ "question": "ドラえもんは常に地面から浮いている",
          "answer": true,
          "hint": "マルだよ！"
        ],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }

    // 問題を表示する関数
    func showQuestion() {
        // currentQuestionNum(問題番号)の問題を取得
        let question = questions[currentQuestionNum]

        // 問題(辞書型)からKeyを指定して内容を取得
        if let que = question["question"] as? String {
            // question Key の中身をLabelに代入
            questionLabel.text = que
        }
    }

    // 回答をチェックする関数
    // 正解なら次の問題を表示します
    func checkAnswer(yourAnswer: Bool) {
        // どの問題か取得する
        let question = questions[currentQuestionNum]

        // 問題の答えを取り出す
        if let ans = question["answer"] as? Bool {

            // 選択された答えと問題の答えを比較する
            if yourAnswer == ans {
                // 正解
                // currentQuestionNumを1足して次の問題に進む
                currentQuestionNum += 1
                answerCount += 1

                if currentQuestionNum >= questions.count {
                    showAlert(message: "\(questions.count)中\(answerCount)問正解しました！")
                    answerCount = 0
                    isHint = false
                    currentQuestionNum = 0
                } else {
                    showAlert(message: "正解！")
                }
            } else {
                // 不正解
                currentQuestionNum += 1
                if currentQuestionNum >= questions.count {
                    showAlert(message: "\(questions.count)中\(answerCount)問正解しました！")
                    answerCount = 0
                    isHint = false
                    currentQuestionNum = 0
                } else {
                    showAlert(message: "不正解...")
                }

            }
        } else {
            print("答えが入ってません")
            return
        }

        // currentQuestionNumの値が問題数以上だったら最初の問題に戻す
//        if currentQuestionNum >= questions.count {
//            currentQuestionNum = 0
//        }

        // 問題を表示します。
        // 正解であれば次の問題が、不正解であれば同じ問題が再表示されます。
        showQuestion()
    }

    // アラートを表示する関数
    func showAlert(message: String) {
        // アラートの作成
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        // アラートのアクション（ボタン部分の定義）
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        // 作成したalertに閉じるボタンを追加
        alert.addAction(close)
        // アラートを表示する
        present(alert, animated: true, completion: nil)
    }

    // バツボタン
    @IBAction func noButton(_ sender: Any) {
        checkAnswer(yourAnswer: false)
    }

    // マルボタン
    @IBAction func yesButton(_ sender: Any) {
        checkAnswer(yourAnswer: true)
    }

    // ヒントボタン
    @IBAction func hintButton(_ sender: Any) {
        if !isHint {

            var hoge = ""
            let question = questions[currentQuestionNum]

            if let ans = question["answer"] as? Bool {
                if ans {
                    hoge = "マル"
                } else {
                    hoge = "バツ"
                }
            }

            showAlert(message: hoge)
            isHint = true

//            if let que = question["hint"] as? String {
//                // question Key の中身をLabelに代入
//                showAlert(message: que)
//                isHint = true
//            }
        } else {
            showAlert(message: "もう使ったよ")
        }

    }

}

