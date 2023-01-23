class MachineProduct {
  final int? id;
  final String? description;
  final String? name;
  final double? price;
  final String? imagePath;

  MachineProduct({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imagePath,
  });
   factory MachineProduct.fromJson(Map<String, dynamic> json) => MachineProduct(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    imagePath: json["imagePath"],
);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'name': name,
      'price': price,
      'imagePath': imagePath,
    };
  }
}

List<MachineProduct> products = [
  MachineProduct(
    id: 1,
    name: 'سنيكرز',
    description: 'شوكولاتة فاخرة بمعايير عالمية',
    price: 20,
    imagePath: 'assets/images/snickers.png',
  ),
  MachineProduct(
    id: 2,
    name: 'سنيكرز',
    description: 'شوكولاتة فاخرة بمعايير عالمية',
    price: 20,
    imagePath: 'assets/images/snickers.png',
  ),
  MachineProduct(
    id: 3,
    name: 'سنيكرز',
    description: 'شوكولاتة فاخرة بمعايير عالمية',
    price: 20,
    imagePath: 'assets/images/snickers.png',
  ),
  MachineProduct(
    id: 4,
    name: 'سنيكرز',
    description: 'شوكولاتة فاخرة بمعايير عالمية',
    price: 20,
    imagePath: 'assets/images/snickers.png',
  ),
  MachineProduct(
    id: 5,
    name: 'سنيكرز',
    description: 'شوكولاتة فاخرة بمعايير عالمية',
    price: 20,
    imagePath: 'assets/images/snickers.png',
  ),
  MachineProduct(
    id: 6,
    name: 'سنيكرز',
    description: 'شوكولاتة فاخرة بمعايير عالمية',
    price: 20,
    imagePath: 'assets/images/snickers.png',
  ),
  MachineProduct(
    id: 7,
    name: 'سنيكرز',
    description: 'شوكولاتة فاخرة بمعايير عالمية',
    price: 20,
    imagePath: 'assets/images/snickers.png',
  ),
  MachineProduct(
    id: 8,
    name: 'سنيكرز',
    description: 'شوكولاتة فاخرة بمعايير عالمية',
    price: 20,
    imagePath: 'assets/images/snickers.png',
  ),
];
