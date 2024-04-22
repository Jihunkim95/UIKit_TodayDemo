//
//  ReminderViewController.swift
//  Today
//
//  Created by 김지훈 on 2024/04/22.
//

import UIKit

class ReminderViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Row>
    
    var reminder: Reminder
    private var dataSource: DataSource!
    
    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfiguartion = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguartion.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguartion)
        super.init(collectionViewLayout: listLayout)
    }
    
    // 코드 베이스이기에 스토리보드를 통해 초기화를 방지하기 위함
    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderViewController using init(reminder:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        // 네비게이션 뒤로가기 버튼이다.
        if #available(iOS 16, *){
            navigationItem.style = .navigator // 외에 .editor, .browser 특성이 있다.
        }
        
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        updateSnapShot()
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row){
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        cell.contentConfiguration = contentConfiguration
        cell.tintColor = .todayPrimaryTint
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        }
    }
    
    private func updateSnapShot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems([Row.title, Row.date, Row.time, Row.notes], toSection: 0)
        dataSource.apply(snapshot)
        
    }
    
}
