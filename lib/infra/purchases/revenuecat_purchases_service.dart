import 'dart:io';

import 'package:cinnamon_riverpod_2/infra/purchases/entity/product.dart';
import 'package:cinnamon_riverpod_2/infra/purchases/entity/purchase_entity.dart';
import 'package:cinnamon_riverpod_2/infra/purchases/purchases_service.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenuecatPurchasesService implements PurchasesService {
  @override
  Future<PurchaseEntity> init() async {
    await Purchases.setLogLevel(LogLevel.verbose);

    late PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration = PurchasesConfiguration("");
    } else if (Platform.isIOS) {
      configuration = PurchasesConfiguration("");
    } else {
      throw Exception("Platform not supported");
    }
    await Purchases.configure(configuration);
    return _getPurchaseStatus();
  }

  @override
  Future<List<Product>> getProducts() {
    return Purchases.getOfferings().then((value) =>
        value.current?.availablePackages
            .map((e) => RevenuecatProduct(
                  implRef: e,
                  id: e.identifier,
                  name: e.storeProduct.title,
                  description: e.storeProduct.description,
                  price: e.storeProduct.priceString,
                ))
            .toList() ??
        []);
  }

  @override
  Future<PurchaseEntity> purchaseProduct(Product product) {
    return Purchases.purchasePackage((product as RevenuecatProduct).implRef).then((value) async {
      await Purchases.syncPurchases();
      return _getPurchaseStatus();
    });
  }

  @override
  Future<PurchaseEntity> restorePurchases() async {
    await Purchases.restorePurchases();
    return _getPurchaseStatus();
  }

  Future<PurchaseEntity> _getPurchaseStatus() async {
    final customer = await _getCustomerInfo();
    return PurchaseEntity(
      premiumActive: customer.entitlements.all["pro"]?.isActive ?? false,
      isTrial: customer.entitlements.all["pro"]?.periodType == PeriodType.trial,
    );
  }

  Future<CustomerInfo> _getCustomerInfo() async {
    await Purchases.invalidateCustomerInfoCache();
    return Purchases.getCustomerInfo();
  }
}
