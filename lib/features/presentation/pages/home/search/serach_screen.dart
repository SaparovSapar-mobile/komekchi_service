import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/app_constants.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';
import 'package:komekchi_service/features/presentation/bloc/search/search_cubit.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<String> _searchHistory = [];
  String _query = '';

  final List<CategoryItem> categories = [
    CategoryItem(
      title: 'Elektrikçi',
      image: 'assets/images/category/image1.png',
    ),
    CategoryItem(
      title: 'Arassaçylyk',
      image: 'assets/images/category/image2.png',
    ),
    CategoryItem(
      title: 'Ýük daşaýjy',
      image: 'assets/images/category/image3.png',
    ),
    CategoryItem(
      title: 'Agaç ussasy',
      image: 'assets/images/category/image4.png',
    ),
    CategoryItem(
      title: 'Reňkleýji',
      image: 'assets/images/category/image5.png',
    ),
    CategoryItem(title: 'Salon', image: 'assets/images/category/image6.png'),
    CategoryItem(
      title: 'Toý bezegleri',
      image: 'assets/images/category/image7.png',
    ),
    CategoryItem(
      title: 'Tehnika bejerijiler',
      image: 'assets/images/category/image8.png',
    ),
    CategoryItem(
      title: 'Öý abatlaýyş',
      image: 'assets/images/category/image9.png',
    ),
    CategoryItem(
      title: 'Okuw gollanmalar',
      image: 'assets/images/category/image12.png',
    ),
    CategoryItem(
      title: 'Maşyn yuwmak',
      image: 'assets/images/category/image11.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text);
      context.read<SearchCubit>().searchDebounced(_searchController.text);
    });
    _searchFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory = prefs.getStringList('search_history') ?? [];
    });
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('search_history', _searchHistory);
  }

  void _addToHistory(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _searchHistory.remove(text);
      _searchHistory.insert(0, text);
      if (_searchHistory.length > 10) {
        _searchHistory = _searchHistory.sublist(0, 10);
      }
    });
    _saveHistory();
  }

  void _removeFromHistory(String text) {
    setState(() => _searchHistory.remove(text));
    _saveHistory();
  }

  void _clearHistory() {
    setState(() => _searchHistory.clear());
    _saveHistory();
  }

  void _onSubmit(String text) {
    if (text.trim().isEmpty) return;
    _addToHistory(text.trim());
    context.read<SearchCubit>().search(text);
  }

  void _onHistoryTap(String text) {
    _searchController.text = text;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: text.length),
    );
    setState(() => _query = text);
    context.read<SearchCubit>().search(text);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final textColor = AppColor.titleText(context);
    final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;
    final TextStyle textStyle = AppTextStyle.regular14;

    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColor.primary,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Header
            AppBarWidget(textColor, isDark),
            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                onSubmitted: _onSubmit,
                decoration: InputDecoration(
                  hintText: 'Gözleg',
                  hintStyle: textStyle.copyWith(
                    color: AppColor.descriptionText(context),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.cancel, color: Colors.grey.shade400),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: cardBg,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: borderColor),
                  ),
                ),
              ),
            ),

            // Content
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_query.isNotEmpty) return _buildSearchResults();
    if (_searchFocusNode.hasFocus) return _buildHistoryView();
    return _buildCategoryBrowse();
  }

  // Recent searches (klaviatura açyk wagty, sorag ýazylmadyk bolsa)
  Widget _buildHistoryView() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final TextStyle textStyle1 = AppTextStyle.semiBold14;

    if (_searchHistory.isEmpty) {
      return Center(
        child: Text(
          'Gözleg taryhy ýok',
          style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Gözleg taryhy:',
              style: textStyle1.copyWith(
                color: AppColor.descriptionText(context),
              ),
            ),
            GestureDetector(
              onTap: _clearHistory,
              child: Text(
                'All clear',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? AppColor.bgBlogLight : AppColor.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...List.generate(_searchHistory.length, (index) {
          final item = _searchHistory[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.history, color: Colors.grey.shade400, size: 20),
            title: Text(item, style: const TextStyle(fontSize: 14)),
            trailing: IconButton(
              icon: Icon(Icons.close, size: 16, color: Colors.grey.shade400),
              onPressed: () => _removeFromHistory(item),
            ),
            onTap: () => _onHistoryTap(item),
          );
        }),
      ],
    );
  }

  // Category browse (klaviatura ýapyk, sorag ýok wagty)
  Widget _buildCategoryBrowse() {
    final TextStyle textStyle = AppTextStyle.medium12;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(
              context,
            ).padding.bottom.clamp(0.0, double.infinity),
          ),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Ähli kategoriýalar',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              ...List.generate(categories.length, (index) {
                final item = categories[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.asset(
                      item.image,
                      width: 28,
                      height: 28,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.category,
                        color: AppColor.primary,
                        size: 28,
                      ),
                    ),
                  ),
                  title: Text(
                    item.title,
                    style: textStyle.copyWith(
                      color: AppColor.titleText(context),
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade400,
                  ),
                  onTap: () {
                    // This screen's category tiles are local placeholders
                    // (not backed by a real category uuid from the API),
                    // so route to the real, API-driven category list.
                    context.push("/allCategory");
                  },
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  // API search results (sorag ýazylan wagty)
  Widget _buildSearchResults() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SearchError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is SearchSuccess) {
          final items = state.items;

          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search_off, size: 48, color: Colors.grey.shade300),
                  const SizedBox(height: 12),
                  Text(
                    'Netije tapylmady',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        ApiConstants.imageUrl(item.img),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.category,
                          color: AppColor.primary,
                          size: 28,
                        ),
                      ),
                    ),
                    title: Text(
                      item.nameTm,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColor.titleText(context),
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade400,
                    ),
                    onTap: () {
                      _addToHistory(_query);
                      context.push("/detail", extra: {"uuid": item.uuid});
                    },
                  ),
                  Divider(height: 1, color: Colors.grey.shade100),
                ],
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}

class CategoryItem {
  final String title;
  final String image;
  const CategoryItem({required this.title, required this.image});
}
