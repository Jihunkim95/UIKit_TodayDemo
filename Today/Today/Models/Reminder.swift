//
//  Reminder.swift
//  Today
//
//  Created by 김지훈 on 2024/04/12.
//

import Foundation


struct Reminder {
    var title: String
    var dueDate: Date
    var notes: String? = nil
    var isComplete: Bool = false
}


#if DEBUG
extension Reminder {
    static var sampleData = [
        Reminder(
            title: "비용 보고서 제출", dueDate: Date().addingTimeInterval(800.0),
            notes: "택시 영수증 잊지 마세요"),
        Reminder(
            title: "코드 리뷰", dueDate: Date().addingTimeInterval(14000.0),
            notes: "공유 폴더에서 기술 사양 확인", isComplete: true),
        Reminder(
            title: "새 콘택트렌즈 수령", dueDate: Date().addingTimeInterval(24000.0),
            notes: "안과는 오후 6시에 문을 닫습니다"),
        Reminder(
            title: "회고록에 노트 추가", dueDate: Date().addingTimeInterval(3200.0),
            notes: "프로젝트 매니저와 협업", isComplete: true),
        Reminder(
            title: "새 프로젝트 매니저 후보 인터뷰",
            dueDate: Date().addingTimeInterval(60000.0), notes: "포트폴리오 검토"),
        Reminder(
            title: "온보딩 경험 모형 작업", dueDate: Date().addingTimeInterval(72000.0),
            notes: "차별화된 접근 방식 고려"),
        Reminder(
            title: "사용자 분석 리뷰", dueDate: Date().addingTimeInterval(83000.0),
            notes: "경영진과 트렌드 논의"),
        Reminder(
            title: "단체 예약 확인", dueDate: Date().addingTimeInterval(92500.0),
            notes: "난방기 사용 가능 여부 확인"),
        Reminder(
            title: "TestFlight에 베타 테스터 추가", dueDate: Date().addingTimeInterval(101000.0),
            notes: "금요일에 v0.9 배포")
    ]
}
#endif
