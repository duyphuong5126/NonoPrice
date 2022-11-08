class ProductPrice {
  final String codeName;
  final String options;
  final String categoryCode;
  final double price;
  final String currency;
  final String countryCode;
  final String sourceGroupName;
  final String sourceURL;
  final String updatedAt;

  const ProductPrice({
    required this.codeName,
    required this.options,
    required this.categoryCode,
    required this.price,
    required this.currency,
    required this.countryCode,
    required this.sourceGroupName,
    required this.sourceURL,
    required this.updatedAt,
  });
}
