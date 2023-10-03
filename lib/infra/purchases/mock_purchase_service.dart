import 'package:cinnamon_riverpod_2/infra/purchases/entity/product.dart';
import 'package:cinnamon_riverpod_2/infra/purchases/entity/purchase_entity.dart';
import 'package:cinnamon_riverpod_2/infra/purchases/purchases_service.dart';

class MockPurchaseService implements PurchasesService {
  @override
  Future<List<Product>> getProducts() async {
    return [
      const Product(id: "1", name: "test1", description: "test1", price: "1usd", implRef: null),
      const Product(id: "2", name: "test2", description: "test2", price: "2usd", implRef: null),
    ];
  }

  @override
  Future<PurchaseEntity> init() async {
    return const PurchaseEntity(premiumActive: false, isTrial: false);
  }

  @override
  Future<PurchaseEntity> purchaseProduct(Product product) async {
    return const PurchaseEntity(premiumActive: true, isTrial: false);
  }

  @override
  Future<PurchaseEntity> restorePurchases() {
    return Future.value(const PurchaseEntity(premiumActive: true, isTrial: false));
  }
}
