//
//  DataTransferServiceTests.swift
//  FriendList
//
//  Created by Huy Nguyen on 11/06/2021.
//

import XCTest
@testable import Networking

private struct MockModel: Decodable {
    let name: String
}

class DataTransferServiceTests: XCTestCase {
    
    private enum DataTransferErrorMock: Error {
        case someError
    }
    
    func test_whenReceivedValidJsonInResponse_shouldDecodeResponseToDecodableObject() {
        //given
        let config = NetworkConfigurableMock()
        let expectation = self.expectation(description: "Should decode mock object")
        
        let responseData = #"{"name": "Hello"}"#.data(using: .utf8)
        let networkService = NetworkServiceDefault(config: config, session: NetworkSessionManagerMock(response: nil,
                                                                                                             data: responseData,
                                                                                                             error: nil))
        
        let sut = APIDataTransferServiceDefault(with: networkService)
        //when
        _ = sut.request(with: Endpoint<MockModel>(path: "http://mock.endpoint.com", method: .get)) { result in
            do {
                let object = try result.get()
                XCTAssertEqual(object.name, "Hello")
                expectation.fulfill()
            } catch {
                XCTFail("Failed decoding MockObject")
            }
        }
        //then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_whenInvalidResponse_shouldNotDecodeObject() {
        //given
        let config = NetworkConfigurableMock()
        let expectation = self.expectation(description: "Should not decode mock object")
        
        let responseData = #"{"age": 20}"#.data(using: .utf8)
        let networkService = NetworkServiceDefault(config: config, session: NetworkSessionManagerMock(response: nil,
                                                                                                             data: responseData,
                                                                                                             error: nil))
        
        let sut = APIDataTransferServiceDefault(with: networkService)
        //when
        _ = sut.request(with: Endpoint<MockModel>(path: "http://mock.endpoint.com", method: .get)) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch {
                expectation.fulfill()
            }
        }
        //then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_whenBadRequestReceived_shouldRethrowNetworkError() {
        //given
        let config = NetworkConfigurableMock()
        let expectation = self.expectation(description: "Should throw network error")
        
        let responseData = #"{"invalidStructure": "Nothing"}"#.data(using: .utf8)!
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 500,
                                       httpVersion: "1.1",
                                       headerFields: nil)
        let networkService = NetworkServiceDefault(config: config, session: NetworkSessionManagerMock(response: response,
                                                                                                             data: responseData,
                                                                                                             error: DataTransferErrorMock.someError))
        
        let sut = APIDataTransferServiceDefault(with: networkService)
        //when
        _ = sut.request(with: Endpoint<MockModel>(path: "http://mock.endpoint.com", method: .get)) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                
                if case APIDataTransferError.networkFailure(NetworkError.error(statusCode: 500, _)) = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Wrong error")
                }
            }
        }
        //then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_whenNoDataReceived_shouldThrowNoDataError() {
        //given
        let config = NetworkConfigurableMock()
        let expectation = self.expectation(description: "Should throw no data error")
        
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 200,
                                       httpVersion: "1.1",
                                       headerFields: [:])
        let networkService = NetworkServiceDefault(config: config, session: NetworkSessionManagerMock(response: response,
                                                                                                             data: nil,
                                                                                                             error: nil))
        
        let sut = APIDataTransferServiceDefault(with: networkService)
        //when
        _ = sut.request(with: Endpoint<MockModel>(path: "http://mock.endpoint.com", method: .get)) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case APIDataTransferError.noResponse = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Wrong error")
                }
            }
        }
        //then
        wait(for: [expectation], timeout: 0.1)
    }
}
