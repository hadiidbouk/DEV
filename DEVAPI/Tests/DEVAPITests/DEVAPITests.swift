import XCTest
@testable import DEVAPI

final class ArticlesTests: XCTestCase {
    func testDecoding() {
        let fileName = "articles-latest"
        guard  let url = Bundle.module.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Cannot find \(fileName).")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let articles = try jsonDecoder.decode([Article].self, from: data)
            XCTAssertEqual(articles.count, 30)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
}
