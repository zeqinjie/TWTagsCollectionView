//
//  TWTagsCollectionViewDemoController.swift
//  TWHouseUIKit_Swift_Example
//
//  Created by zhengzeqin on 2021/6/10.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import TWTagsCollectionView
import SnapKit
class TWTagsCollectionViewDemoController: UIViewController {
    fileprivate lazy var tagsView: TWTagsCollectionView = {
        var configure = TWTagsCollectionViewConfigure()
        configure.alignedType = .right
        configure.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let tagsView = TWTagsCollectionView(frame: .zero, configure: configure)
        tagsView.delegate = self
        tagsView.observerContentSizeBlock = { [weak self] size in
            guard let self = self else { return }
            self.tagViewHeigth = size.height
            tagsView.snp.updateConstraints { make in
                make.height.equalTo(self.tagViewHeigth)
            }
        }
        return tagsView
    }()
    
    fileprivate var tagViewHeigth: CGFloat = 0
    
    fileprivate lazy var dataSource: [TWTagsCollectionCellModel] = {
        var models: [TWTagsCollectionCellModel] = []
        let titles: [String] = [
            "iOS",
            "Android",
            "PHP",
            "Java",
            "hello word",
            "welcome in china",
            "my name is zhengzeqin",
            "china is number 1"
        ]
        for (i, title) in titles.enumerated() {
            let model = TWTagsCollectionCellModel()
            model.gap = 16
            model.height = 24
            model.titleColor = UIColor.randomColor
            model.titleBgColor = UIColor.randomColor
            model.font = UIFont.systemFont(ofSize: 12)
            if i % 2 == 0 {
                var iconPosition = TWTagsCollectionIconPosition()
                iconPosition.height = 12
                iconPosition.width = 12
                iconPosition.left = 3
                iconPosition.right = 2
                iconPosition.top = 5
                model.iconPosition = iconPosition
                model.icon = "rent_house_tag"
                model.cornerRadius = 8
                model.gap = 6
                model.titleAlignment = .left
            }
            model.title = title
            model.updateTitle()
            models.append(model)
        }
        return models
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        createUI()
    }
    
    fileprivate func createUI() {
        view.addSubview(tagsView)
        tagsView.snp.makeConstraints { make in
            make.height.equalTo(tagViewHeigth)
            make.center.width.equalToSuperview()
        }
        tagsView.dataSource = dataSource
    }
}

extension TWTagsCollectionViewDemoController: TWTagsCollectionViewDelegate {
    func tagsCollView(_ tagsCollectionView: TWTagsCollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt: \(indexPath)")
    }
 /*
    // 自定义部分
    func tagsCollView(_ tagsCollectionView: TWTagsCollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 20)
    }
    func customCollectionViewCellClass(_ tagsCollectionView: TWTagsCollectionView) -> AnyClass {
        return TWTagsCollectionViewDemoCustomCell.self
    }
    
    func setupCustomCell(_ cell: UICollectionViewCell, indexPath: IndexPath, model: TWTagsCollectionCellModel?, tagsCollectionView: TWTagsCollectionView) {
        if let customCell = cell as? TWTagsCollectionViewDemoCustomCell {
            customCell.label.text = model?.title
            customCell.contentView.backgroundColor = UIColor.randomColor
        }
    }
 */
}

class TWTagsCollectionViewDemoCustomCell: UICollectionViewCell {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TWTagsCollectionViewDemoCustomCell {
    
    fileprivate func initUI() {
        self.contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

private extension UIColor {
    class var randomColor: UIColor{
       get{
           let red = CGFloat(arc4random()%256)/255.0
           let green = CGFloat(arc4random()%256)/255.0
           let blue = CGFloat(arc4random()%256)/255.0
           return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
       }
   }
}


