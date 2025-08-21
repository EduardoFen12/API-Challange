//
//  API_ChallangeTests.swift
//  API-ChallangeTests
//
//  Created by Gustavo Ferreira bassani on 20/08/25.
//

import XCTest
@testable import API_Challange

struct API_ChallangeTests {

    func test_HomeViewModel_fetchProducts() async throws {
        //GIVEN
        let mockedserviceAPI = MockedAPIService(shouldFail: false)
        let mockedStoreService = MockedStoreService(shouldFail: false)
        
        let mockedHomeViewModel = HomeViewModel(serviceAPI: mockedserviceAPI, serviceFavorites: mockedStoreService)
        
        //WHEN
        await mockedHomeViewModel.loadProducts()

        
        // THEN
        XCTAssertTrue(mockedHomeViewModel.)

        
    }
    
    func test_loadProducts_whenAPIFails_shouldTransitionToErrorState() {
        
        
    }
    
    func test_toggleFavorite_shouldCallPersistenceServiceWithCorrectID() {
        
        
    }
    
    

}
