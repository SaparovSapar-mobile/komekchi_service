import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';
import 'package:komekchi_service/features/presentation/bloc/category/get_category_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/search/search_cubit.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import 'parts/search_category_browse.dart';
import 'parts/search_history_view.dart';
import 'parts/search_results_view.dart';

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

  @override
  void initState() {
    super.initState();
    _loadHistory();
    context.read<GetCategoryCubit>().fetchCategory();
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
    final cardBg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final bg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final textColor = AppColor.titleText(context);
    final borderColor = isDark ? AppColor.bgBlogDark : AppColor.borderColor;
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
                  enabledBorder: OutlineInputBorder(
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
    if (_query.isNotEmpty) {
      return SearchResultsView(query: _query, onAddToHistory: _addToHistory);
    }
    if (_searchFocusNode.hasFocus) {
      return SearchHistoryView(
        history: _searchHistory,
        onTap: _onHistoryTap,
        onRemove: _removeFromHistory,
        onClear: _clearHistory,
      );
    }
    return const SearchCategoryBrowse();
  }
}
