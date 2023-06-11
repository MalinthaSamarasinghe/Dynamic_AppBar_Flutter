import 'custom_divider.dart';
import 'package:flutter/material.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final _scrollController = ScrollController();
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 153) {
        setState(() {
          _showTitle = true;
        });
      } else {
        setState(() {
          _showTitle = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            slivers: [
              // SliverPersistentHeader for the top app bar
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 95,
                  maxHeight: 95,
                  child: Container(
                    height: 102,
                    color: const Color(0xffffffff),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, left: 18, right: 18),
                          child: Stack(
                            children: [
                              // "Edit" text aligned to the left
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Gilroy",
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              // "Chats" text aligned to the center (conditionally shown)
                              _showTitle
                                  ? const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Chats',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Gilroy",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              // "Add" icon aligned to the right
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.add_box_outlined),
                              ),
                              // "Camera" icon aligned to the right with padding
                              const Padding(
                                padding: EdgeInsets.only(right: 40),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.camera_alt_outlined),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const CustomDivider(thickness: 0.4),
                      ],
                    ),
                  ),
                ),
              ),
              // SliverPersistentHeader for the customers icon header
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 0,
                  maxHeight: 82,
                  child: const CustomersIconHeader(),
                ),
              ),
              // SliverToBoxAdapter containing a ListView of items
              SliverToBoxAdapter(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 100,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomDivider(thickness: 0.4),
                            Text(
                              'Item ${index + 1}',
                              style: const TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w600,
                                fontFamily: "Gilroy",
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                              ),
                            ),
                            const CustomDivider(thickness: 0.4),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// SliverPersistentHeaderDelegate for the sliver app bar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

// Header widget for the customers icon
class CustomersIconHeader extends StatelessWidget {
  const CustomersIconHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Row(
        children: const [
          SizedBox(width: 18),
          Text(
            'Chats',
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w600,
              fontFamily: "Gilroy",
              fontStyle: FontStyle.normal,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
