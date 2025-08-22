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
        await homeViewModel.loadProducts()
        homeViewModel.getFavorites()
        homeViewModel.toggleFavorite(3)
        
        // THEN
        XCTAssertFalse(homeViewModel.products.isEmpty)
        XCTAssertTrue(homeViewModel.dealOfDay.id == 1)
        XCTAssertTrue(homeViewModel.favorites.contains(where: {$0.productID == 3}))
        XCTAssertFalse(homeViewModel.favorites.contains(where: {$0.productID == 4}))
        XCTAssertTrue(homeViewModel.isFavorite(3))
        XCTAssertFalse(homeViewModel.isFavorite(4))
        
        homeViewModel.toggleFavorite(3)
           
        XCTAssertFalse(homeViewModel.isFavorite(3))
                
    }
    
    func test_loadProducts_whenAPIFails_shouldTransitionToErrorState() {
        
        let mockedserviceAPI = MockedAPIService(shouldFail: true)
        let mockedStoreService = MockedStoreService(shouldFail: false)
        
        let mockedHomeViewModel = HomeViewModel(serviceAPI: mockedserviceAPI, storeFavorites: mockedStoreService)
        
        
    }
    
    func test_toggleFavorite_shouldCallPersistenceServiceWithCorrectID() {
        
        
    }
}
