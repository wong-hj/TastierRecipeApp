
import SwiftUI
import Firebase

struct DetailView: View {
    @EnvironmentObject var dataManager: DetailViewModel
    @ObservedObject var viewModel: DetailViewModel
    
    //var recordId: String
    
    var body: some View {
        
        Text(viewModel.recordId)
        Text(viewModel.name)
        Text(viewModel.step)
        Text(viewModel.difficulty)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(recordId: "ydh6xKli3hFlH3jY8C4D"))
            
    }
}
