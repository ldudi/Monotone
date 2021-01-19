//
//  CollectionDetailsViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/29.
//

import UIKit

import SnapKit
import MJRefresh

import RxSwift
import RxRelay
import RxSwiftExt

import anim
import ViewAnimator

// MARK: - CollectionDetailsViewController
class CollectionDetailsViewController: BaseViewController {
    
    // MARK: - Public

    
    // MARK: - Controls

    
    private var collectionView: UICollectionView!
    private var topGradientImageView: UIImageView!
    
    // MARK: - Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func buildSubviews() {
        
        self.view.backgroundColor = ColorPalette.colorWhite
        
        // CollectionView.
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: ElevatorFlowLayout())
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        self.collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(90.0)
        }
        
        // MJRefresh.
        let header = MJRefreshNormalHeader()
        header.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        header.lastUpdatedTimeLabel!.font = UIFont.systemFont(ofSize: 10)
        self.collectionView.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter()
        footer.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        self.collectionView.mj_footer = footer
        
        // TopGradientView.
        self.topGradientImageView = UIImageView()
        self.topGradientImageView.image = UIImage(named: "list-top-gradient")
        self.view.addSubview(self.topGradientImageView)
        self.topGradientImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionView)
            make.right.left.equalTo(self.view)
            make.height.equalTo(92.0)
        }
                

    }
    
    override func buildLogic() {
        
        // ViewModel.
        let myPhotosViewModel = self.viewModel(type:MyPhotosViewModel.self)!

        // Bindings.
        // CollectionView.
        myPhotosViewModel.output.photos
            .bind(to: self.collectionView.rx.items(cellIdentifier: "PhotoCollectionViewCell")){
                (row, element, cell) in
                
                let pcell: PhotoCollectionViewCell = cell as! PhotoCollectionViewCell
                pcell.photo.accept(element)
            
            }.disposed(by: self.disposeBag)
        
        self.collectionView.rx.modelSelected(Photo.self)
            .subscribe(onNext:{ [weak self] (photo) in
                guard let self = self else { return }
                
                let args = [
                    "photo" : photo
                ] as [String : Any?]

                self.transition(type: .push(scene: .photoDetails), with: args, animated: true)

            }).disposed(by: self.disposeBag)

        // MJRefresh.
        self.collectionView.mj_header!.refreshingBlock = {
            myPhotosViewModel.input.reloadAction?.execute()
        }
            
        self.collectionView.mj_footer!.refreshingBlock = {
            myPhotosViewModel.input.loadMoreAction?.execute()
        }
        
        myPhotosViewModel.output.reloading
            .ignore(true)
            .subscribe { [weak self] (_) in
                self?.collectionView.mj_header!.endRefreshing()
            }
            .disposed(by: self.disposeBag)

        myPhotosViewModel.output.loadingMore
            .ignore(true)
            .subscribe { [weak self] (_) in
                guard let self = self else { return }

                self.collectionView.mj_footer!.endRefreshing()
            }
            .disposed(by: self.disposeBag)
        
        // First loading.
        myPhotosViewModel.input.loadMoreAction?.execute()
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

// MARK: - UICollectionViewDelegateFlowLayout
extension CollectionDetailsViewController: UICollectionViewDelegateFlowLayout{
    
}
