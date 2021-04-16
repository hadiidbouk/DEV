import XCTest
@testable import DEVAPI

final class ArticlesTests: XCTestCase {
    func testLatestDecoding() {
        let fileName = "articles-latest"
        testArticlesDecoding(from: fileName)
    }

    func testAllDecoding() {
        let fileName = "articles"
        testArticlesDecoding(from: fileName)
    }
}

private extension ArticlesTests {
    func testArticlesDecoding(from fileName: String) {
        guard  let url = Bundle.module.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Cannot find \(fileName).")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let articles = try jsonDecoder.decode([Article].self, from: data)
            XCTAssertNotEqual(articles.count, 0)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
}
