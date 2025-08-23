//
//  API_ChallangeTests.swift
//  API-ChallangeTests
//
//  Created by Gustavo Ferreira bassani on 20/08/25.
//

import XCTest
@testable import API_Challange

final class API_ChallangeTests: XCTestCase {
    
    
    // MARK: - HomeViewModel
    func test_HomeViewModel_WhenAPI_Doesnot_Fail() async throws {
        //GIVEN
        let mockedserviceAPI = MockedAPIService(shouldFail: false)
        let mockedStoreService = MockedStoreService(shouldFail: false)
        
        let homeViewModel = HomeViewModel(serviceAPI: mockedserviceAPI, storeFavorites: mockedStoreService)
        
        //WHEN
        await homeViewModel.loadProducts()
        try? homeViewModel.getFavorites()
        
        
        /// BEFORE: add toggleFavorite(3)
        XCTAssertFalse(homeViewModel.favorites.contains(where: { $0.productID == 3 }))
        XCTAssertFalse(homeViewModel.isFavorite(3))
        
        homeViewModel.toggleFavorite(3)
        
        // THEN
        XCTAssertNotNil(homeViewModel.products)
        XCTAssertTrue(homeViewModel.dealOfDay.id == 1)
        XCTAssertTrue(homeViewModel.favorites.contains(where: { $0.productID == 2 }))
        XCTAssertFalse(homeViewModel.favorites.contains(where: { $0.productID == 4 }))
        XCTAssertTrue(homeViewModel.isFavorite(2))
        XCTAssertFalse(homeViewModel.isFavorite(4))
        XCTAssertNil(homeViewModel.errorMessage)
        
        
    }
    
    func test_homeViewModel_loadProducts_whenAPIFails() async throws {
        // GIVEN
        let mockedserviceAPI = MockedAPIService(shouldFail: true)
        let mockedStoreService = MockedStoreService(shouldFail: false)
        let homeViewModel = HomeViewModel(serviceAPI: mockedserviceAPI, storeFavorites: mockedStoreService)
        
        // WHEN
        await homeViewModel.loadProducts()
        try? homeViewModel.getFavorites()
        
        // THEN
        XCTAssertEqual(homeViewModel.state, .error)
        XCTAssertNotNil(homeViewModel.errorMessage)
    }
    
    // MARK: - Orders
    func test_Orders_WhenAPIService_Doesnot_Fail() async throws {
        
        //GIVEN
        let mockedStoreService = MockedStoreService(shouldFail: false)
        let homeViewModel = OrdersViewModel(storeService: mockedStoreService)
        
        // WHEN
        await homeViewModel.loadView()
        homeViewModel.storeService.saveToOrders("", price: 0, image: "")
        homeViewModel.search(by: "testeSearch")
        
        //THEN
        XCTAssertNotNil(homeViewModel.orders)
        
    }
    
    func teste_Order_WhenAPIService_shouldFail() async throws {
        
        //GIVEN
        let mockedStoreService = MockedStoreService(shouldFail: true)
        let homeViewModel = OrdersViewModel(storeService: mockedStoreService)
        
        //WHEN
        await homeViewModel.loadView()
        homeViewModel.storeService.saveToOrders("", price: 0, image: "")
        homeViewModel.search(by: "testeSearch")
        
        //THEN
        XCTAssertNotNil(homeViewModel.errorMessage)
        
        
    }
    
    // MARK: - Cart
    func test_CartViewModel_WhenAPIService_doesnot_Fail() async throws {
        
        //GIVEN
        let mockedStoreService = MockedStoreService(shouldFail: false)
        let mockedAPIService = MockedAPIService(shouldFail: false)
        let cartViewModel = CartViewModel(serviceAPI: mockedAPIService, serviceStore: mockedStoreService)
        
        mockedAPIService.mockProducts = [ProductModel(id: 1, title: "", description: "", category: "", price: 1, discountPercentage: 1, thumbnail: "")]
        
        let cartDisplayItems = CartDisplayItem(product: ProductModel(id: 1, title: "", description: "", category: "", price: 1, discountPercentage: 1, thumbnail: ""), cartItem: Cart(productID: 1))
        
        //WHEN
        
        await cartViewModel.loadCart()
        cartViewModel.increaseQuantity(for: cartDisplayItems)
        cartViewModel.decreaseQuantity(for: cartDisplayItems)
        
        //THEN
        XCTAssertFalse(cartViewModel.cartDisplayItems.isEmpty)
        
        //AFTER SAVE TO ORDERS
        await cartViewModel.saveToOrders()
        
        //THEN
        XCTAssertTrue(cartViewModel.cartDisplayItems.isEmpty)
        
    }
    
    func test_CartViewModel_WhenAPIService_shouldFail() async throws {
        
        //GIVEN
        let mockedStoreService = MockedStoreService(shouldFail: true)
        let mockedAPIService = MockedAPIService(shouldFail: false)
        let cartViewModel = CartViewModel(serviceAPI: mockedAPIService, serviceStore: mockedStoreService)
        
        //WHEN
        await cartViewModel.loadCart()
        
        //THEN
        XCTAssertNotNil(cartViewModel.errorMessage)
        
    }
    
