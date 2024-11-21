import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:souqalgomlah_app/features/product/model/models/product_model.dart';
import '/core/utilities/extensions.dart';
import '/features/product/model/repo/product_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productRepo) : super(ProductInitial());

  final ProductRepo _productRepo;
  ProductModel? productModel;
  String errorText = '';

  Future<void> getProduct(String productId, BuildContext context) async {
    emit(GetProductDetailsLoading());
    final response = await _productRepo.getProduct(productId);
    response.fold(
      (l) {
        log(l.errMsg);
        context.showErrorSnackBar(l.errMsg);
        errorText = l.errMsg;
        emit(GetProductDetailsError());
      },
      (r) {
        productModel = r;
        emit(GetProductDetailsSuccess());
      },
    );
  }

  void emitState() {
    emit(ProductInitial());
    emit(ProductUpdate());
  }
}
