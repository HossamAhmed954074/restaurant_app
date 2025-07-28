import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/enhanced_header_widget.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/enhanced_category_widget.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/enhanced_menu_items.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/search_widget.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/promotional_banner_widget.dart';
import 'package:resturant_app/features/home/presentation/view_model/cubit/home_cubit.dart';

class EnhancedHomeScreen extends StatelessWidget {
  const EnhancedHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getShuffledItems(),
      child: const EnhancedHomeBody(),
    );
  }
}

class EnhancedHomeBody extends StatefulWidget {
  const EnhancedHomeBody({super.key});

  @override
  State<EnhancedHomeBody> createState() => _EnhancedHomeBodyState();
}

class _EnhancedHomeBodyState extends State<EnhancedHomeBody>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _searchController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool _isListView = false;
  bool _isSearchVisible = false;
  String _searchQuery = '';
  final TextEditingController _searchTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _setupScrollListener();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _searchController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Start animations
    _animationController.forward();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      // Hide search when scrolling down
      if (_scrollController.offset > 100 && _isSearchVisible) {
        _toggleSearch();
      }
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
    });

    if (_isSearchVisible) {
      _searchController.forward();
    } else {
      _searchController.reverse();
      _searchTextController.clear();
      _searchQuery = '';
    }
  }

  void _toggleViewMode() {
    setState(() {
      _isListView = !_isListView;
    });
    HapticFeedback.selectionClick();
  }

  void _onCategorySelected(String categoryId) {
    HapticFeedback.selectionClick();
    BlocProvider.of<HomeCubit>(context).getAllMenuItems(id: categoryId);
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    // Implement search logic here
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _searchTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // Enhanced App Bar
                  _buildEnhancedAppBar(),

                  // Search Widget (Collapsible)
                  if (_isSearchVisible) _buildSearchSliver(),

                  // Promotional Banner
                  _buildPromotionalBanner(),

                  // Category Section
                  _buildCategorySection(),

                  // Menu Items Section
                  _buildMenuItemsSection(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEnhancedAppBar() {
    return SliverAppBar(
      expandedHeight: 180.0,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFFFF6B35),
      flexibleSpace: FlexibleSpaceBar(
        background: EnhancedHeaderWidget(
          onMenuTap: () {
            // Handle menu tap
          },
        ),
      ),
      actions: [
        IconButton(
          onPressed: _toggleSearch,
          icon: const Icon(Icons.search, color: Colors.white),
        ),
        IconButton(
          onPressed: _toggleViewMode,
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              _isListView ? Icons.grid_view : Icons.view_list,
              key: ValueKey(_isListView),
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSearchSliver() {
    return SliverToBoxAdapter(
      child: AnimatedBuilder(
        animation: _searchController,
        builder: (context, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(_searchController),
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: SearchWidget(
                controller: _searchTextController,
                onChanged: _onSearchChanged,
                onClear: () {
                  _searchTextController.clear();
                  _onSearchChanged('');
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPromotionalBanner() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: PromotionalBannerWidget(),
      ),
    );
  }

  Widget _buildCategorySection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: EnhancedCategoryWidget(onCategorySelected: _onCategorySelected),
      ),
    );
  }

  Widget _buildMenuItemsSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menu Items',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // View all items
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Color(0xFFFF6B35),
                  ),
                  label: Text(
                    'View All',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFFF6B35),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            EnhancedMenuItems(
              isListView: _isListView,
              searchQuery: _searchQuery,
            ),
          ],
        ),
      ),
    );
  }
}
