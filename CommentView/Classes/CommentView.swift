//
//  CommentView.swift
//  CommentView
//
//  Created by Chi Hoang on 15/10/20.
//  Copyright © 2020 Hoang Nguyen Chi. All rights reserved.
//

import UIKit


enum ColorTheme {
    static let deepBlue = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
    static let lightBlueGrey = #colorLiteral(red: 0.3882352941, green: 0.4705882353, blue: 0.5490196078, alpha: 1)
    static let darkBlueGrey = #colorLiteral(red: 0.2, green: 0.3058823529, blue: 0.4117647059, alpha: 1)
    static let light = #colorLiteral(red: 0.9019607843, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
}

public protocol CommentViewDelegate: class {
    func didFinishEnter(commentView: CommentView)
    func textViewDidChange(commentView: CommentView)
}

public class CommentView: UIView {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var heightTextViewConstraint: NSLayoutConstraint!
    var doneBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    private var bufferText: String = ""
    public weak var delegate: CommentViewDelegate?
    public var maximumCharacter: Int = 250

    public var placeholder: String? {
        didSet {
            commentTextView.text = placeholder
        }
    }

    public var titleButton: String? {
        didSet {
            self.doneBarButtonItem.title = titleButton
        }
    }

    public var text: String? {
        get {
            return self.commentTextView.text
        }
        set(value) {
            self.commentTextView.text = value
        }
    }

    public var countText: Int {
        get {
            guard let text = self.text else { return 0 }
            return text.count
        }
        set(value) {
            self.countLabel.text = String(value) + "/" + String(maximumCharacter)
        }
    }

    public convenience init() {
        self.init(frame: CGRect.zero)
    }

    /// :nodoc:
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// :nodoc:
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor.clear
        _ = fromNib(nibName: String(describing: CommentView.self), isInherited: true)

        self.contentView.cornerRadius(radius: 4.0,
                                   maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner,
                                                   .layerMinXMaxYCorner, .layerMaxXMaxYCorner],
                                   color: ColorTheme.light,
                                   width: 1.0)

        self.contentView.applyShadow(shadowColor: UIColor.black.cgColor,
                                  opacity: 0.08,
                                  offset: CGSize(width: 0.0, height: 2.0),
                                  blur: 4.0,
                                  spread: 0.0)

        self.commentTextView.isScrollEnabled = false
        self.commentTextView.font = UIFont.systemFont(ofSize: 14.0)
        self.commentTextView.textColor = ColorTheme.lightBlueGrey
        self.commentTextView.delegate = self
        self.countText = 0

        self.countLabel.font = UIFont.systemFont(ofSize: 12.0)
        self.countLabel.textColor = ColorTheme.darkBlueGrey

        let numberToolbar = UIToolbar(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: UIScreen.main.bounds.width,
                                                    height: 50))
        numberToolbar.barStyle = .default
        doneBarButtonItem =  UIBarButtonItem(title: self.titleButton,
                                             style: .plain,
                                             target: self,
                                             action: #selector(doneEnterComment))

        let items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                                       doneBarButtonItem]
        numberToolbar.setItems(items, animated: true)
        numberToolbar.sizeToFit()
        commentTextView.inputAccessoryView = numberToolbar
    }

    @objc func doneEnterComment() {
        self.delegate?.didFinishEnter(commentView: self)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.heightTextViewConstraint.constant = self.commentTextView.contentSize.height
    }
}

extension CommentView: UITextViewDelegate {

    public func textViewDidBeginEditing(_ textView: UITextView) {
        if let placeholder = self.placeholder, textView.text == placeholder {
            textView.text = nil
            textView.textColor = ColorTheme.deepBlue
        }
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = ColorTheme.lightBlueGrey
        }
    }

    public func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        self.heightTextViewConstraint.constant = self.commentTextView.contentSize.height
        if text.count <= maximumCharacter {
            bufferText = self.commentTextView.text
            self.countText = text.count
        } else {
            self.commentTextView.text = bufferText
        }
        self.delegate?.textViewDidChange(commentView: self)
    }
}
