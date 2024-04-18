//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by 김지훈 on 2024/04/18.
//

import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
}
