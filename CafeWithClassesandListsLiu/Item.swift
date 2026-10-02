//
//  item.swift
//  CafeWithClassesandListsLiu
//
//  Created by ALLEN LIU on 10/2/26.
//

import SwiftUI

struct Ingredients {
    var thing: String
    var amt: Int

    init(thing: String) {
        self.thing = thing
        self.amt = 1
    }
    
    init(thing: String, amt: Int){
        self.thing = thing
        self.amt = 1
    }

}

@Observable
class Item: Identifiable {
    var price: Double
    var amt: Int = 0
    var name: String
    var calories: Int
    var ingredients: [Ingredients]
    var FoodImg: Image

    init(
        name: String,
        price: Double,
        ingredients: [Ingredients],
        FoodImg: Image,
        calories: Int
    ) {
        self.name = name
        self.price = price
        self.ingredients = ingredients
        self.FoodImg = FoodImg
        self.calories = calories
    }

    func makeCopy() -> Item {
        var copiedIngredients: [Ingredients] = []
        
        for ing in self.ingredients {
            var newIngredient = Ingredients(thing: ing.thing)
            newIngredient.amt = ing.amt
            copiedIngredients.append(newIngredient)
        }
        
        return Item(
            name: self.name,
            price: self.price,
            ingredients: copiedIngredients,
            FoodImg: self.FoodImg,
            calories: self.calories
        )
    }
}
