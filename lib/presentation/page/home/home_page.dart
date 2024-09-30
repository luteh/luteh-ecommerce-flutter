import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extention/context_extention.dart';
import '../../../di/injection_container.dart';
import '../../../domain/core/unions/failure.dart';
import '../../bloc/home/home_bloc.dart';
import '../../core/style/size_wrapper_extension.dart';
import '../../core/widget/my_error_widget.dart';
import '../../core/widget/my_scaffold.dart';
import '../../core/widget/rounded_text_field.dart';
import '../../route/route_extension.dart';
import '../../route/route_name.dart';
import '../product_detail/product_detail_extra.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<HomeBloc>()..add(const HomeEvent.started()),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      if (context.read<HomeBloc>().state.fetchMoreProductsState.isFailure) {
        return;
      }
      context.read<HomeBloc>().add(const HomeEvent.fetchMoreProduct());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(
        title: Text(context.localization.home),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 16.h,
            ),
            child: RoundedTextField(
              onChanged: (value) => context
                  .read<HomeBloc>()
                  .add(HomeEvent.searchFieldChanged(value)),
              hintText: 'Search Product',
              prefixIcon: const Icon(Icons.search_rounded),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) =>
                  previous.fetchProductsState != current.fetchProductsState ||
                  previous.fetchMoreProductsState !=
                      current.fetchMoreProductsState,
              builder: (context, state) {
                return state.fetchProductsState.maybeWhen(
                  orElse: () =>
                      const Center(child: CircularProgressIndicator()),
                  failure: (failure) => MyErrorWidget(
                    text: Failure.getErrorMessage(failure),
                    onTapRetry: () => context
                        .read<HomeBloc>()
                        .add(const HomeEvent.retryFetchProductsButtonClicked()),
                  ),
                  success: (data) {
                    if (data.isEmpty) {
                      return const Center(child: Text('No data'));
                    }
                    return RefreshIndicator(
                      onRefresh: () async => context.read<HomeBloc>().add(
                          const HomeEvent.refreshProductsIndicatorDragged()),
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        controller: _scrollController,
                        itemCount:
                            state.hasReachedEnd ? data.length : data.length + 1,
                        itemBuilder: (context, index) {
                          if (index == data.length) {
                            return state.fetchMoreProductsState.maybeWhen(
                              orElse: () => const Center(
                                  child: CircularProgressIndicator()),
                              failure: (failure) => MyErrorWidget(
                                text: 'Something went wrong',
                                onTapRetry: () => context.read<HomeBloc>().add(
                                    const HomeEvent
                                        .retryFetchMoreProductsButtonClicked()),
                              ),
                            );
                          }
                          return ListTile(
                            title: Text(data[index].name),
                            subtitle: Text('\$${data[index].price}'),
                            leading: CachedNetworkImage(
                              imageUrl: data[index].thumbnailImageUrl,
                              width: 50.w,
                              height: 50.w,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  value: progress.progress,
                                ),
                              ),
                            ),
                            onTap: () {
                              context.push(
                                RouteName.productDetail,
                                extra: ProductDetailExtra(
                                  productId: data[index].id,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
