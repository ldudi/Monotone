//
//  PhotoDetailsViewController.swift
//  
//
//  Created by Xueliang Chen on 2020/11/12.
//

import UIKit

import SnapKit

import RxSwift
import RxRelay

import Kingfisher
import anim

// MARK: - PhotoDetailsViewController
class PhotoDetailsViewController: BaseViewController {
    
    // MARK: - Public
    public var animationState: BehaviorRelay<AnimationState> = BehaviorRelay<AnimationState>(value: .normal)

    // MARK: - Controls
    private var avatarImageView: UIImageView!
    private var usernameLabel: UILabel!
    private var userCapsuleView: CapsuleView!
    
    private var operationView: PhotoDetailsOperationView!
    private var scrollView: PhotoZoomableScrollView!
    
    private var likeCapsuleBtn: CapsuleButton!
    private var collectCapsuleBtn: CapsuleButton!
    private var expandBtn: UIButton!
    
    // MARK: - Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

    }
    
    override func buildSubviews() {
        super.buildSubviews()

        //
        self.view.backgroundColor = UIColor.black
        
        // NavBar.
        self.navBarTransparent = true
        // self.navBarHidden = true
        self.navBarItemsColor = UIColor.white
                
        // ScrollView.
        self.scrollView = PhotoZoomableScrollView()
        self.scrollView.maximumZoomScale = 10.0
        self.scrollView.minimumZoomScale = 1.0
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints({ (make) in
            make.top.right.bottom.left.equalTo(self.view)
        })
        
        // AvatarImageView.
        self.avatarImageView = UIImageView()
        self.avatarImageView.layer.cornerRadius = 14.0
        self.avatarImageView.layer.masksToBounds = true
        self.avatarImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(27.0)
        }
        
        // UsernameLabel.
        self.usernameLabel = UILabel()
        self.usernameLabel.font = UIFont.systemFont(ofSize: 12.0)
        self.usernameLabel.textColor = UIColor.white
        
        self.userCapsuleView = CapsuleView()
        self.userCapsuleView.views = [avatarImageView, usernameLabel]
        self.view.addSubview(self.userCapsuleView)
        self.userCapsuleView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(17.0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // OperationView.
        self.operationView = PhotoDetailsOperationView()
        self.view.addSubview(self.operationView)
        self.operationView.snp.makeConstraints { (make) in
            make.right.equalTo(self.view)
            make.left.equalTo(self.userCapsuleView.snp.right)
            make.height.equalTo(30.0)
            make.centerY.equalTo(self.userCapsuleView)
        }
        
        // LikeCapsuleBtn.
        self.likeCapsuleBtn = CapsuleButton()
        self.likeCapsuleBtn.setTitle("0", for: .normal)
        self.likeCapsuleBtn.setImage(UIImage(named: "details-btn-like"), for: .selected)
        self.likeCapsuleBtn.setImage(UIImage(named: "details-btn-unlike"), for: .normal)
        self.likeCapsuleBtn.backgroundStyle = .blur
        self.view.addSubview(self.likeCapsuleBtn)
        self.likeCapsuleBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(17.0)
            make.bottom.equalTo(self.userCapsuleView.snp.top).offset(-26.0)
        }
        
        // CollectCapsuleBtn.
        self.collectCapsuleBtn = CapsuleButton()
        self.collectCapsuleBtn.setTitle(NSLocalizedString("uns_details_collect", comment: "Collect"), for: .normal)
        self.collectCapsuleBtn.setImage(UIImage(named: "details-btn-collect"), for: .normal)
        self.collectCapsuleBtn.backgroundStyle = .blur
        self.view.addSubview(self.collectCapsuleBtn)
        self.collectCapsuleBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.likeCapsuleBtn.snp.right).offset(10.0)
            make.centerY.equalTo(self.likeCapsuleBtn)
        }
        
        // ExpandBtn.
        self.expandBtn = UIButton()
        self.expandBtn.setImage(UIImage(named: "details-btn-expand"), for: .normal)
        self.expandBtn.setImage(UIImage(named: "details-btn-collapse"), for: .selected)
        self.view.addSubview(self.expandBtn)
        self.expandBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-17.0)
            make.centerY.equalTo(self.likeCapsuleBtn)
        }
        
    }
    
    override func buildLogic() {
        super.buildLogic()
                
        // ViewModel.
        let photoDetailsViewModel = self.viewModel(type:PhotoDetailsViewModel.self)!
        
        // Bindings.
        // Photo.
        photoDetailsViewModel.output.photo
            .unwrap()
            .subscribe(onNext: { [weak self] (photo) in
                guard let self = self else { return }

                self.scrollView.photo = photo
                
                self.likeCapsuleBtn.setTitle("\(photo.likes ?? 0)", for: .normal)
                self.likeCapsuleBtn.isSelected = photo.likedByUser ?? false
                
                let editor = photo.sponsorship?.sponsor ?? photo.user
                
                self.avatarImageView.setUserAvatar(user: editor, size: .medium)
                self.usernameLabel.text = editor?.username
            })
            .disposed(by: self.disposeBag)
                        
        // OperationView.
        self.operationView.infoBtn.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }

                let photo = photoDetailsViewModel.output.photo.value

                let args = [
                    "photo" : photo
                ] as [String : Any?]

                self.transition(type: .present(scene: .photoInfo, presentationStyle: .pageSheet), with: args, animated: true)
