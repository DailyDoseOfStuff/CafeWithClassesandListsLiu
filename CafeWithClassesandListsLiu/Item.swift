//
//  item.swift
//  CafeWithClassesandListsLiu
//
//  Created by ALLEN LIU on 10/2/26.
//

import SwiftData
import SwiftUI

struct Ingredients: Codable, Hashable {
    var thing: String
    var amt: Int

    init(thing: String) {
        self.thing = thing
        self.amt = 1
    }

    init(thing: String, amt: Int) {
        self.thing = thing
        self.amt = amt
    }
}

@Model
class Item {
    var price: Double
    var amt: Int = 0
    var name: String
    var calories: Int
    var ingredients: [Ingredients]

    @Transient private var storedImage: Image?

    var FoodImg: Image {
        get {
            if let storedImage {
                return storedImage
            }
            switch name {
            case "Melon Soda": return Image("メロンソーだ")
            case "Chocolate Muffin": return Image("Chocolate Muffin")
            case "Matcha latte": return Image("iced-matcha-latte")
            case "Chicken Sandwich": return Image("Chicken Sandwich")
            case "Sushi platter": return Image("ss platter")
            default: return Image(name)
            }
        }
        set {
            storedImage = newValue
        }
    }

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
        self.calories = calories
        self.storedImage = FoodImg
    }

    func makeCopy() -> Item {
        var copiedIngredients: [Ingredients] = []

        for ing in self.ingredients {
            let newIngredient = Ingredients(thing: ing.thing, amt: ing.amt)
            copiedIngredients.append(newIngredient)
        }

        let copy = Item(
            name: self.name,
            price: self.price,
            ingredients: copiedIngredients,
            FoodImg: self.FoodImg,
            calories: self.calories
        )
        copy.amt = self.amt
        return copy
    }
}
