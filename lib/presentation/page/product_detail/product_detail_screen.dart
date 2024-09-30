import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/injection_container.dart';
import '../../../domain/core/unions/failure.dart';
import '../../../domain/core/unions/result_state.dart';
import '../../../domain/model/product_detail.dart';
import '../../bloc/product_detail/product_detail_bloc.dart';
import '../../core/style/size_wrapper_extension.dart';
import '../../core/widget/dot_indicator.dart';
import '../../core/widget/my_error_widget.dart';
import '../../core/widget/my_scaffold.dart';
import 'product_detail_extra.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductDetailExtra extra;
  const ProductDetailScreen({super.key, required this.extra});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ProductDetailBloc>()
        ..add(ProductDetailEvent.started(extra.productId)),
      child: const _ProductDetailScreen(),
    );
  }
}

class _ProductDetailScreen extends StatelessWidget {
  const _ProductDetailScreen();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: BlocSelector<ProductDetailBloc, ProductDetailState,
          ResultState<ProductDetail>>(
        selector: (state) {
          return state.fetchProductDetailState;
        },
        builder: (context, fetchProductDetailState) {
          return fetchProductDetailState.maybeWhen(
            failure: (failure) => MyErrorWidget(
              text: Failure.getErrorMessage(failure),
              onTapRetry: () => context
                  .read<ProductDetailBloc>()
                  .add(const ProductDetailEvent.refreshButtonClicked()),
            ),
            orElse: () {
              return const Center(child: CircularProgressIndicator());
            },
            success: (data) {
              return Column(
                children: [
                  _ProductImagesSection(
                    productImageUrls: data.productImageUrls,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _ProductImagesSection extends StatefulWidget {
  final List<String> productImageUrls;
  const _ProductImagesSection({
    required this.productImageUrls,
  });

  @override
  State<_ProductImagesSection> createState() => _ProductImagesSectionState();
}

class _ProductImagesSectionState extends State<_ProductImagesSection> {
  final _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.productImageUrls.length,
            onPageChanged: (value) {
              setState(() {
                _currentIndex = value;
              });
            },
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.productImageUrls[index],
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
                fit: BoxFit.fitWidth,
              );
            },
          ),
        ),
        DotIndicator(
          length: widget.productImageUrls.length,
          currentIndex: _currentIndex,
          padding: EdgeInsets.only(
            top: 4.h,
            bottom: 8.h,
          ),
        ),
      ],
    );
  }
}
