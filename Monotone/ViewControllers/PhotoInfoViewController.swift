//
//  PhotoInfoViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/1.
//

import UIKit

class PhotoInfoViewController: BaseViewController {
    
    // MARK: Controls
    private var pageTitleView: PageTitleView!
    
    private var photoImageView: UIImageView!
    private var photoInfoStatisticsView: PhotoInfoStatisticsView!
    private var photoInfoCameraView: PhotoInfoCameraView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        self.view.backgroundColor = UIColor.white
        
        // pageTitleView.
        self.pageTitleView = PageTitleView()
        self.view.addSubview(self.pageTitleView)
        self.pageTitleView.snp.makeConstraints { (make) in
            make.left.equalTo(15.0)
            make.right.equalTo(-15.0)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(40.0)
        }
        
        // photoImageView.
        self.photoImageView = UIImageView()
        self.photoImageView.contentMode = .scaleAspectFill
        self.photoImageView.layer.cornerRadius = 6.0
        self.photoImageView.layer.masksToBounds = true
        self.view.addSubview(self.photoImageView)
        self.photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.pageTitleView.snp.bottom).offset(17.0)
            make.left.equalTo(15.0)
            make.right.equalTo(self.view.snp.right).multipliedBy(4.0/7)
            make.bottom.equalTo(self.view).multipliedBy(1/2.0)
        }
        
        // photoInfoStatisticsView.
        self.photoInfoStatisticsView = PhotoInfoStatisticsView()
        self.view.addSubview(self.photoInfoStatisticsView)
        self.photoInfoStatisticsView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.photoImageView)
            make.left.equalTo(self.photoImageView.snp.right)
            make.right.equalTo(self.view)
        }
        
        // photoInfoCameraView.
        self.photoInfoCameraView = PhotoInfoCameraView()
        self.view.addSubview(self.photoInfoCameraView)
        self.photoInfoCameraView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.center.y)
            make.left.equalTo(self.view).offset(16.0)
            make.right.equalTo(self.view).offset(-16.0)
            make.bottom.equalTo(self.view)
        }
    }
    
    override func buildLogic() {
        
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