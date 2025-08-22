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
        
        
        // BEFORE: add toggleFavorite(3)
        XCTAssertFalse(homeViewModel.favorites.contains(where: { $0.productID == 3 }))
        XCTAssertFalse(homeViewModel.isFavorite(3))
        let initialCount = homeViewModel.favorites.count
        
        homeViewModel.toggleFavorite(3)
        
        // THEN
        XCTAssertNotNil(homeViewModel.products)
        XCTAssertTrue(homeViewModel.dealOfDay.id == 1)
        XCTAssertTrue(homeViewModel.favorites.contains(where: { $0.productID == 3 }))
        XCTAssertFalse(homeViewModel.favorites.contains(where: { $0.productID == 4 }))
        XCTAssertTrue(homeViewModel.isFavorite(3))
        XCTAssertFalse(homeViewModel.isFavorite(4))
        XCTAssertEqual(homeViewModel.favorites.count, initialCount + 1)
        XCTAssertNil(homeViewModel.errorMessage)
        
        
    }
    
    func test_homeViewModel_loadProducts_whenAPIFails_shouldTransitionToErrorState() async throws {
        // GIVEN
        let mockedserviceAPI = MockedAPIService(shouldFail: false)
        let mockedStoreService = MockedStoreService(shouldFail: true)
        let homeViewModel = HomeViewModel(serviceAPI: mockedserviceAPI, storeFavorites: mockedStoreService)
        
        // WHEN
        await homeViewModel.loadProducts()
        homeViewModel.getFavorites()
        
        // THEN
        XCTAssertNil(homeViewModel.products)
        XCTAssertEqual(homeViewModel.state, .error)
        XCTAssertNotNil(homeViewModel.errorMessage) // MUDOU NADAA
        XCTAssertNotNil(homeViewModel.noFavorites) // MUDA NADA
        XCTAssertThrowsError(homeViewModel.getFavorites()) // ???
        
    }
    
}
