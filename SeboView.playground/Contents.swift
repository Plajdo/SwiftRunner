import SwiftUI
import PlaygroundSupport

struct ContentView: View {
	let galleryList: [String]
	
	var body: some View {
		VStack {
			HeadingImage()
			GalleryList(galleryList: self.galleryList).offset(x: 0, y: -100).padding(.bottom, -100)
			
		}
		
	}
	
}

struct GalleryList: View {
	let galleryList: [String]
	
	var body: some View {
		VStack {
			ScrollView(.vertical, showsIndicators: false) {
				ForEach(galleryList, id: \.self) { title in
					GalleryTab(title: title)
					
				}
				
			}
			
		}
		
	}
	
}

struct GalleryTab: View {
	let title: String
	
	var body: some View {
		ZStack(alignment: .topLeading) {
			Rectangle().foregroundColor(Color.white)
			VStack {
				Image(uiImage: UIImage(named: "g-thumb.jpg")!)
					.resizable()
					.aspectRatio(3/2, contentMode: .fit)
				
				Text(title)
				Spacer()
				
			}
			
		}.frame(width: 240).cornerRadius(5).padding().shadow(radius: 5)
		
	}
	
}

struct HorizontalLineDivider: View {
	var body: some View {
		Rectangle().frame(height: 2).foregroundColor(Color.white).shadow(radius: 5)
		
	}
	
}

struct HeadingImage: View {
	var body: some View {
		ZStack {
			Image(uiImage: UIImage(named: "top-bg.jpg")!)
				.resizable()
				.aspectRatio(3/2, contentMode: .fit)
				.blur(radius: 3)
				.padding(-10)
			
			TextOverlay()
		}
		
	}
	
}

struct TextOverlay: View {
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text("Fotogaléria")
					.font(.subheadline)
					.bold()
					.foregroundColor(Color.white)
					.multilineTextAlignment(.leading)
				
				Spacer()
				
			}
			Spacer().frame(maxHeight: 10)
			VStack(alignment: .leading) {
				Text("Kategórie")
					.font(.subheadline)
					.foregroundColor(Color.white)
					.multilineTextAlignment(.leading)
				HorizontalLineDivider()
				
			}
			
		}.padding()
		
	}
	
}

PlaygroundPage.current.setLiveView(ContentView(galleryList: ["Selfies", "Nature", "Snapchat", "Nudes"]))
