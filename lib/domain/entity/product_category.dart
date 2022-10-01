enum ProductCategory {
  smartPhone(id: 1),
  tablet(id: 2),
  laptop(id: 3),
  mobileAccessory(id: 4),
  smartTv(id: 5);

  final int id;

  const ProductCategory({required this.id});
}
