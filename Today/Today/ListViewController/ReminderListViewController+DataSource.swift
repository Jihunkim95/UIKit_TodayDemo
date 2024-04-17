//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by 김지훈 on 2024/04/17.
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int,String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    func cellRegisterationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let reminder = Reminder.sampleData[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        cell.contentConfiguration = contentConfiguration
    }
    
}
