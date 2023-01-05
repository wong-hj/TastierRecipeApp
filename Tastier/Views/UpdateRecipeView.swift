
import SwiftUI
import SDWebImageSwiftUI

enum Difficulties: String, CaseIterable {
    case Easy, Normal, Hard
}

struct UpdateRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var dataManager: UpdateRecipeViewModel
  
    
    @State private var isPickerShowing = false
    @State private var selectedImage: UIImage?
    @State private var selectedDifficulty = "Hard"
    @State private var showAlert = false
    @State private var activeAlert = ""
    @State private var isNewImage = false
    
    var body: some View {
        
        ScrollView {
            VStack {
                Group{
                    Text("Update your recipe")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    Text("Share your ideas to others!")
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Group{

                    Text("Recipe Title")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    TextField("", text: $dataManager.recipe.name)
                        .padding(8)
                        .background()
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.orange, lineWidth: 2)
                        )

                    VStack {

                        Group {
                            Text("Image")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            
                            if selectedImage != nil {
                                
                                //isNewImage = true
                                
                                Image(uiImage: selectedImage!)
                                    .resizable()
                                    .frame(width: 350, height: 230)
         
                            } else {
                                
                                WebImage(url: URL(string: dataManager.recipe.imageURL))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 350, height: 230)
                            }

                            VStack {
                                Button {

                                    // Show image picker
                                    isPickerShowing = true

                                } label: {
                                    Text("Select an Image")
                                    Image(systemName: "square.and.arrow.up")
                                }
                            }
                            .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                                // Image Picker

                                ImagePickerView(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
                            }

                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)


                        Text("Category")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        let categoryBinding: Binding<String> = Binding(
                            get: { self.dataManager.recipe.category.lowercased() },
                            set: { self.dataManager.recipe.category = $0 }
                        
                        )
                        Picker("Category", selection: categoryBinding) {
                            ForEach(Categories.allCases, id: \.self) { category in
                                Text(category.rawValue.capitalized).tag(category.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom, 10)

                    }

                    HStack {
                        Text("Time (minutes)")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Picker("Number", selection: $dataManager.recipe.time) {
                            ForEach(0...300, id: \.self) { number in
                                Text("\(number) minutes").tag(number)
                            }
                        }
                        .accentColor(.orange)

                    }
                    .padding(.bottom, 10)


                    Text("Rating")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Slider(value: $dataManager.recipe.rating, in: 0...5, step: 1) {
                        Text("Rating")
                    } minimumValueLabel: {
                        Text("0").font(.title3).fontWeight(.thin)

                    } maximumValueLabel: {
                        Text("5").font(.title3).fontWeight(.thin)
                    }
                    .tint(.orange)
                    .padding()
                    
                    HStack {
                        Text("Difficulty - \(dataManager.recipe.difficulty)")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        let difficultyBinding: Binding<String> = Binding(
                           get: { self.dataManager.recipe.difficulty },
                           set: { self.dataManager.recipe.difficulty = $0 }
                       )
                        
                        Picker("Difficulty", selection: difficultyBinding) {
                            ForEach(Difficulties.allCases, id: \.self) { diff in
                                Text(diff.rawValue.capitalized).tag(diff.rawValue)
                            }
                        }
                    }
                    .padding(.bottom, 10)


                    VStack {
                        Text("Ingredients")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ScrollView {
                            TextEditor(text: $dataManager.recipe.ingredient)
                                .frame(height: 100)
                                .padding(8)
                                .background()
                                .foregroundColor(.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.orange, lineWidth: 2)
                                )

                        }
                        .frame(height: 120)

                        Text("Steps")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ScrollView {
                            TextEditor(text: $dataManager.recipe.step)
                                .frame(height: 100)
                                .padding(8)
                                .background()
                                .foregroundColor(.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.orange, lineWidth: 2)
                                )
                        }

                    }

                }


                Spacer()

                Button(action: {
                    
                    //add in firestore
                    if (dataManager.recipe.name.isEmpty || dataManager.recipe.ingredient.isEmpty || dataManager.recipe.step.isEmpty) {

                        activeAlert = "empty"
                        
                    } else {

                        activeAlert = "submit"

                        dataManager.updateRecipe(name: dataManager.recipe.name, time: dataManager.recipe.time, rating: dataManager.recipe.rating, difficulty: dataManager.recipe.difficulty, ingredient: dataManager.recipe.ingredient, step: dataManager.recipe.step, category: dataManager.recipe.category.capitalized, selectedImage: selectedImage, docid: dataManager.recipe.docid)

                    }

                showAlert = true
                }, label: {

                    HStack{
                        Text("Update")
                        Image(systemName: "arrow.right")
                    }
                    .padding(10)
                    .background(.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 10)

                })
                .alert(isPresented: $showAlert, content: {
                    // Present an alert if registration is successful
                    switch activeAlert {
                        case "empty":
                        return Alert(title: Text("Error"), message: Text("Please fill in all fields."), dismissButton: .default(Text("OK")))

                        case "submit":
                        return Alert(title: Text("Success"), message: Text("Successfully edited a Recipe!"), dismissButton: .default(Text("OK")) {
                            dismiss()
                        })


                    default:

                        return Alert(title: Text("Error"), message: Text("Something went wrong."), dismissButton: .default(Text("OK")))
                    }
                })

            }
            .padding()
            //.navigationTitle("")
        }
        
    }
    
}

struct UpdateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateRecipeView(dataManager: UpdateRecipeViewModel(documentid: "ajeEe5sZEiiDXfpTeJq7"))
        
    }
}
