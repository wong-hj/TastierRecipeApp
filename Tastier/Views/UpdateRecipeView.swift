
import SwiftUI



struct UpdateRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var dataManager: UpdateRecipeViewModel
    
//    @State var isPickerShowing = false
//    @State var selectedImage: UIImage?
//    @State var name = ""
//    @State var time = 0
//    @State var rating: Double = 0
//    @State var difficultyDoub: Double = 0
//    @State var difficulty = ""
//    @State var ingredients = ""
//    @State var steps = ""
//    @State var category = Categories.dessert
//    @State var showAlert = false
//    @State var activeAlert = ""
    
    @State var isPickerShowing = false
    //@State var selectedImage: UIImage?
//    @Binding var name: String
//    @Binding var time: Int
    //@Binding var recipe: Recipe
//    @State var rating: Double = 0
//    @State var difficultyDoub: Double = 0
//    @State var difficulty = ""
//    @State var ingredients = ""
//    @State var steps = ""
//    @State var category = Categories.dessert
//    @State var showAlert = false
//    @State var activeAlert = ""
    
    var body: some View {
        
        Text(dataManager.recipe.name)
//        ScrollView {
//            VStack {
//                Group{
//                    Text("Update your recipe")
//                        .font(.largeTitle)
//                        .foregroundColor(.orange)
//                    Text("Share your ideas to others!")
//                        .foregroundColor(.gray)
//                        .padding(.bottom, 10)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//
//                Group{
//
//                    Text("Recipe Title")
//                        .foregroundColor(.gray)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//
//                    TextField("", text: $name)
//                        .padding(8)
//                        .background()
//                        .foregroundColor(.black)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(.orange, lineWidth: 2)
//                        )
//
//                    VStack {
//
//                        Group {
//                            Text("Image")
//                                .foregroundColor(.gray)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//
//                            if selectedImage != nil {
//                                Image(uiImage: selectedImage!)
//                                    .resizable()
//                                    .frame(width: 200, height: 200)
//                            }
//
//                            VStack {
//                                Button {
//
//                                    // Show image picker
//                                    isPickerShowing = true
//
//                                } label: {
//                                    Text("Select an Image")
//                                    Image(systemName: "square.and.arrow.up")
//                                }
//                            }
//                            .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
//                                // Image Picker
//
//                                ImagePickerView(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
//                            }
//
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.bottom, 10)
//
//
//                        Text("Category")
//                            .foregroundColor(.gray)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//
//                        Picker("Category", selection: $category) {
//                            ForEach(Categories.allCases, id: \.self) { category in
//                                Text(category.rawValue.capitalized).tag(category)
//                            }
//                        }
//                        .pickerStyle(SegmentedPickerStyle())
//                        .padding(.bottom, 10)
//
//                    }
//
//                    HStack {
//                        Text("Time (minutes)")
//                            .foregroundColor(.gray)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//
//                        Picker("Number", selection: $time) {
//                            ForEach(0...300, id: \.self) { number in
//                                Text("\(number) minutes").tag(number)
//                            }
//                        }
//                        .accentColor(.orange)
//
//                    }
//                    .padding(.bottom, 10)
//
//
//                    Text("Rating")
//                        .foregroundColor(.gray)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//
//                    Slider(value: $rating, in: 0...5, step: 1) {
//                        Text("Rating")
//                    } minimumValueLabel: {
//                        Text("0").font(.title3).fontWeight(.thin)
//
//                    } maximumValueLabel: {
//                        Text("5").font(.title3).fontWeight(.thin)
//                    }
//                    .tint(.orange)
//                    .padding()
//
//                    Text("Difficulty - \(difficultyString(for: difficultyDoub))")
//                        .foregroundColor(.gray)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//
//                    Slider(value: $difficultyDoub, in: 1...3, step: 1) {
//                        Text("Difficulty")
//                    } minimumValueLabel: {
//                        Text("Easy").font(.system(size: 20)).fontWeight(.thin)
//
//                    } maximumValueLabel: {
//                        Text("Hard").font(.system(size: 20)).fontWeight(.thin)
//                    }
//                    .tint(.orange)
//                    .padding()
//
//
//                    VStack {
//                        Text("Ingredients")
//                            .foregroundColor(.gray)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//
//                        ScrollView {
//                            TextEditor(text: $ingredients)
//                                .frame(height: 100)
//                                .padding(8)
//                                .background()
//                                .foregroundColor(.black)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(.orange, lineWidth: 2)
//                                )
//
//                        }
//                        .frame(height: 120)
//
//                        Text("Steps")
//                            .foregroundColor(.gray)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//
//                        ScrollView {
//                            TextEditor(text: $steps)
//                                .frame(height: 100)
//                                .padding(8)
//                                .background()
//                                .foregroundColor(.black)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(.orange, lineWidth: 2)
//                                )
//                        }
//
//                    }
//
//                }
//
//
//                Spacer()
//
//                Button(action: {
//                    switch difficultyDoub {
//                    case 1:
//                        difficulty = "Easy"
//                    case 2:
//                        difficulty = "Normal"
//                    case 3:
//                        difficulty = "Hard"
//                    default:
//                        difficulty = "Easy"
//                    }
//
//                    //add in firestore
//                    if (name.isEmpty || ingredients.isEmpty || steps.isEmpty || selectedImage == nil) {
//
//                        activeAlert = "empty"
//                    } else {
//
//                        activeAlert = "submit"
//
//    //                    dataManager.addRecipes(name: name, time: time, rating: rating, difficulty: difficulty, ingredient: ingredients, step: steps, category: category.rawValue.capitalized, username: "", UID: "", selectedImage: selectedImage)
//
//                    }
//
//                showAlert = true
//                    //currentUser.user.username
//                    //currentUser.user.uid
//                }, label: {
//
//                    HStack{
//                        Text("Submit")
//                        Image(systemName: "arrow.right")
//                    }
//                    .padding(10)
//                    .background(.yellow)
//                    .foregroundColor(.black)
//                    .cornerRadius(20)
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//                    .padding(.top, 10)
//
//                })
//                .alert(isPresented: $showAlert, content: {
//                    // Present an alert if registration is successful
//                    switch activeAlert {
//                        case "empty":
//                        return Alert(title: Text("Error"), message: Text("Please fill in all fields."), dismissButton: .default(Text("OK")))
//
//                        case "submit":
//                        return Alert(title: Text("Success"), message: Text("Successfully added a Recipe!"), dismissButton: .default(Text("OK")) {
//                            dismiss()
//                        })
//
//
//                    default:
//
//                        return Alert(title: Text("Error"), message: Text("Something went wrong."), dismissButton: .default(Text("OK")))
//                    }
//                })
//
//            }
//            .padding()
//            //.navigationTitle("")
//        }
        
    }
        
//    func difficultyString(for difficultyDoub: Double) -> String {
//        switch difficultyDoub {
//        case 1:
//            return "Easy"
//        case 2:
//            return "Normal"
//        case 3:
//            return "Hard"
//        default:
//            return "Easy"
//        }
//    }
}

struct UpdateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateRecipeView(dataManager: UpdateRecipeViewModel(documentid: "ajeEe5sZEiiDXfpTeJq7"))
    }
}
