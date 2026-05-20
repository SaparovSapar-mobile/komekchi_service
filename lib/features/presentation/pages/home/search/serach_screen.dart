import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:komekchi_service/core/utils/theme/app_theme.dart';

import '../../../../../core/utils/theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
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

  List<CategoryItem> get _filtered => categories
      .where((c) => c.title.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
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
      if (_searchHistory.length > 10)
        _searchHistory = _searchHistory.sublist(0, 10);
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
  }

  void _onHistoryTap(String text) {
    _searchController.text = text;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: text.length),
    );
    setState(() => _query = text);
  }

  String getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    return '$day.$month.$year';
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
            AppBarWidget(textColor),
            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: TextField(
                controller: _searchController,
                onSubmitted: _onSubmit,
                decoration: InputDecoration(
                  
                  hintText: 'Gözleg',
                  hintStyle: textStyle.copyWith(color: AppColor.descriptionText(context)),
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
            Expanded(
              child: _query.isNotEmpty
                  ? _buildSearchResults()
                  : buildCategoryList(),
            ),
          ],
        ),
      ),
    );
  }

  // History + category list (query bosh wagty)
  Widget buildCategoryList() {
    final TextStyle textStyle = AppTextStyle.medium12;
    final TextStyle textStyle1 = AppTextStyle.semiBold14;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final textColor = AppColor.titleText(context);
    final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        // History
        if (_searchHistory.isNotEmpty) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                'Gözleg taryhy:',
                style: textStyle1.copyWith(color: AppColor.descriptionText(context)),
              ),
              GestureDetector(
                onTap: _clearHistory,
                child: Text(
                  'All clear',
                  style: TextStyle(
                    fontSize: 13,
                    color:isDark ? AppColor.bgBlogLight : AppColor.primary,
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
              leading: Icon(
                Icons.history,
                color: Colors.grey.shade400,
                size: 20,
              ),
              title: Text(item, style: const TextStyle(fontSize: 14)),
              trailing: IconButton(
                icon: Icon(Icons.close, size: 16, color: Colors.grey.shade400),
                onPressed: () => _removeFromHistory(item),
              ),
              onTap: () => _onHistoryTap(item),
            );
          }),
          const Divider(),
        ],

        // All Category
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Ähli kategoriýalar',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              ...List.generate(categories.length, (index) {
                final item = categories[index];
                return Column(
                  children: [
                    ListTile(
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
                        context.push("/categoryId", extra: item.title);
                      },
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  // Filtered results (query bolanda)
  Widget _buildSearchResults() {
    if (_filtered.isEmpty) {
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
      itemCount: _filtered.length,
      itemBuilder: (context, index) {
        final item = _filtered[index];
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image.asset(
                item.image,
                width: 32,
                height: 32,
                errorBuilder: (_, __, ___) =>
                    Icon(Icons.category, color: AppColor.primary, size: 28),
              ),
              title: Text(item.title, style: const TextStyle(fontSize: 15)),
              trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
              onTap: () {
                _addToHistory(item.title);
                // context.push('/allcategory', extra: item.title);
              },
            ),
            Divider(height: 1, color: Colors.grey.shade100),
          ],
        );
      },
    );
  }
}

class CategoryItem {
  final String title;
  final String image;
  const CategoryItem({required this.title, required this.image});
}
