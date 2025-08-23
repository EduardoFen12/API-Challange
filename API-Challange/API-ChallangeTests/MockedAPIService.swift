//
//  MockedAPIService.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 20/08/25.
//
@testable import API_Challange
import Foundation

enum MockAPIError: Error {
    case forcedFailure
}

class MockedAPIService: ProductAPIServiceProtocol {
        
    var shouldFail: Bool
    var mockProducts: [ProductModel]
    var mockCategories: [CategoryModel]
    var mockSingleProduct: ProductModel
    
    var oneCategoryModel: CategoryModel = CategoryModel(slug: "testSearch", name: "testSearch", url: "testSearch")
    var oneMockProduct: ProductModel = ProductModel(id: 1, title: "", description: "", category: "", price: 1, discountPercentage: 1, thumbnail: "")
        
    init(
        shouldFail: Bool = false,
        mockSingleProduct: ProductModel = ProductModel(
            id: 1,
            title: "Default Product",
            description: "This is a default mock product.",
            category: "default-category",
            price: 99.99,
            discountPercentage: 10.0,
            thumbnail: "https://example.com/image.png"
        )
    ) {
        self.shouldFail = shouldFail
        self.mockProducts = [oneMockProduct,oneMockProduct]
        self.mockSingleProduct = mockSingleProduct
        self.mockCategories = [oneCategoryModel,oneCategoryModel,oneCategoryModel,oneCategoryModel]
    }
    
    // MARK: - Protocol Methods
    
    func getCategories() async throws -> [CategoryModel] {
        if shouldFail {
            throw MockAPIError.forcedFailure
        }
        return mockCategories
    }
    
    func getAllProducts() async throws -> [ProductModel] {
        if shouldFail {
            throw MockAPIError.forcedFailure
        }
        return mockProducts
    }
    
    func getProduct(number: Int) async throws -> ProductModel {
        if shouldFail {
            throw MockAPIError.forcedFailure
        }

        return mockSingleProduct
    }
    
    func getRandomProduct() async throws -> ProductModel {
        if shouldFail {
            throw MockAPIError.forcedFailure
        }
        return mockSingleProduct
    }
    
    func getFiltredProducts(by ids: [Int]) async throws -> [ProductModel] {
        if shouldFail {
            throw MockAPIError.forcedFailure
        }

        var filtredProducts: [ProductModel] = []
        ids.forEach { id in
            filtredProducts.append(ProductModel(id: id, title: "", description: "", category: "", price: 1, discountPercentage: 1, thumbnail: ""))
        }
        
        
        return filtredProducts
    }
    
    func getFourRandomCategories() async throws -> [CategoryModel] {
        if shouldFail {
            throw MockAPIError.forcedFailure
        }

        return mockCategories
    }
    
    func getProductsByCategory(by category: String) async throws -> [ProductModel] {
        if shouldFail {
            throw MockAPIError.forcedFailure
        } else {
            return mockProducts
        }
    }
}
