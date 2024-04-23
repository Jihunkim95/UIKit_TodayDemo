//
//   ReminderViewController+Row.swift
//  Today
//
//  Created by 김지훈 on 2024/04/22.
//

import UIKit

extension ReminderViewController {
    enum Row: Hashable {
        case header(String)
        case date
        case notes
        case time
        case title
        
        var imageName: String? {
            switch self {
            case .date:
                return "calendar.cicle"
            case .notes:
                return "square.and.pencil"
            case .time:
                return "clock"
            default:
                return nil
            }
        }

        var image: UIImage? {
            guard let imageName = imageName else { return nil }
            let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName, withConfiguration: configuration)
        }
        
        var textStyle: UIFont.TextStyle {
            switch self {
            case .title: return .headline
            default: return .subheadline
            }
        }
    }
}
