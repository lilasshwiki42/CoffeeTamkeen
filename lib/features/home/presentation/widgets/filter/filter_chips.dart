import 'package:flutter/material.dart';
import 'package:lilas_tamkeen_project/core/color/app_colors.dart';
import 'package:lilas_tamkeen_project/features/home/data/filters_data.dart';

class FilterChips extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;

  const FilterChips({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  static const Duration _animationDuration = Duration(milliseconds: 220);
  static const Curve _animationCurve = Curves.easeOutCubic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: filters.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, i) {
            final isSelected = selected == i;
            return _FilterChip(
              label: filters[i],
              isSelected: isSelected,
              duration: _animationDuration,
              curve: _animationCurve,
              onTap: () => onSelect(i),
            );
          },
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Duration duration;
  final Curve curve;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.duration,
    required this.curve,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: AppColors.textPrimary.withOpacity(0.15),
          highlightColor: AppColors.textPrimary.withOpacity(0.08),
          child: AnimatedContainer(
            duration: duration,
            curve: curve,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.textPrimary.withOpacity(0.22)
                  : Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.textPrimary.withOpacity(0.6)
                    : Colors.transparent,
                width: 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.textPrimary.withOpacity(0.18),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: duration,
                curve: curve,
                style: TextStyle(
                  color: isSelected ? AppColors.textPrimary : Colors.white60,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  fontFamily: 'Inter',
                  fontSize: 14,
                  letterSpacing: 0.2,
                ),
                child: Text(label),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
