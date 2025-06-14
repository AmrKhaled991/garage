import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabsExpandedContent extends StatefulWidget {
  List<Widget> tabs;
  List<Widget> contents;

  TabsExpandedContent({required this.tabs, required this.contents, Key? key})
    : super(key: key);

  @override
  State<TabsExpandedContent> createState() => _TabsExpandedContent();
}

class _TabsExpandedContent extends State<TabsExpandedContent>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // padding: EdgeInsets.zero,
      // shrinkWrap: true,
      // physics: const BouncingScrollPhysics(),
      children: [
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            indicatorColor: Theme.of(context).colorScheme.secondary,
            labelColor: Theme.of(context).colorScheme.secondary,
            unselectedLabelColor: Colors.black,
            onTap: (i) {
              setState(() {});
            },
            tabs: widget.tabs,
          ),
        ),
        tabView(),
      ],
    );
  }

  Widget tabView() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      // transitionBuilder:
      //     (Widget child, Animation<double> animation) =>
      //     SlideTransitionX(
      //       child: child,
      //       direction: AxisDirection.left, //右入左出
      //       position: animation,
      //     ),
      child: IndexedStack(
        // This key causes the AnimatedSwitcher to interpret this as a "new"
        // child each time the count changes, so that it will begin its animation
        // when the count changes.
        key: ValueKey<int>(_tabController.index), // add this line
        index: _tabController.index,
        children: widget.contents,
      ),
    );
  }
}
