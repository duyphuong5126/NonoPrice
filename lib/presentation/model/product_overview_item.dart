import '../../domain/entity/product.dart';

class ProductOverView {
  final String productId;
  final String thumbnailUrl;
  final String productName;

  final Product product;

  const ProductOverView({
    required this.productId,
    required this.productName,
    required this.thumbnailUrl,
    required this.product,
  });
}
