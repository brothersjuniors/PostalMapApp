//
//  CopyLabel.swift
//  PostalMapApp
//
//  Created by 近江伸一 on 2023/01/06.
//


import UIKit
class CopyableLabel: UILabel
{
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        // Storyboardからの設定を無視したい場合は書く
        setup()
    }

    private func setup()
    {
        isUserInteractionEnabled = true
        // ジェスチャーの追加
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:))))
    }

    /// 長押ししたら発動
    ///
    /// - Parameter recognizer: UIGestureRecognizer
    @objc func handleLongPressGesture(_ recognizer: UIGestureRecognizer)
    {
        // あとでここに追記する
    }
}
