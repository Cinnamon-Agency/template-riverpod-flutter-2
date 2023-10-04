import 'package:cinnamon_riverpod_2/infra/purchases/entity/product.dart';
import 'package:cinnamon_riverpod_2/infra/purchases/entity/purchase_entity.dart';
import 'package:cinnamon_riverpod_2/infra/purchases/mock_purchase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final purchaseServiceProvider = Provider<PurchasesService>((ref) {
  return MockPurchaseService();
});

abstract interface class PurchasesService {
  Future<PurchaseEntity> init();
  Future<List<Product>> getProducts();
  Future<PurchaseEntity> purchaseProduct(Product product);
  Future<PurchaseEntity> restorePurchases();
}
