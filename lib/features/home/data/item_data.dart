class Itemdata{
  final String title;
  final String imageCategory;
  final String description;
  final double price;
  final String rating;
  final String time;
  final String imageFordetails;
  final String category;

  Itemdata( {
    required this.title,
    required this.imageCategory,
    required this.description,
    required this.price,
    required this.category,
    required this.imageFordetails,
    required this.rating,
    required this.time,
  });



  factory Itemdata.fromFirestore(Map<String, dynamic> data, String category) {
    return Itemdata(
      title: data['title'] ?? '',
      imageCategory: 'https://drive.google.com/uc?export=view&id=${data['imageCategory']}' ?? '',
      description: data['description'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      category: category,
      imageFordetails: data['imageFordetails'] ?? '',
      rating: data['rating'] ?? '',
      time: data['time'] ?? '',
    );
  }
}



