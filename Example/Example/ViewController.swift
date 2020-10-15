//
//  ViewController.swift
//  Example
//
//  Created by Chi Hoang on 15/10/20.
//  Copyright © 2020 Hoang Nguyen Chi. All rights reserved.
//

import UIKit
import CommentView

class ViewController: UIViewController {
    @IBOutlet weak var commentView: CommentView!

    override func viewDidLoad() {
        super.viewDidLoad()
        commentView.placeholder = "Comment"
        commentView.titleButton = "Done"
        commentView.delegate = self
    }
}

extension ViewController: CommentViewDelegate {
    func didFinishEnter(commentView: CommentView) {
        self.view.endEditing(true)
    }

    func textViewDidChange(commentView: CommentView) {
        print("commentView: \(commentView.text)")
    }
}

