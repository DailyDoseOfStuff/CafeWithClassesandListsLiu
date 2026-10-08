//
//  CartView.swift
//  CafeWithClassesandListsLiu
//
//  Created by ALLEN LIU on 10/5/26.
//

import SwiftUI
import SwiftData

struct CartView: View {


    @Environment(\.modelContext) var context
    @Query var cart: [Item]
    
    
    var orderedItems: [Item] {
        let withQuantity = cart.filter { $0.amt > 0 }
        return withQuantity.isEmpty ? cart : withQuantity
    }

    var total: Double {
        var sum = 0.0
        for thing in orderedItems {
            // Uses amt if set (> 0), otherwise counts the item once
            let quantity = thing.amt > 0 ? Double(thing.amt) : 1.0
            sum += quantity * thing.price
        }
        return sum
    }

    var body: some View {
        VStack {

            // Title
            Text("Cart")
                .font(.largeTitle)
                .bold()
                .background(
                    Capsule(style: .circular)
                        .frame(width: 200, height: 50)
                        .foregroundStyle(.thinMaterial)
                )
                .padding()

            List {
                ForEach(orderedItems) { thing in
                    CartItemRow(
                        product: thing,
                        onRemove: {
                            if thing.amt > 1 {
                                thing.amt -= 1
                            } else {
                                context.delete(thing)
                            }
                            try? context.save()
                        }
                    )
                    .listRowBackground(Color(.green))
                    .listRowSeparator(.hidden)
                    .listRowInsets(
                        EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16)
                    )
                }
            }
            .listStyle(.plain)

            // Total Cost Display
            Text("Total Cost: $\(total, specifier: "%.2f")")
                .font(.title2)
                .bold()
                .padding()
                .background(
                    Capsule(style: .circular)
                        .foregroundStyle(.thinMaterial)
                )
                .padding(.bottom, 20)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green)

    }

}

struct CartItemRow: View {
    var product: Item
    var onRemove: () -> Void

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
                    
                    ForEach(product.ingredients, id: \.thing){
                        ing in
                        
                        if ing.amt > 1 {
                            Text(" \(ing.thing) x \(ing.amt)")
                        }
                        
                    }
                    
                }
            }

            Spacer()

            // Only the Minus Button
            Button {
                onRemove()
            } label: {
                Image(systemName: "minus.circle.fill")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            .buttonStyle(.borderless)
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Item.self, configurations: config)
    
    let sampleItem = Item(
        name: "Ice Latte",
        price: 5.00,
        ingredients: [
            Ingredients(thing: "Water"),
            Ingredients(thing: "Ice"),
            Ingredients(thing: "Milk"),
            Ingredients(thing: "Coffee Concentrate"),
        ],
        FoodImg: Image("cup.and.heat.waves"),
        calories: 200
    )
    sampleItem.amt = 1

    container.mainContext.insert(sampleItem)
    
    return NavigationStack{
        CartView()
    }
    .modelContainer(container)
    
}
