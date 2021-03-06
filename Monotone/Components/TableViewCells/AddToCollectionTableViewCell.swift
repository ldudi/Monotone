//
//  AddToCollectionTableViewCell.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/4.
//

import UIKit

import RxSwift
import RxRelay
import RxCocoa
import RxSwiftExt
import anim
import NVActivityIndicatorView

class AddToCollectionTableViewCell: UITableViewCell {
    
    // MARK: - Public
    public var collection: BehaviorRelay<Collection?> = BehaviorRelay<Collection?>(value: nil)
    
    public var loading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    public var displayState: BehaviorRelay<DisplayState> = BehaviorRelay<DisplayState>(value: .notContainsPhoto)

    // MARK: - Controls
    public var coverImageView: UIImageView!
    
    public var nameLabel: UILabel!
    public var photoCountLabel: UILabel!
    public var lockImageView: UIImageView!
    public var plusImageView: UIImageView!
    
    public var overlayerView: UIView!
    
    public var successStateView: UIView!
    public var activityIndicatorView: NVActivityIndicatorView!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.buildSubviews()
        self.buildLogic()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildSubviews(){
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
                
        // CoverImageView.
        self.coverImageView = UIImageView()
        self.coverImageView.contentMode = .scaleAspectFill
        self.coverImageView.layer.cornerRadius = 8.0
        self.coverImageView.layer.masksToBounds = true
        self.coverImageView.backgroundColor = UIColor.darkGray
        self.contentView.addSubview(self.coverImageView)
        self.coverImageView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView).offset(7.0)
            make.bottom.equalTo(self.contentView).offset(-7.0)
            make.left.equalTo(self.contentView).offset(17.0)
            make.right.equalTo(self.contentView).offset(-17.0)
        })
        
        // OverlayerView.
        self.overlayerView = UIView()
        self.overlayerView.backgroundColor = ColorPalette.colorOverlayer
        self.overlayerView.layer.cornerRadius = 8.0
        self.overlayerView.layer.masksToBounds = true
        self.contentView.addSubview(self.overlayerView)
        self.overlayerView.snp.makeConstraints({ (make) in
            make.top.right.bottom.left.equalTo(self.coverImageView)
        })
        
        // LockImageView.
        self.lockImageView = UIImageView()
        self.lockImageView.image = UIImage(named: "collection-lock")
        self.contentView.addSubview(self.lockImageView)
        self.lockImageView.snp.makeConstraints({ (make) in
            make.left.equalTo(self.coverImageView).offset(6.0)
            make.bottom.equalTo(self.coverImageView).offset(-6.0)
            make.width.height.equalTo(20.0)
        })
        
        // NameLabel.
        self.nameLabel = UILabel()
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.nameLabel.textColor = UIColor.white
        self.nameLabel.text = "nil"
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(self.lockImageView.snp.right)
            make.centerY.equalTo(self.lockImageView)
        })
        
        // PhotoCountLabel.
        self.photoCountLabel = UILabel()
        self.photoCountLabel.font = UIFont.boldSystemFont(ofSize: 8)
        self.photoCountLabel.textColor = UIColor.white
        self.photoCountLabel.text = "0 Photos"
        self.contentView.addSubview(self.photoCountLabel)
        self.photoCountLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(self.nameLabel).offset(-10.0)
            make.bottom.equalTo(self.nameLabel.snp.top).offset(-3.0)
        })
        
        // PlusImageView.
        self.plusImageView = UIImageView()
        self.plusImageView.image = UIImage(named: "collection-plus")
        self.contentView.addSubview(self.plusImageView)
        self.plusImageView.snp.makeConstraints({ (make) in
            make.right.equalTo(self.coverImageView).offset(-6.0)
            make.bottom.equalTo(self.coverImageView).offset(-6.0)
            make.width.height.equalTo(20.0)
        })
        
        // SuccessStateView.
        self.successStateView = UIView()
        self.successStateView.backgroundColor = ColorPalette.colorGreen
        self.successStateView.alpha = 0
        self.successStateView.layer.cornerRadius = 8.0
        self.successStateView.layer.masksToBounds = true
        self.contentView.addSubview(self.successStateView)
        self.successStateView.snp.makeConstraints({ (make) in
            make.top.right.bottom.left.equalTo(self.coverImageView)
        })
        
        // ActivityIndicatorView
        self.activityIndicatorView = NVActivityIndicatorView(frame: CGRect.zero)
        self.activityIndicatorView.type = .circleStrokeSpin
        self.activityIndicatorView.color = UIColor.white
        self.contentView.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
            make.width.height.equalTo(20.0)
        }
    }

    private func buildLogic(){
        
        // Bindings.
        // Collection.
        self.collection
            .unwrap()
            .subscribe(onNext: { [weak self] (collection) in
                guard let self = self else { return }
                
                self.nameLabel.text = collection.title
                self.photoCountLabel.text = String(format: NSLocalizedString("uns_add_collection_total_photo_suffix", comment: "%d Photos"), collection.totalPhotos ?? 0)
                
                self.coverImageView.setPhoto(photo: collection.coverPhoto, size: .regular)
                
                self.lockImageView.isHidden = collection.isPrivate ?? true
            })
            .disposed(by: self.disposeBag)
        
        // Loading.
        self.loading
            .subscribe(onNext: { [weak self] (loading) in
                guard let self = self else { return }
                
                self.switchLoadingState(to: loading)
            })
            .disposed(by: self.disposeBag)
        
        // DisplayState.
        self.displayState
            .subscribe(onNext: { [weak self] (displayState) in
                guard let self = self else { return }
                
                self.switchDisplayState(to: displayState)
            })
            .disposed(by: self.disposeBag)
    }
}

extension AddToCollectionTableViewCell{
    enum DisplayState{
        case containsPhoto
        case notContainsPhoto
        
        case addSuccessfully
        case removeSuccessfully
    }
    
    private func switchLoadingState(to loading: Bool){
        
        if(loading){
            self.activityIndicatorView.startAnimating()
            self.activityIndicatorView.isHidden = false
        }
        else{
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
        }
        
    }
    
    private func switchDisplayState(to displayState: DisplayState){
                
        switch displayState {
            
        case .containsPhoto:
            
            self.successStateView.alpha = 0.5
            
            break
            
        case .notContainsPhoto:
            
            self.successStateView.alpha = 0

            break
            
        case .addSuccessfully:
            
            if let totalPhotos = self.collection.value?.totalPhotos{
                self.collection.value?.totalPhotos = totalPhotos + 1
                self.photoCountLabel.text = String(format: NSLocalizedString("uns_add_collection_total_photo_suffix", comment: "%d Photos"), self.collection.value?.totalPhotos ?? 0)
            }
            
            self.successStateView.alpha = 0.8
            
            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 1.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.successStateView.alpha = 0.5
                }
            }.callback {
                self.displayState.accept(.containsPhoto)
            }
            
            break
            
        case .removeSuccessfully:
            
            if let totalPhotos = self.collection.value?.totalPhotos{
                self.collection.value?.totalPhotos = totalPhotos - 1
                self.photoCountLabel.text = String(format: NSLocalizedString("uns_add_collection_total_photo_suffix", comment: "%d Photos"), self.collection.value?.totalPhotos ?? 0)
            }
            
            self.successStateView.alpha = 0.5
            
            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 1.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.successStateView.alpha = 0
                }
            }.callback {
                self.displayState.accept(.notContainsPhoto)
            }
        
            break
            
        }
    }
}
