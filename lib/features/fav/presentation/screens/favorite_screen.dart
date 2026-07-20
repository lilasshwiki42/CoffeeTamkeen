import 'package:flutter/material.dart';
import 'package:lilas_tamkeen_project/core/color/app_colors.dart';
import 'package:lilas_tamkeen_project/features/cart/presentation/widgets/cart_header_icon.dart';
import 'package:lilas_tamkeen_project/features/home/data/coffee_data.dart';

const Color _kHeartActiveColor = Colors.redAccent;

const Color _kCardSurface = Color.fromRGBO(255, 255, 255, 0.06);
const Color _kTagSurface = Color.fromRGBO(255, 255, 255, 0.08);

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final Set<String> _favoriteNames = coffees.map((c) => c.name).toSet();

  void _toggleFavorite(String name) {
    setState(() {
      if (_favoriteNames.contains(name)) {
        _favoriteNames.remove(name);
      } else {
        _favoriteNames.add(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteCoffees =
        coffees.where((c) => _favoriteNames.contains(c.name)).toList();

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeaderIcon(
                      child: const Icon(Icons.grid_view_rounded,
                          color: Colors.white),
                    ),
                    const Text(
                      'Favorites',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                    HeaderIcon(
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: favoriteCoffees.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: favoriteCoffees.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          final coffee = favoriteCoffees[index];
                          return _FavoriteCoffeeCard(
                            coffee: coffee,
                            isFavorite: true,
                            onToggleFavorite: () =>
                                _toggleFavorite(coffee.name),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite_border,
            color: Colors.white54,
            size: 48,
          ),
          SizedBox(height: 12),
          Text(
            'No favorites yet',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteCoffeeCard extends StatelessWidget {
  final CoffeeProduct coffee;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const _FavoriteCoffeeCard({
    required this.coffee,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${coffee.name}, rated ${coffee.rate} out of 5',
      child: Container(
        decoration: BoxDecoration(
          color: _kCardSurface,
          borderRadius: BorderRadius.circular(24),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            _buildInfoSection(),
            _buildDescriptionSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return AspectRatio(
      aspectRatio: 1.15,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            coffee.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: _kCardSurface,
              child: const Icon(
                Icons.coffee_rounded,
                color: Colors.white54,
                size: 40,
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: _FavoriteHeartButton(
              isFavorite: isFavorite,
              onTap: onToggleFavorite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coffee.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 2),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: AppColors.textPrimary, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      coffee.rate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _InfoTag(
                    icon: Icons.coffee_rounded,
                    label: 'Coffee',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _RoastBadge(roastLevel: coffee.roastLevel),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            coffee.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 13,
              height: 1.4,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------
/// HEART TOGGLE BUTTON (top-right overlay on the image)
/// ---------------------------------------------------------------------
class _FavoriteHeartButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const _FavoriteHeartButton({
    required this.isFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.55),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Icon(
            isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: isFavorite ? _kHeartActiveColor : Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------
/// SMALL PILL TAG (e.g. "Coffee")
/// ---------------------------------------------------------------------
class _InfoTag extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoTag({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kTagSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.textPrimary),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------
/// ROAST LEVEL BADGE (e.g. "Medium Roasted")
/// ---------------------------------------------------------------------
class _RoastBadge extends StatelessWidget {
  final String roastLevel;

  const _RoastBadge({required this.roastLevel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kTagSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        roastLevel,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
