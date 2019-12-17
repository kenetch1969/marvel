//
//  FintonicTests.swift
//  FintonicTests
//
//  Created by Juan Gerardo Cruz on 12/16/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import XCTest
@testable import Fintonic

class FintonicTests: XCTestCase {
    
    var session: URLSession!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = URLSession(configuration: .default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        super.tearDown()
    }

    func testMarvelConnection() {
      // given
      guard let url = URL(string: "https://api.myjson.com/bins/bvyob") else{ return }
      let promise = expectation(description: "Completion handler invoked")
      var statusCode: Int?
      var responseError: Error?

      // when
      let dataTask = session.dataTask(with: url) { data, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        responseError = error
        promise.fulfill()
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)

      // then
      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }
    
    func testMarvelCompletion () {
        let marvelAPI = MarvelUrlAPI()
        let promise = expectation(description: "Completion handler invoked")
        marvelAPI.getMarvelsHeroes { (heroes) in
            print(heroes.superheroes[0].name)
            print(heroes.superheroes[0].photo)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
    func testShowHeroes (){
       let expec = expectation(description: "Recuperar marvel heroes")
        let network = MarvelUrlAPI()
        let presenter = ShowMarvelPresenter(model: network)
        presenter.attachView(delegate: MockUIViewController(expectation: expec))
        presenter.showHeroes()
        wait(for: [expec], timeout: 3)
    }
}

class MockUIViewController: ShowMarvelDelegate{
    var expec: XCTestExpectation
    init(expectation: XCTestExpectation) {
        self.expec = expectation
    }
    func showProgress(){}
    func hideProgress(){}
    func setHeroes(_ heroes: SuperHeroes) {
        XCTAssertNotNil(heroes, "Recuperacion exitosa")
        self.expec.fulfill()
    }
}
