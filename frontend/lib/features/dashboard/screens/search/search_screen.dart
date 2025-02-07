import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/core/network/connectivity_checker.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/circular_progress_indicator/circlular_indicator.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/dashboard/providers/search_provider.dart';
import 'package:frontend/features/dashboard/screens/filter/filter_screen.dart';
import 'package:frontend/features/dashboard/screens/search/search_result.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchController.addListener(() {
        final searchProvider =
            Provider.of<SearchProvider>(context, listen: false);
        searchProvider.updateSearchText(_searchController.text);
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Clear the search text whenever the screen is revisited

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchController.clear();
      final searchProvider =
          Provider.of<SearchProvider>(context, listen: false);
      searchProvider.clearSearch();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchSubmitted(String value) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.updateSearchText(value);
    context.pushNamed(RoutesConstant.filter,extra: true);
    searchProvider.searchJobs(value); // Trigger search on search action
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ConnectivityChecker(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: Appbar(isActionRequired: false),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: KSizes.md, vertical: KSizes.md),
          child: Consumer<SearchProvider>(
              builder: (context, searchProvider, child) {
            // Check if the search text is empty
            return Column(
              children: [
                // Search Bar
                TextField(
                  focusNode: _focusNode,
                  controller: _searchController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  mouseCursor: SystemMouseCursors.basic,
                  enableSuggestions: true,
                  onSubmitted: _onSearchSubmitted,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _onSearchSubmitted(_searchController.text);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(KSizes.sm),
                        child: Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: KColors.primary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            AntDesign.search1,
                            color: KColors.white,
                          ),
                        ),
                      ),
                    ),
                    hintText: "${l10n.search}",
                    border: const OutlineInputBorder().copyWith(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                          width: 1, color: KColors.lightBackground),
                    ),
                    enabledBorder: const OutlineInputBorder().copyWith(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                          width: 1, color: KColors.lightBackground),
                    ),
                    focusedBorder: const OutlineInputBorder().copyWith(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          const BorderSide(width: 1, color: KColors.primary),
                    ),
                  ),
                ),
                SizedBox(height: KSizes.md),
                // if (_searchController.text.isEmpty) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search History
                    if (searchProvider.searchHistory.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${l10n.recent_search}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontSize: 21.sp,
                                ),
                          ),
                          GestureDetector(
                            onTap: () {
                              searchProvider.clearSearchHistory();
                            },
                            child: Text(
                              "${l10n.clear_all}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: KColors.primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: KSizes.sm),
                      Container(
                          width: double.infinity,
                          height: 400.h,
                          child: ListView.builder(
                              itemCount: searchProvider.searchHistory.length,
                              itemBuilder: (context, index) {
                                final searchHistory =
                                    searchProvider.searchHistory[index];
                                return InkWell(
                                  onTap: () {
                                    _searchController.text = searchHistory;
                                    _onSearchSubmitted(searchHistory);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: KSizes.sm),
                                    child: Row(
                                      spacing: KSizes.sm,
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: KColors.primary,
                                          size: KSizes.iconSm,
                                        ),
                                        Text(
                                          searchHistory,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })),
                      SizedBox(height: KSizes.md),
                    ],

                    //
                  ],
                ),
              ],
              // (searchProvider.isLoading)
              //     ? KIndicator.circularIndicator()
              //     : (searchProvider.searchResults == null)
              //         ? SizedBox()
              //         : (searchProvider.searchResults!.isEmpty)
              //             ? Center(
              //                 child: Text(
              //                   'Search results not found',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .headlineSmall!
              //                       .copyWith(fontWeight: FontWeight.w600),
              //                 ),
              //               )
              //             : const FilterScreen()
              // : const SearchResults()
              // ],

              // ],
            );
          }),
        ),
      ),
    ));
  }
}