    // MARK: - Favorite
    func teste_FavoriteViewModel_WhenAPIService_Doesnot_Fail() async throws {
        
        //GIVEN
        let mockedStoreService = MockedStoreService(shouldFail: false)
        let mockedAPIService = MockedAPIService(shouldFail: false)
        let favoriteViewModel = FavoritesViewModel(serviceAPI: mockedAPIService, storeFavorites: mockedStoreService)
        
        //WHEN - with favorite products
        
        await favoriteViewModel.loadingFavorites()
        favoriteViewModel.getFavorites()
        await favoriteViewModel.getFavoriteProducts()
        favoriteViewModel.toggleFavorite(3)
        
        
        //THEN
        XCTAssertFalse(favoriteViewModel.favorites.isEmpty)
        XCTAssertFalse(favoriteViewModel.favProducts.isEmpty)
        
    }
    
    func teste_FavoriteViewModel_WhenStoreService_ShouldFail() async throws {
        
        //GIVEN
        let mockedStoreService = MockedStoreService(shouldFail: true)
        let mockedAPIService = MockedAPIService(shouldFail: true)
        let favoriteViewModel = FavoritesViewModel(serviceAPI: mockedAPIService, storeFavorites: mockedStoreService)
        
        //WHEN - with favorite products
        
        await favoriteViewModel.loadingFavorites()
        favoriteViewModel.getFavorites()
        await favoriteViewModel.getFavoriteProducts()
        
        //THEN
        
        XCTAssertTrue(favoriteViewModel.favorites.isEmpty)
        XCTAssertTrue(favoriteViewModel.favProducts.isEmpty)
        
    }
    
    // MARK: - CATEGORIES
    func test_CategoriesViewModel_WhenStoreService_Doesnot_Fail() async throws {
        
        //GIVEN
        let mockedAPIService = MockedAPIService(shouldFail: false)
        let categoriesViewModel = CategoriesViewModel(service: mockedAPIService)

        //WHEN
        await categoriesViewModel.loadCategories()
        categoriesViewModel.search(by: "testSearch")
        
        //THEN
        XCTAssertTrue(categoriesViewModel.fourRandomCategories.count == 4)
        XCTAssertFalse(categoriesViewModel.allCategories.isEmpty)
        
    }
    
    func test_CategoriesViewModel_WhenStoreService_ShouldFail() async throws {
        
        //GIVEN
        let mockedAPIService = MockedAPIService(shouldFail: true)
        let categoriesViewModel = CategoriesViewModel(service: mockedAPIService)

        //WHEN
        await categoriesViewModel.loadCategories()
        
        //THEN
        XCTAssertTrue(categoriesViewModel.fourRandomCategories.isEmpty)
        XCTAssertTrue(categoriesViewModel.allCategories.isEmpty)
        XCTAssertNotNil(categoriesViewModel.errorMessage)
    }
    
    // MARK: - CATEGORIES1
    
    func test_Categories1ViewModel_WhenAPIandStoreService_Doesnot_Fail() async throws {
        
        //GIVEN
        let mockedStoreService = MockedStoreService(shouldFail: false)
        let mockedAPIService = MockedAPIService(shouldFail: false)
        let categories1ViewModel = Categories1ViewModel(serviceAPI: mockedAPIService, serviceFavorites: mockedStoreService)
        let category = CategoryModel(slug: "testCategory", name: "testCategory", url: "testCategory")

        //WHEN
        await categories1ViewModel.loadProducts(category: category)
        categories1ViewModel.toggleFavorite(3)
        categories1ViewModel.getFavorites()
     
        
        //THEN
        XCTAssertTrue(categories1ViewModel.isFavorite(2))
        XCTAssertFalse(categories1ViewModel.productsFromCategory.isEmpty)
        XCTAssertFalse(categories1ViewModel.favorites.isEmpty)
    
        
    }
    
    func test_Categories1ViewModel_WhenAPIService_ShouldFail() async throws {
        
        //GIVEN
        let mockedStoreService = MockedStoreService(shouldFail: false)
        let mockedAPIService = MockedAPIService(shouldFail: true)
        let categories1ViewModel = Categories1ViewModel(serviceAPI: mockedAPIService, serviceFavorites: mockedStoreService)
        let category = CategoryModel(slug: "testCategory", name: "testCategory", url: "testCategory")
        
        //WHEN
        await categories1ViewModel.loadProducts(category: category)
        
        //THEN
        XCTAssertNotNil(categories1ViewModel.errorMessage)
        
    }
    
    // MARK: - PRODUCT DETAILS
    
    func test_ProductDetailsViewModel_WhenAPIandStoreService_Doesnot_Fail() async throws {
        
        //GIVEN
        let mockedStoreService = MockedStoreService(shouldFail: false)
        let mockedAPIService = MockedAPIService(shouldFail: false)
        let product = ProductModel(id: 1, title: "", description: "", category: "", price: 1, discountPercentage: 1, thumbnail: "")
        
       let productDetailViewModel = ProductDetailViewModel(storeService: mockedStoreService, product: product)
        
        //WHEN
        
        productDetailViewModel.addToCart(5)
        
        //THEN
        XCTAssertTrue(mockedStoreService.arrayOfCart.contains(where: { cart in cart.productID == 5 }))
        XCTAssertTrue(productDetailViewModel.stringPrice == NumberFormatterManager.shared.doubleToString(1))
        
        
    }
    
    
}
