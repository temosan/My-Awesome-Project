//
//  CellDataModel
//  Sample001-Swift
//
//  Created by 박영호 on 2021/01/05.
//

/// 메인 화면 테이블 셀의 데이터 모델
struct CellData: Decodable {
    var image: String
    var title: String
    var description: String
}
/// JSON파일 디코드를 위한 구조 구현
struct CellDataes: Decodable {
    var data:[CellData]
}
