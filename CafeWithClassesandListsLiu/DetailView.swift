//
//  DetailView.swift
//  CafeWithClassesandListsLiu
//
//  Created by ALLEN LIU on 10/6/26.
//

import SwiftUI

struct DetailView: View {

    var item: Item

    var body: some View {
        VStack {
            Text("\(item.name) Ingredients")
                .font(.title2)
                .bold()
                .padding(.top)

            item.FoodImg
                .resizable()
                .frame(width: 375, height: 375)

            List {
                ForEach(item.ingredients.indices, id: \.self) { index in
                    DetailRow(
                        ingredient: item.ingredients[index],
                        onAdd: {
                            item.ingredients[index].amt += 1
                        },
                        onRemove: { item.ingredients[index].amt -= 1 }
                    )
                    .listRowBackground(Color(.gray))
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
            
            
            Text("Calories: \(item.calories)")
                .bold()
                .font(.title)
            Text("THis is just an estimate")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }

}

struct DetailRow: View {

    var ingredient: Ingredients

    var onAdd: () -> Void
    var onRemove: () -> Void

    var body: some View {
        HStack {

            Text(ingredient.thing)
                .font(.title2)
                .fontWeight(.medium)

            Spacer()

            Button {
                onAdd()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            .buttonStyle(.borderless)

            Text("\(ingredient.amt)")

            Button {
                if ingredient.amt > 0 {
                    onRemove()
                } else {

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
    let dummyItem = Item(
        name: "Ice Latte",
        price: 5.00,
        ingredients: [
            Ingredients(thing: "Water"),
            Ingredients(thing: "Coffee powder"),
            Ingredients(thing: "Milk"),
        ],
        FoodImg: Image("Chicken Sandwich"),
        calories: 250
    )

    DetailView(item: dummyItem)
}
