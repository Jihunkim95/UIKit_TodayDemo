//
//  ViewController.swift
//  Today
//
//  Created by 김지훈 on 2024/04/12.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    var dataSource: DataSource!
//    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
//    // 스냅샷 적용
//    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
//    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 뷰를 로드한 후 추가 설정을 수행합니다.
        let listLayout = listLayout()
        ////목록 Layout
        collectionView.collectionViewLayout = listLayout
        
        // 목록Layout에 데이터 소스 구성
        // 새로운 cell 등록
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegisterationHandler)

        // 데이터 소스 생성
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        // 스냅샷 생성으로 코드 보이기
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(Reminder.sampleData.map{$0.title})
        dataSource.apply(snapshot)
        collectionView.dataSource = dataSource
    }
    
    //목록 Layout 생서
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }

}

