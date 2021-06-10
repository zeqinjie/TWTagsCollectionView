//
//  TWTagsCollectionViewCell.swift
//  TWHouseUIKit_Swift
//
//  Created by zhengzeqin on 2021/6/9.
//

import UIKit
import SnapKit

open class TWTagsCollectionViewCell: UICollectionViewCell {
    public var model: TWTagsCollectionCellModel? {
        didSet {
            guard let model = model else {
                return
            }
            dealModel(model)
        }
    }
    
    public let icon: UIImageView = UIImageView()
  
    public let titleLabel: UILabel = UILabel()
    
    fileprivate var iconPosition: TWTagsCollectionIconPosition? {
        didSet {
            guard let iconPosition = iconPosition else { return }
            icon.snp.updateConstraints { (make) in
                make.left.equalToSuperview().offset(iconPosition.left)
                make.width.equalTo(iconPosition.width)
                make.height.equalTo(iconPosition.height)
            }
            
            titleLabel.snp.updateConstraints { (make) in
                make.left.equalTo(icon.snp.right).offset(iconPosition.right)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    fileprivate func createUI() {
        contentView.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(0)
            make.height.equalTo(0)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(0)
            make.top.bottom.right.equalToSuperview()
        }
        contentView.clipsToBounds = true
    }
    
    // MARK: - Private Method
    func dealModel(_ model: TWTagsCollectionCellModel) {
        titleLabel.text = model.title
        titleLabel.font = model.font
        titleLabel.textColor = model.titleColor
        icon.image = UIImage(named: model.icon)
        titleLabel.textAlignment = model.titleAlignment
        contentView.layer.borderColor = model.borderColor?.cgColor
        contentView.layer.borderWidth = model.borderWidth
        contentView.layer.cornerRadius = model.cornerRadius
        contentView.backgroundColor = model.titleBgColor
        guard let iconPosition = iconPosition else {
            self.iconPosition = model.iconPosition;
            return
        }
        if iconPosition != model.iconPosition {
            self.iconPosition = model.iconPosition
        }
    }
}
