//
//  ContentView.swift
//  CafeWithClassesandListsLiu
//
//  Created by ALLEN LIU on 10/2/26.
//

import Observation
import SwiftUI

struct ContentView: View {

    // Inventory
    @State var inventory = [
        Item(
            name: "Melon Soda",
            price: 5.00,
            ingredients: [
                Ingredients(thing: "Carbonated Water"),
                Ingredients(thing: "Melon Extract"),
                Ingredients(thing: "Vanilla Ice cream scoop"),
            ],
            FoodImg: Image("メロンソーだ"),
            calories: 250
        ),
        Item(
            name: "Chocolate Muffin",
            price: 2.00,
            ingredients: [
                Ingredients(thing: "Chocolate Drizzle"),
                Ingredients(thing: "Chocolate Chips"),
                Ingredients(thing: "Wrapper"),
            ],
            FoodImg: Image("Chocolate Muffin"),
            calories: 300
        ),
        Item(
            name: "Matcha latte",
            price: 5.00,
            ingredients: [
                Ingredients(thing: "Ice Cubes"),
                Ingredients(thing: "Matcha powder"),
                Ingredients(thing: "Milk"),
            ],
            FoodImg: Image("iced-matcha-latte"),
            calories: 150
        ),
        Item(
            name: "Chicken Sandwich",
            price: 8.00,
            ingredients: [
                Ingredients(thing: "Tomato"),
                Ingredients(thing: "lettuce"),
                Ingredients(thing: "chicken"),
                Ingredients(thing: "mayo"),
            ],
            FoodImg: Image("Chicken Sandwich"),
            calories: 500
        ),
        Item(
            name: "Sushi platter",
            price: 35.00,
            ingredients: [
                Ingredients(thing: "Soy Sauce"),
                Ingredients(thing: "Seaweed"),
                Ingredients(thing: "Wasabi"),
                Ingredients(thing: "Salmon"),
                Ingredients(thing: "Tuna"),

            ],
            FoodImg: Image("ss platter"),
            calories: 1250
        ),
    ]

    // Actual cart array
    @State var cart: [Item] = []

    var body: some View {
        NavigationStack {
            VStack {

                // Title
                Text("Cafe Menu")
                    .font(.largeTitle)
                    .bold()
                    .background(
                        Capsule(style: .circular)
                            .frame(width: 250, height: 70)
                            .foregroundStyle(.thinMaterial)
                    )
                    .padding()

                // Menu List
                List {
                    ForEach(inventory) { thing in
                        // Only 2 labeled arguments needed here:
                        ShopItemRow(product: thing, cart: $cart)
                            .listRowBackground(Color(.brown))
                            .listRowSeparator(.hidden)
                            .listRowInsets(
                                EdgeInsets(
                                    top: 4,
                                    leading: 16,
                                    bottom: 4,
                                    trailing: 16
                                )
                            )
                    }
                }
                .listStyle(.plain)

                // Cart Button
                NavigationLink(destination: CartView(cart: $cart)) {
                    Label("Cart (\(cart.count))", systemImage: "cart.fill")
                        .foregroundStyle(.black)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 140, height: 50)
                                .foregroundStyle(.thinMaterial)
                        )
                }
                .padding(.bottom, 20)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.brown)
        }
    }
}

struct ShopItemRow: View {

    var product: Item
    @Binding var cart: [Item]

    var itemCount: Int {
        cart.filter { $0.name == product.name }.count
    }

    var body: some View {
        HStack {

            NavigationLink {
                DetailView(item: product)
            } label: {

                product.FoodImg
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)

                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                        .fontWeight(.semibold)

                    Text("Price: $\(product.price, specifier: "%.2f")")
                        .font(.subheadline)
                }
            }

            Spacer()

            Button {
                cart.append(product.makeCopy())
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            .buttonStyle(.borderless)

            Text("\(itemCount)")
                .font(.body)
                .bold()
                .frame(minWidth: 24)

            // Minus Button: Removes one copy from cart
            Button {
                if let index = cart.lastIndex(where: { $0.name == product.name }
                ) {
                    cart.remove(at: index)
                }
            } label: {
                Image(systemName: "minus.circle.fill")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            .buttonStyle(.borderless)
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }
}

#Preview {
    ContentView()
}
