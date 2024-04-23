//
//  ReminderViewController.swift
//  Today
//
//  Created by 김지훈 on 2024/04/22.
//

import UIKit

class ReminderViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    var reminder: Reminder
    private var dataSource: DataSource!
    
    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfiguartion = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguartion.showsSeparators = false
        listConfiguartion.headerMode = .firstItemInSection
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(toggleEditing))
        updateSnapshotForViewing()
    }
    
    @objc func toggleEditing(){
        // 편집 상태 토글
        isEditing = !isEditing
        
        // 타이틀 업데이트
        if let editButton = navigationItem.rightBarButtonItem {
            editButton.title = isEditing ? "완료" : "편집"
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            updateSnapshotForEditing()
        } else {
            updateSnapshotForViewing()
        }
    }
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row){
        let section = section(for: indexPath)
        switch (section, row) {
        case (_, .header(let title)):
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = title
            cell.contentConfiguration = contentConfiguration
            
        case (.view, _):
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = text(for: row)
            contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
            contentConfiguration.image = row.image
            cell.contentConfiguration = contentConfiguration
            cell.tintColor = .todayPrimaryTint
        default:
            fatalError("Unexpected combination of section and row")
        }

    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        default: return nil
        }
    }
    
    private func updateSnapshotForEditing() {
        var snapShot = Snapshot()
        snapShot.appendSections([.title, .date, .notes])
        snapShot.appendItems([.header(Section.title.name)], toSection: .title)
        snapShot.appendItems([.header(Section.date.name)], toSection: .date)
        snapShot.appendItems([.header(Section.notes.name)], toSection: .notes)
        dataSource.apply(snapShot)
    }
    
    private func updateSnapshotForViewing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems([Row.header(""),Row.title, Row.date, Row.time, Row.notes], toSection: .view)
        dataSource.apply(snapshot)
        
    }
    
    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
    
}