//                self.transition(type: .push(.photoInfo(args)), with: nil)
            })
            .disposed(by: self.disposeBag)
        
        // ShareBtn.
        self.operationView.shareBtn.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                let photo = photoDetailsViewModel.output.photo.value

                let args = [
                    "photo" : photo
                ] as [String : Any?]

                self.transition(type: .present(scene: .photoShare, presentationStyle: .pageSheet), with: args, animated: true)
            })
            .disposed(by: self.disposeBag)
        
        // DownloadBtn.
        self.operationView.downloadBtn.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                let image = self.scrollView.photoImageView.image!
                PhotoAlbum.shared.save(image:image)
            })
            .disposed(by: self.disposeBag)
        
        // LikeCapsuleBtn.
        self.likeCapsuleBtn.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                if(self.likeCapsuleBtn.isSelected){
                    photoDetailsViewModel.input.unlikePhotoAction?.execute()
                }
                else{
                    photoDetailsViewModel.input.likePhotoAction?.execute()
                }
            })
            .disposed(by: self.disposeBag)
        
        // CollectCapsuleBtn.
        self.collectCapsuleBtn.rx.tap
            .subscribe(onNext: { [weak self ] (_) in
                guard let self = self else { return }

                let args = [
                    "username" : UserManager.shared.currentUser.value?.username,
                    "photo": photoDetailsViewModel.output.photo.value
                ] as [String : Any?]

                self.transition(type: .present(scene: .photoAddToCollection, presentationStyle: .pageSheet), with: args, animated: true)
            })
            .disposed(by: self.disposeBag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - ViewControllerAnimatable
extension PhotoDetailsViewController: ViewControllerAnimatable{
    
    // MARK: - Enums
    enum AnimationState{
        case normal
        case expanded
    }
    
    // MARK: - BuildAnimation
    @objc func buildAnimation() {
        
        // AnimationState.
        self.animationState
            .skipWhile({ $0 == .normal })
            .distinctUntilChanged()
            .subscribe(onNext:{ [weak self] (animationState) in
                guard let self = self else { return }

                self.animation(animationState: animationState)
            })
            .disposed(by: self.disposeBag)
        
        // ExpandBtn.
        self.expandBtn.rx.tap
            .map({ (_) -> AnimationState in
                return self.animationState.value == .normal ? .expanded : .normal
            })
            .bind(to: self.animationState)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Animation
    func animation(animationState: AnimationState) {
        switch animationState {
        case .normal:
            
            self.expandBtn.isSelected = false
            self.userCapsuleView.backgroundStyle = .normal
            self.scrollView.adjustZoomScale(scaleToFill: false, animated: true)
            
            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.likeCapsuleBtn.alpha = 1.0
                    self.collectCapsuleBtn.alpha = 1.0
                }
            }
            
            anim(constraintParent: self.view) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.expandBtn.snp.remakeConstraints { (make) in
                        make.right.equalTo(self.view).offset(-17.0)
                        make.centerY.equalTo(self.likeCapsuleBtn)
                    }
                    
                    self.operationView.snp.remakeConstraints { (make) in
                        make.left.right.equalTo(self.view)
                        make.height.equalTo(30.0)
                        make.centerY.equalTo(self.userCapsuleView)
                    }
                }
            }
            
            
            break
        case .expanded:
            
            self.expandBtn.isSelected = true
            self.userCapsuleView.backgroundStyle = .blur
            self.scrollView.adjustZoomScale(scaleToFill: true, animated: true)

            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.likeCapsuleBtn.alpha = 0
                    self.collectCapsuleBtn.alpha = 0
                }
            }
            
            anim(constraintParent: self.view) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.expandBtn.snp.remakeConstraints { (make) in
                        make.right.equalTo(self.view).offset(-17.0)
                        make.centerY.equalTo(self.userCapsuleView)
                    }
                    
                    self.operationView.snp.remakeConstraints { (make) in
                        make.left.right.equalTo(self.view)
                        make.height.equalTo(30.0)
                        make.bottom.equalTo(self.view.snp.bottom).offset(self.operationView.frame.size.height)
                    }
                }
            }
            
            break

        }
    }
}
