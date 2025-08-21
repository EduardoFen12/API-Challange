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
        
        let homeViewModel = HomeViewModel(serviceAPI: mockedserviceAPI, storeFavorites: mockedStoreService)
        
        //WHEN
//        await mockedHomeViewModel.loadProducts()
//        mockedHomeViewModel.toggleFavorite(3)
        
        // THEN
        XCTAssertFalse(homeViewModel.products.isEmpty)
        XCTAssertTrue(homeViewModel.dealOfDay.id == 1)
                
    }
    
    func test_loadProducts_whenAPIFails_shouldTransitionToErrorState() {
        
        let mockedserviceAPI = MockedAPIService(shouldFail: true)
        let mockedStoreService = MockedStoreService(shouldFail: false)
        
        let mockedHomeViewModel = HomeViewModel(serviceAPI: mockedserviceAPI, storeFavorites: mockedStoreService)
        
        
    }
    
    func test_toggleFavorite_shouldCallPersistenceServiceWithCorrectID() {
        
        
    }
}
