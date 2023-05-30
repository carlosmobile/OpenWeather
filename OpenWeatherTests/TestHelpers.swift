//
//  OpenWeatherTests.swift
//  OpenWeatherTests
//
//  Created by Carlos on 30/5/23.
//


import XCTest
@testable import OpenWeather

class TestHelpers: XCTestCase {
    
    func testSpinnerController() throws {
        let spinnerTest = SpinnerViewController()
        spinnerTest.loadView()
        XCTAssertNotNil(spinnerTest, "load spinner failed")
    }
    
    func testThemeManager() throws {
        let color = ThemeColor.default.OWColor
        XCTAssertNotNil(color, "color theme failed")
    }
    
    func testStringExtensions() throws {
        let stringCapitalizedTest = "test string"
        var stringLocalizedTest = ""
        stringLocalizedTest = "weatherHourly".localized
        XCTAssertNotEqual(stringLocalizedTest, "")
        XCTAssertEqual(stringCapitalizedTest.capitalizedSentence, "Test string")
    }
    
    func testHourFromOpenWeatherHourlyDT() throws {
        let hour = getHourFromOpenWeatherHourlyDT(dt: 1685448000)
        XCTAssertEqual(hour, "2 PM")
    }
    
    func testLocalePreferredLanguageCode() throws {
        let locale = Locale.preferredLanguageCode
        XCTAssertNotNil(locale, "error geting locale")
    }
    
    func testDownloadImageWithThirdPartyLibrary() throws {

        let testImage = UIImage.init(named: "orig.png", in: Bundle.init(for: TestHelpers.self), compatibleWith: nil)!

        let imageURL = getIconURLFromIconName(icon: "03d")
        let imageView = UIImageView()

        imageView.image = testImage
        var imageViewDownloaded = UIImageView()
        imageViewDownloaded = downloadImageWithThirdPartyLibraryTest(imageView: imageViewDownloaded, url: imageURL)

        XCTAssertNotNil(imageView.image?.size)
        XCTAssertNotNil(imageViewDownloaded.image?.size)
        XCTAssertEqual(CGSize(width: 718.0, height: 718.0), imageView.image?.size)
        XCTAssertEqual(CGSize(width: 100.0, height: 100.0), imageViewDownloaded.image?.size)
    }
    
    private func downloadImageWithThirdPartyLibraryTest(imageView: UIImageView, url: URL) -> UIImageView {

        let keysExpectation = expectation(description: "Keys")

        imageView.kf.setImage(
            with: url,
            options: [
                .transition(.none),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success( _):
                keysExpectation.fulfill()
            case .failure( _):
                XCTAssert(false)
            }
        }

        self.waitForExpectations(timeout: 5, handler: nil)

        return imageView
    }
}
