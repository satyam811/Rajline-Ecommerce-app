class Product {
  final String name;
  final String description;
  final int price;
  final int orignalPrice;
  final String discount;
  final String image;

  Product(
    this.name,
    this.description,
    this.price,
    this.orignalPrice,
    this.discount,
    this.image,
  );

  static List<Product> getProducts() {
    List<Product> items = <Product>[];
    items.add(Product("Rajlines Ceiling Fan", "Home Appliances", 419, 2995,
        "(86% OFF)", 'assets/dumy/cilingFan.png'));
    items.add(Product("Rajlines Ceiling Fan", "Home Appliances", 419, 2995,
        "(86% OFF)", 'assets/dumy/cilingFan.png'));
    items.add(Product("Rajlines Ceiling Fan", "Home Appliances", 419, 2995,
        "(86% OFF)", 'assets/dumy/cilingFan.png'));
    items.add(Product("Rajlines Ceiling Fan", "Home Appliances", 419, 2995,
        "(86% OFF)", 'assets/dumy/cilingFan.png'));
    items.add(Product("Rajlines Ceiling Fan", "Home Appliances", 419, 2995,
        "(86% OFF)", 'assets/dumy/cilingFan.png'));
    items.add(Product("Rajlines Ceiling Fan", "Home Appliances", 419, 2995,
        "(86% OFF)", 'assets/dumy/cilingFan.png'));
    items.add(Product("Rajlines Ceiling Fan", "Home Appliances", 419, 2995,
        "(86% OFF)", 'assets/dumy/cilingFan.png'));
    items.add(Product("Rajlines Ceiling Fan", "Home Appliances", 419, 2995,
        "(86% OFF)", 'assets/dumy/cilingFan.png'));
    items.add(Product("Rajlines Ceiling Fan", "Home Appliances", 419, 2995,
        "(86% OFF)", 'assets/dumy/cilingFan.png'));
    items.add(Product("Rajlines Ceiling Fan", "Home Appliances", 419, 2995,
        "(86% OFF)", 'assets/dumy/cilingFan.png'));
    return items;
  }
}
