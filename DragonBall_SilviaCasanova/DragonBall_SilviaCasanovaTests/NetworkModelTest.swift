//
//  NetworkModelTest.swift
//  DragonBall_SilviaCasanovaTests
//
//  Created by Silvia Casanova Martinez on 28/9/23.
//

import XCTest
@testable import DragonBall_SilviaCasanova

final class NetworkModelTest: XCTestCase {
    private var sut: NetworkModel!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        sut = NetworkModel(session: session)
    }
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testLogin() {
        let expectedtoken = "Sometoken"
        let someUser = "SomeUser"
        let somePassword = "SomePassword"
        MockURLProtocol.requestHandler = { request in
            let loginString = String(format: "%@:%@", someUser, somePassword)
            let loginData = loginString.data(using: .utf8)!
            let base64LoginString = loginData.base64EncodedString()
            
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"),
                           "Basic \(base64LoginString)")
            let data = try XCTUnwrap(expectedtoken.data(using: .utf8))
            let response = try XCTUnwrap(HTTPURLResponse(
                url: URL(string: "http://dragonball.keepcoding.education")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]))
            return (response, data)
        }
        
        let expectation = expectation(description: "Login succes")
        sut.login(user:someUser,
                  password: somePassword) {
            result in
            guard case let .success(token) = result else {
                XCTFail("Expected succes but received \(result)")
                return
            }
            XCTAssertEqual(token, expectedtoken)
            expectation.fulfill()
        }
        wait(for: [expectation])
        
        
    }
    func testGetHero() {
        let token = "SomeToken"
        let photoURL = URL(string: "http://dragonball.keepcoding.education")
     
       
        
        let hero1: [Hero] = [Hero(id: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94",
                              name: "Goku",
                              description: "Sobran las presentaciones cuando se habla de Goku...",
                                  photo: URL(string: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300")!,
                              favorite: false)]

    
        let jsonString = """
        [
            {
                "description": "Sobran las presentaciones cuando se habla de Goku...",
                "favorite": false,
                "photo": "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
                "name": "Goku",
                "id": "D13A40E5-4418-4223-9CE6-D2F9A28EBE94"
            }
        ]
        """
        let expectedtoken = "Sometoken"
        let someUser = "SomeUser"
        let somePassword = "SomePassword"
        let loginString = String(format: "%@:%@", someUser, somePassword)
        let loginData = loginString.data(using: .utf8)!
        let base64LoginString = loginData.base64EncodedString()
        MockURLProtocol.requestHandler = { request in
            var urlComponents = URLComponents()
            urlComponents.queryItems = [URLQueryItem(name: "name", value: "Goku")]
            
            XCTAssertEqual(request.httpMethod, "POST")
            let data = try XCTUnwrap( jsonString.data(using: .utf8) )
            let response = try XCTUnwrap(HTTPURLResponse(
                url: URL(string: "http://dragonball.keepcoding.education")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]))
            return (response, data)
            
        }
        let expectation = expectation(description: "Get Heroe succes")
        sut.getHeroes {
            result in
            guard case let .success(heroes) = result else {
                print("tenemos result(\(result)")
                XCTFail("Expected succes but received \(result)")
                print("tenemos result2(\(result)")
                return
            }
            XCTAssertEqual(heroes, hero1)
            expectation.fulfill()
        }
        wait(for: [expectation])
        
    }
    
    
    
    
    
    
    //OHHTTPStubs
    final class MockURLProtocol: URLProtocol {
        static var error: NetworkModel.NetworkError?
        static var requestHandler:((URLRequest) throws -> (HTTPURLResponse, Data))?
        
        override class func canInit(with request: URLRequest) -> Bool {
            return true
        }
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        override func startLoading() {
            if let error = MockURLProtocol.error {
                client?.urlProtocol(self, didFailWithError: error)
                return
            }
            guard let handler = MockURLProtocol.requestHandler else {
                assertionFailure("Received Unespected request with no handler")
                return
            }
            do {
                let (response, data) = try handler(request)
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            } catch{
                client?.urlProtocol(self, didFailWithError: error)
            }
        }
        override func stopLoading() {}
    }
    
}
