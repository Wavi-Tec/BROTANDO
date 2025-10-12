import 'package:flutter/material.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final PageController pageController;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.pageController,
    this.onPrevious,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous button
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: currentPage > 0
                  ? const Color(0xFF5DBBBB)
                  : Colors.grey[300],
              shape: BoxShape.circle,
              boxShadow: currentPage > 0
                  ? [
                      BoxShadow(
                        color: const Color(0xFF5DBBBB).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: currentPage > 0 ? Colors.white : Colors.grey[600],
              ),
              onPressed: currentPage > 0 ? onPrevious : null,
            ),
          ),

          const SizedBox(width: 40),

          Column(
            children: [
              Text(
                '${currentPage + 1}'.padLeft(2, '0'),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5DBBBB),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF5DBBBB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'de $totalPages',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Page indicators (dots)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  totalPages,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: index == currentPage ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: index == currentPage
                          ? const Color(0xFF5DBBBB)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 40),

          // Next button
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: currentPage < totalPages - 1
                  ? const Color(0xFF5DBBBB)
                  : Colors.grey[300],
              shape: BoxShape.circle,
              boxShadow: currentPage < totalPages - 1
                  ? [
                      BoxShadow(
                        color: const Color(0xFF5DBBBB).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: currentPage < totalPages - 1
                    ? Colors.white
                    : Colors.grey[600],
              ),
              onPressed: currentPage < totalPages - 1 ? onNext : null,
            ),
          ),
        ],
      ),
    );
  }
}
