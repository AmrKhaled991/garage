// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Standard iOS navigation bar height without the status bar.
///
/// This height is constant and independent of accessibility as it is in iOS.
const double _kNavBarPersistentHeight = kMinInteractiveDimensionCupertino;

/// Size increase from expanding the navigation bar into an iOS-11-style large title
/// form in a [CustomScrollView].
const double _kNavBarLargeTitleHeightExtension = 52.0;

/// Number of logical pixels scrolled down before the title text is transferred
/// from the normal navigation bar to a big title below the navigation bar.
const double _kNavBarShowLargeTitleThreshold = 10.0;

const double _kNavBarEdgePadding = 16.0;

const double _kNavBarBackButtonTapWidth = 50.0;

/// Title text transfer fade.
const Duration _kNavBarTitleFadeDuration = Duration(milliseconds: 150);

const Color _kDefaultNavBarBorderColor = Color(0x4D000000);

const Border _kDefaultNavBarBorder = Border(
  bottom: BorderSide(
    color: _kDefaultNavBarBorderColor,
    width: 0.0, // 0.0 means one physical pixel
  ),
);

// There's a single tag for all instances of navigation bars because they can
// all transition between each other (per Navigator) via Hero transitions.
const _HeroTag _defaultHeroTag = _HeroTag(null);

@immutable
class _HeroTag {
  const _HeroTag(this.navigator);

  final NavigatorState? navigator;

  // Let the Hero tag be described in tree dumps.
  @override
  String toString() =>
      'Default Hero tag for Cupertino navigation bars with navigator $navigator';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _HeroTag && other.navigator == navigator;
  }

  @override
  int get hashCode => identityHashCode(navigator);
}

// An `AnimatedWidget` that imposes a fixed size on its child widget, and
// shifts the child widget in the parent stack, driven by its `offsetAnimation`
// property.
class _FixedSizeSlidingTransition extends AnimatedWidget {
  const _FixedSizeSlidingTransition({
    required this.isLTR,
    required this.offsetAnimation,
    required this.size,
    required this.child,
  }) : super(listenable: offsetAnimation);

  // Whether the writing direction used in the navigation bar transition is
  // left-to-right.
  final bool isLTR;

  // The fixed size to impose on `child`.
  final Size size;

  // The animated offset from the top-leading corner of the stack.
  //
  // When `isLTR` is true, the `Offset` is the position of the child widget in
  // the stack render box's regular coordinate space.
  //
  // When `isLTR` is false, the coordinate system is flipped around the
  // horizontal axis and the origin is set to the top right corner of the render
  // boxes. In other words, this parameter describes the offset from the top
  // right corner of the stack, to the top right corner of the child widget, and
  // the x-axis runs right to left.
  final Animation<Offset> offsetAnimation;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: offsetAnimation.value.dy,
      left: isLTR ? offsetAnimation.value.dx : null,
      right: isLTR ? null : offsetAnimation.value.dx,
      width: size.width,
      height: size.height,
      child: child,
    );
  }
}

/// Returns `child` wrapped with background and a bottom border if background color
/// is opaque. Otherwise, also blur with [BackdropFilter].
///
/// When `updateSystemUiOverlay` is true, the nav bar will update the OS
/// status bar's color theme based on the background color of the nav bar.
Widget _wrapWithBackground({
  Border? border,
  required Color backgroundColor,
  Brightness? brightness,
  required Widget child,
  bool updateSystemUiOverlay = true,
  final Decoration? decoration,
}) {
  Widget result = child;
  if (updateSystemUiOverlay) {
    final bool isDark = backgroundColor.computeLuminance() < 0.179;
    final Brightness newBrightness =
        brightness ?? (isDark ? Brightness.dark : Brightness.light);
    final SystemUiOverlayStyle overlayStyle;
    switch (newBrightness) {
      case Brightness.dark:
        overlayStyle = SystemUiOverlayStyle.light;
        break;
      case Brightness.light:
        overlayStyle = SystemUiOverlayStyle.dark;
        break;
    }
    result = AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: result,
    );
  }
  final DecoratedBox childWithBackground = DecoratedBox(
    decoration: BoxDecoration(border: border, color: backgroundColor),
    child: result,
  );

  if (backgroundColor.alpha == 0xFF) {
    return childWithBackground;
  }

  return ClipRect(
    // child: BackdropFilter(
    //   filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
    child: Container(decoration: decoration, child: childWithBackground),
    // ),
  );
}

// Whether the current route supports nav bar hero transitions from or to.
bool _isTransitionable(BuildContext context) {
  final ModalRoute<dynamic>? route = ModalRoute.of(context);

  // Fullscreen dialogs never transitions their nav bar with other push-style
  // pages' nav bars or with other fullscreen dialog pages on the way in or on
  // the way out.
  return route is PageRoute && !route.fullscreenDialog;
}

/// An iOS-styled navigation bar.
///
/// The navigation bar is a toolbar that minimally consists of a widget, normally
/// a page title, in the [middle] of the toolbar.
///
/// It also supports a [leading] and [trailing] widget before and after the
/// [middle] widget while keeping the [middle] widget centered.
///
/// The [leading] widget will automatically be a back chevron icon button (or a
/// close button in case of a fullscreen dialog) to pop the current route if none
/// is provided and [automaticallyImplyLeading] is true (true by default).
///
/// The [middle] widget will automatically be a title text from the current
/// [CupertinoPageRoute] if none is provided and [automaticallyImplyMiddle] is
/// true (true by default).
///
/// It should be placed at top of the screen and automatically accounts for
/// the OS's status bar.
///
/// If the given [backgroundColor]'s opacity is not 1.0 (which is the case by
/// default), it will produce a blurring effect to the content behind it.
///
/// When [transitionBetweenRoutes] is true, this navigation bar will transition
/// on top of the routes instead of inside them if the route being transitioned
/// to also has a [MyCupertinoNavigationBar] or a [CupertinoSliverNavigationBar]
/// with [transitionBetweenRoutes] set to true. If [transitionBetweenRoutes] is
/// true, none of the [Widget] parameters can contain a key in its subtree since
/// that widget will exist in multiple places in the tree simultaneously.
///
/// By default, only one [MyCupertinoNavigationBar] or [CupertinoSliverNavigationBar]
/// should be present in each [PageRoute] to support the default transitions.
/// Use [transitionBetweenRoutes] or [heroTag] to customize the transition
/// behavior for multiple navigation bars per route.
///
/// When used in a [CupertinoPageScaffold], [CupertinoPageScaffold.navigationBar]
/// has its text scale factor set to 1.0 and does not respond to text scale factor
/// changes from the operating system, to match the native iOS behavior. To override
/// this behavior, wrap each of the `navigationBar`'s components inside a [MediaQuery]
/// with the desired [MediaQueryData.textScaleFactor] value. The text scale factor
/// value from the operating system can be retrieved in many ways, such as querying
/// [MediaQuery.textScaleFactorOf] against [CupertinoApp]'s [BuildContext].
///
/// {@tool dartpad}
/// This example shows a [MyCupertinoNavigationBar] placed in a [CupertinoPageScaffold].
/// Since [backgroundColor]'s opacity is not 1.0, there is a blur effect and
/// content slides underneath.
///
/// ** See code in examples/api/lib/cupertino/nav_bar/cupertino_navigation_bar.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [CupertinoPageScaffold], a page layout helper typically hosting the
///    [MyCupertinoNavigationBar].
///  * [CupertinoSliverNavigationBar] for a navigation bar to be placed in a
///    scrolling list and that supports iOS-11-style large titles.
///  * <https://developer.apple.com/design/human-interface-guidelines/ios/bars/navigation-bars/>
class MyCupertinoNavigationBar extends StatefulWidget
    implements ObstructingPreferredSizeWidget {
  /// Creates a navigation bar in the iOS style.
  const MyCupertinoNavigationBar({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.automaticallyImplyMiddle = true,
    this.previousPageTitle,
    this.middle,
    this.trailing,
    this.border = _kDefaultNavBarBorder,
    this.backgroundColor,
    this.brightness,
    this.padding,
    this.transitionBetweenRoutes = true,
    this.heroTag = _defaultHeroTag,
    this.decoration,
  }) : assert(automaticallyImplyLeading != null),
       assert(automaticallyImplyMiddle != null),
       assert(transitionBetweenRoutes != null),
       assert(
         heroTag != null,
         'heroTag cannot be null. Use transitionBetweenRoutes = false to '
         'disable Hero transition on this navigation bar.',
       ),
       assert(
         !transitionBetweenRoutes || identical(heroTag, _defaultHeroTag),
         'Cannot specify a heroTag override if this navigation bar does not '
         'transition due to transitionBetweenRoutes = false.',
       );

  final Decoration? decoration;

  /// {@template flutter.cupertino.CupertinoNavigationBar.leading}
  /// Widget to place at the start of the navigation bar. Normally a back button
  /// for a normal page or a cancel button for full page dialogs.
  ///
  /// If null and [automaticallyImplyLeading] is true, an appropriate button
  /// will be automatically created.
  /// {@endtemplate}
  final Widget? leading;

  /// {@template flutter.cupertino.CupertinoNavigationBar.automaticallyImplyLeading}
  /// Controls whether we should try to imply the leading widget if null.
  ///
  /// If true and [leading] is null, automatically try to deduce what the [leading]
  /// widget should be. If [leading] widget is not null, this parameter has no effect.
  ///
  /// Specifically this navigation bar will:
  ///
  /// 1. Show a 'Close' button if the current route is a `fullscreenDialog`.
  /// 2. Show a back chevron with [previousPageTitle] if [previousPageTitle] is
  ///    not null.
  /// 3. Show a back chevron with the previous route's `title` if the current
  ///    route is a [CupertinoPageRoute] and the previous route is also a
  ///    [CupertinoPageRoute].
  ///
  /// This value cannot be null.
  /// {@endtemplate}
  final bool automaticallyImplyLeading;

  /// Controls whether we should try to imply the middle widget if null.
  ///
  /// If true and [middle] is null, automatically fill in a [Text] widget with
  /// the current route's `title` if the route is a [CupertinoPageRoute].
  /// If [middle] widget is not null, this parameter has no effect.
  ///
  /// This value cannot be null.
  final bool automaticallyImplyMiddle;

  /// {@template flutter.cupertino.CupertinoNavigationBar.previousPageTitle}
  /// Manually specify the previous route's title when automatically implying
  /// the leading back button.
  ///
  /// Overrides the text shown with the back chevron instead of automatically
  /// showing the previous [CupertinoPageRoute]'s `title` when
  /// [automaticallyImplyLeading] is true.
  ///
  /// Has no effect when [leading] is not null or if [automaticallyImplyLeading]
  /// is false.
  /// {@endtemplate}
  final String? previousPageTitle;

  /// Widget to place in the middle of the navigation bar. Normally a title or
  /// a segmented control.
  ///
  /// If null and [automaticallyImplyMiddle] is true, an appropriate [Text]
  /// title will be created if the current route is a [CupertinoPageRoute] and
  /// has a `title`.
  final Widget? middle;

  /// {@template flutter.cupertino.CupertinoNavigationBar.trailing}
  /// Widget to place at the end of the navigation bar. Normally additional actions
  /// taken on the page such as a search or edit function.
  /// {@endtemplate}
  final Widget? trailing;

  // TODO(xster): https://github.com/flutter/flutter/issues/10469 implement
  // support for double row navigation bars.

  /// {@template flutter.cupertino.CupertinoNavigationBar.backgroundColor}
  /// The background color of the navigation bar. If it contains transparency, the
  /// tab bar will automatically produce a blurring effect to the content
  /// behind it.
  ///
  /// Defaults to [CupertinoTheme]'s `barBackgroundColor` if null.
  /// {@endtemplate}
  final Color? backgroundColor;

  /// {@template flutter.cupertino.CupertinoNavigationBar.brightness}
  /// The brightness of the specified [backgroundColor].
  ///
  /// Setting this value changes the style of the system status bar. Typically
  /// used to increase the contrast ratio of the system status bar over
  /// [backgroundColor].
  ///
  /// If set to null, the value of the property will be inferred from the relative
  /// luminance of [backgroundColor].
  /// {@endtemplate}
  final Brightness? brightness;

  /// {@template flutter.cupertino.CupertinoNavigationBar.padding}
  /// Padding for the contents of the navigation bar.
  ///
  /// If null, the navigation bar will adopt the following defaults:
  ///
  ///  * Vertically, contents will be sized to the same height as the navigation
  ///    bar itself minus the status bar.
  ///  * Horizontally, padding will be 16 pixels according to iOS specifications
  ///    unless the leading widget is an automatically inserted back button, in
  ///    which case the padding will be 0.
  ///
  /// Vertical padding won't change the height of the nav bar.
  /// {@endtemplate}
  final EdgeInsetsDirectional? padding;

  /// {@template flutter.cupertino.CupertinoNavigationBar.border}
  /// The border of the navigation bar. By default renders a single pixel bottom border side.
  ///
  /// If a border is null, the navigation bar will not display a border.
  /// {@endtemplate}
  final Border? border;

  /// {@template flutter.cupertino.CupertinoNavigationBar.transitionBetweenRoutes}
  /// Whether to transition between navigation bars.
  ///
  /// When [transitionBetweenRoutes] is true, this navigation bar will transition
  /// on top of the routes instead of inside it if the route being transitioned
  /// to also has a [MyCupertinoNavigationBar] or a [CupertinoSliverNavigationBar]
  /// with [transitionBetweenRoutes] set to true.
  ///
  /// This transition will also occur on edge back swipe gestures like on iOS
  /// but only if the previous page below has `maintainState` set to true on the
  /// [PageRoute].
  ///
  /// When set to true, only one navigation bar can be present per route unless
  /// [heroTag] is also set.
  ///
  /// This value defaults to true and cannot be null.
  /// {@endtemplate}
  final bool transitionBetweenRoutes;

  /// {@template flutter.cupertino.CupertinoNavigationBar.heroTag}
  /// Tag for the navigation bar's Hero widget if [transitionBetweenRoutes] is true.
  ///
  /// Defaults to a common tag between all [MyCupertinoNavigationBar] and
  /// [CupertinoSliverNavigationBar] instances of the same [Navigator]. With the
  /// default tag, all navigation bars of the same navigator can transition
  /// between each other as long as there's only one navigation bar per route.
  ///
  /// This [heroTag] can be overridden to manually handle having multiple
  /// navigation bars per route or to transition between multiple
  /// [Navigator]s.
  ///
  /// Cannot be null. To disable Hero transitions for this navigation bar,
  /// set [transitionBetweenRoutes] to false.
  /// {@endtemplate}
  final Object heroTag;

  /// True if the navigation bar's background color has no transparency.
  @override
  bool shouldFullyObstruct(BuildContext context) {
    final Color backgroundColor =
        CupertinoDynamicColor.maybeResolve(this.backgroundColor, context) ??
        CupertinoTheme.of(context).barBackgroundColor;
    return backgroundColor.alpha == 0xFF;
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(_kNavBarPersistentHeight);
  }

  @override
  State<MyCupertinoNavigationBar> createState() =>
      _MyCupertinoNavigationBarState();
}

// A state class exists for the nav bar so that the keys of its sub-components
// don't change when rebuilding the nav bar, causing the sub-components to
// lose their own states.
class _MyCupertinoNavigationBarState extends State<MyCupertinoNavigationBar> {
  late _NavigationBarStaticComponentsKeys keys;

  @override
  void initState() {
    super.initState();
    keys = _NavigationBarStaticComponentsKeys();
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        CupertinoDynamicColor.maybeResolve(widget.backgroundColor, context) ??
        CupertinoTheme.of(context).barBackgroundColor;

    final _NavigationBarStaticComponents components =
        _NavigationBarStaticComponents(
          keys: keys,
          route: ModalRoute.of(context),
          userLeading: widget.leading,
          automaticallyImplyLeading: widget.automaticallyImplyLeading,
          automaticallyImplyTitle: widget.automaticallyImplyMiddle,
          previousPageTitle: widget.previousPageTitle,
          userMiddle: widget.middle,
          userTrailing: widget.trailing,
          padding: widget.padding,
          userLargeTitle: null,
          large: false,
        );

    final Widget navBar = _wrapWithBackground(
      border: widget.border,
      backgroundColor: backgroundColor,
      brightness: widget.brightness,
      decoration: widget.decoration,
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: _PersistentNavigationBar(
          components: components,
          padding: widget.padding,
        ),
      ),
    );

    if (!widget.transitionBetweenRoutes || !_isTransitionable(context)) {
      // Lint ignore to maintain backward compatibility.
      return navBar;
    }

    return Builder(
      // Get the context that might have a possibly changed CupertinoTheme.
      builder: (BuildContext context) {
        return Hero(
          tag:
              widget.heroTag == _defaultHeroTag
                  ? _HeroTag(Navigator.of(context))
                  : widget.heroTag,
          createRectTween: _linearTranslateWithLargestRectSizeTween,
          placeholderBuilder: _navBarHeroLaunchPadBuilder,
          flightShuttleBuilder: _navBarHeroFlightShuttleBuilder,
          transitionOnUserGestures: true,
          child: _TransitionableNavigationBar(
            componentsKeys: keys,
            backgroundColor: backgroundColor,
            backButtonTextStyle:
                CupertinoTheme.of(context).textTheme.navActionTextStyle,
            titleTextStyle:
                CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            largeTitleTextStyle: null,
            border: widget.border,
            decoration: widget.decoration,
            hasUserMiddle: widget.middle != null,
            largeExpanded: false,
            child: navBar,
          ),
        );
      },
    );
  }
}

/// An iOS-styled navigation bar with iOS-11-style large titles using slivers.
///
/// The [CupertinoSliverNavigationBar] must be placed in a sliver group such
/// as the [CustomScrollView].
///
/// This navigation bar consists of two sections, a pinned static section on top
/// and a sliding section containing iOS-11-style large title below it.
///
/// It should be placed at top of the screen and automatically accounts for
/// the iOS status bar.
///
/// Minimally, a [largeTitle] widget will appear in the middle of the app bar
/// when the sliver is collapsed and transfer to the area below in larger font
/// when the sliver is expanded.
///
/// For advanced uses, an optional [middle] widget can be supplied to show a
/// different widget in the middle of the navigation bar when the sliver is collapsed.
///
/// Like [MyCupertinoNavigationBar], it also supports a [leading] and [trailing]
/// widget on the static section on top that remains while scrolling.
///
/// The [leading] widget will automatically be a back chevron icon button (or a
/// close button in case of a fullscreen dialog) to pop the current route if none
/// is provided and [automaticallyImplyLeading] is true (true by default).
///
/// The [largeTitle] widget will automatically be a title text from the current
/// [CupertinoPageRoute] if none is provided and [automaticallyImplyTitle] is
/// true (true by default).
///
/// When [transitionBetweenRoutes] is true, this navigation bar will transition
/// on top of the routes instead of inside them if the route being transitioned
/// to also has a [MyCupertinoNavigationBar] or a [CupertinoSliverNavigationBar]
/// with [transitionBetweenRoutes] set to true. If [transitionBetweenRoutes] is
/// true, none of the [Widget] parameters can contain any [GlobalKey]s in their
/// subtrees since those widgets will exist in multiple places in the tree
/// simultaneously.
///
/// By default, only one [MyCupertinoNavigationBar] or [CupertinoSliverNavigationBar]
/// should be present in each [PageRoute] to support the default transitions.
/// Use [transitionBetweenRoutes] or [heroTag] to customize the transition
/// behavior for multiple navigation bars per route.
///
/// `CupertinoSliverNavigationBar` has its text scale factor set to 1.0 by default
/// and does not respond to text scale factor changes from the operating system,
/// to match the native iOS behavior. To override this behavior, wrap each of the
/// `CupertinoSliverNavigationBar`'s components inside a [MediaQuery] with the
/// desired [MediaQueryData.textScaleFactor] value. The text scale factor value
/// from the operating system can be retrieved in many ways, such as querying
/// [MediaQuery.textScaleFactorOf] against [CupertinoApp]'s [BuildContext].
///
/// The [stretch] parameter determines whether the nav bar should stretch to
/// fill the over-scroll area. The nav bar can still expand and contract as the
/// user scrolls, but it will also stretch when the user over-scrolls if the
/// [stretch] value is `true`. Defaults to `false`.
///
/// {@tool dartpad}
/// This example shows [CupertinoSliverNavigationBar] in action inside a [CustomScrollView].
///
/// ** See code in examples/api/lib/cupertino/nav_bar/cupertino_sliver_nav_bar.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [MyCupertinoNavigationBar], an iOS navigation bar for use on non-scrolling
///    pages.
///  * [CustomScrollView], a ScrollView that creates custom scroll effects using slivers.
///  * <https://developer.apple.com/design/human-interface-guidelines/ios/bars/navigation-bars/>
class CupertinoSliverNavigationBar extends StatefulWidget {
  /// Creates a navigation bar for scrolling lists.
  ///
  /// The [largeTitle] argument is required and must not be null.
  const CupertinoSliverNavigationBar({
    super.key,
    this.largeTitle,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.automaticallyImplyTitle = true,
    this.previousPageTitle,
    this.middle,
    this.trailing,
    this.border = _kDefaultNavBarBorder,
    this.backgroundColor,
    this.brightness,
    this.padding,
    this.transitionBetweenRoutes = true,
    this.heroTag = _defaultHeroTag,
    this.stretch = false,
  }) : assert(automaticallyImplyLeading != null),
       assert(automaticallyImplyTitle != null),
       assert(
         automaticallyImplyTitle == true || largeTitle != null,
         'No largeTitle has been provided but automaticallyImplyTitle is also '
         'false. Either provide a largeTitle or set automaticallyImplyTitle to '
         'true.',
       );

  /// The navigation bar's title.
  ///
  /// This text will appear in the top static navigation bar when collapsed and
  /// below the navigation bar, in a larger font, when expanded.
  ///
  /// A suitable [DefaultTextStyle] is provided around this widget as it is
  /// moved around, to change its font size.
  ///
  /// If [middle] is null, then the [largeTitle] widget will be inserted into
  /// the tree in two places when transitioning from the collapsed state to the
  /// expanded state. It is therefore imperative that this subtree not contain
  /// any [GlobalKey]s, and that it not rely on maintaining state (for example,
  /// animations will not survive the transition from one location to the other,
  /// and may in fact be visible in two places at once during the transition).
  ///
  /// If null and [automaticallyImplyTitle] is true, an appropriate [Text]
  /// title will be created if the current route is a [CupertinoPageRoute] and
  /// has a `title`.
  ///
  /// This parameter must either be non-null or the route must have a title
  /// ([CupertinoPageRoute.title]) and [automaticallyImplyTitle] must be true.
  final Widget? largeTitle;

  /// {@macro flutter.cupertino.CupertinoNavigationBar.leading}
  ///
  /// This widget is visible in both collapsed and expanded states.
  final Widget? leading;

  /// {@macro flutter.cupertino.CupertinoNavigationBar.automaticallyImplyLeading}
  final bool automaticallyImplyLeading;

  /// Controls whether we should try to imply the [largeTitle] widget if null.
  ///
  /// If true and [largeTitle] is null, automatically fill in a [Text] widget
  /// with the current route's `title` if the route is a [CupertinoPageRoute].
  /// If [largeTitle] widget is not null, this parameter has no effect.
  ///
  /// This value cannot be null.
  final bool automaticallyImplyTitle;

  /// {@macro flutter.cupertino.CupertinoNavigationBar.previousPageTitle}
  final String? previousPageTitle;

  /// A widget to place in the middle of the static navigation bar instead of
  /// the [largeTitle].
  ///
  /// This widget is visible in both collapsed and expanded states. The text
  /// supplied in [largeTitle] will no longer appear in collapsed state if a
  /// [middle] widget is provided.
  final Widget? middle;

  /// {@macro flutter.cupertino.CupertinoNavigationBar.trailing}
  ///
  /// This widget is visible in both collapsed and expanded states.
  final Widget? trailing;

  /// {@macro flutter.cupertino.CupertinoNavigationBar.backgroundColor}
  final Color? backgroundColor;

  /// {@macro flutter.cupertino.CupertinoNavigationBar.brightness}
  final Brightness? brightness;

  /// {@macro flutter.cupertino.CupertinoNavigationBar.padding}
  final EdgeInsetsDirectional? padding;

  /// {@macro flutter.cupertino.CupertinoNavigationBar.border}
  final Border? border;

  /// {@macro flutter.cupertino.CupertinoNavigationBar.transitionBetweenRoutes}
  final bool transitionBetweenRoutes;

  /// {@macro flutter.cupertino.CupertinoNavigationBar.heroTag}
  final Object heroTag;

  /// True if the navigation bar's background color has no transparency.
  bool get opaque => backgroundColor?.alpha == 0xFF;

  /// Whether the nav bar should stretch to fill the over-scroll area.
  ///
  /// The nav bar can still expand and contract as the user scrolls, but it will
  /// also stretch when the user over-scrolls if the [stretch] value is `true`.
  ///
  /// When set to `true`, the nav bar will prevent subsequent slivers from
  /// accessing overscrolls. This may be undesirable for using overscroll-based
  /// widgets like the [CupertinoSliverRefreshControl].
  ///
  /// Defaults to `false`.
  final bool stretch;

  @override
  State<CupertinoSliverNavigationBar> createState() =>
      _CupertinoSliverNavigationBarState();
}

// A state class exists for the nav bar so that the keys of its sub-components
// don't change when rebuilding the nav bar, causing the sub-components to
// lose their own states.
class _CupertinoSliverNavigationBarState
    extends State<CupertinoSliverNavigationBar> {
  late _NavigationBarStaticComponentsKeys keys;

  @override
  void initState() {
    super.initState();
    keys = _NavigationBarStaticComponentsKeys();
  }

  @override
  Widget build(BuildContext context) {
    final _NavigationBarStaticComponents components =
        _NavigationBarStaticComponents(
          keys: keys,
          route: ModalRoute.of(context),
          userLeading: widget.leading,
          automaticallyImplyLeading: widget.automaticallyImplyLeading,
          automaticallyImplyTitle: widget.automaticallyImplyTitle,
          previousPageTitle: widget.previousPageTitle,
          userMiddle: widget.middle,
          userTrailing: widget.trailing,
          userLargeTitle: widget.largeTitle,
          padding: widget.padding,
          large: true,
        );

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: SliverPersistentHeader(
        pinned: true, // iOS navigation bars are always pinned.
        delegate: _LargeTitleNavigationBarSliverDelegate(
          keys: keys,
          components: components,
          userMiddle: widget.middle,
          backgroundColor:
              CupertinoDynamicColor.maybeResolve(
                widget.backgroundColor,
                context,
              ) ??
              CupertinoTheme.of(context).barBackgroundColor,
          brightness: widget.brightness,
          border: widget.border,
          padding: widget.padding,
          actionsForegroundColor: CupertinoTheme.of(context).primaryColor,
          transitionBetweenRoutes: widget.transitionBetweenRoutes,
          heroTag: widget.heroTag,
          persistentHeight:
              _kNavBarPersistentHeight + MediaQuery.of(context).padding.top,
          alwaysShowMiddle: widget.middle != null,
          stretchConfiguration:
              widget.stretch ? OverScrollHeaderStretchConfiguration() : null,
        ),
      ),
    );
  }
}

class _LargeTitleNavigationBarSliverDelegate
    extends SliverPersistentHeaderDelegate
    with DiagnosticableTreeMixin {
  _LargeTitleNavigationBarSliverDelegate({
    required this.keys,
    required this.components,
    required this.userMiddle,
    required this.backgroundColor,
    required this.brightness,
    required this.border,
    required this.padding,
    required this.actionsForegroundColor,
    required this.transitionBetweenRoutes,
    required this.heroTag,
    required this.persistentHeight,
    required this.alwaysShowMiddle,
    required this.stretchConfiguration,
  }) : assert(persistentHeight != null),
       assert(alwaysShowMiddle != null),
       assert(transitionBetweenRoutes != null);

  final _NavigationBarStaticComponentsKeys keys;
  final _NavigationBarStaticComponents components;
  final Widget? userMiddle;
  final Color backgroundColor;
  final Brightness? brightness;
  final Border? border;
  final EdgeInsetsDirectional? padding;
  final Color actionsForegroundColor;
  final bool transitionBetweenRoutes;
  final Object heroTag;
  final double persistentHeight;
  final bool alwaysShowMiddle;

  @override
  double get minExtent => persistentHeight;

  @override
  double get maxExtent => persistentHeight + _kNavBarLargeTitleHeightExtension;

  @override
  OverScrollHeaderStretchConfiguration? stretchConfiguration;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final bool showLargeTitle =
        shrinkOffset < maxExtent - minExtent - _kNavBarShowLargeTitleThreshold;

    final _PersistentNavigationBar persistentNavigationBar =
        _PersistentNavigationBar(
          components: components,
          padding: padding,
          // If a user specified middle exists, always show it. Otherwise, show
          // title when sliver is collapsed.
          middleVisible: alwaysShowMiddle ? null : !showLargeTitle,
        );

    final Widget navBar = _wrapWithBackground(
      border: border,
      backgroundColor: CupertinoDynamicColor.resolve(backgroundColor, context),
      brightness: brightness,
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: persistentHeight,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: ClipRect(
                // The large title starts at the persistent bar.
                // It's aligned with the bottom of the sliver and expands clipped
                // and behind the persistent bar.
                child: OverflowBox(
                  minHeight: 0.0,
                  maxHeight: double.infinity,
                  alignment: AlignmentDirectional.bottomStart,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: _kNavBarEdgePadding,
                      bottom: 8.0, // Bottom has a different padding.
                    ),
                    child: SafeArea(
                      top: false,
                      bottom: false,
                      child: AnimatedOpacity(
                        opacity: showLargeTitle ? 1.0 : 0.0,
                        duration: _kNavBarTitleFadeDuration,
                        child: Semantics(
                          header: true,
                          child: DefaultTextStyle(
                            style:
                                CupertinoTheme.of(
                                  context,
                                ).textTheme.navLargeTitleTextStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            child: components.largeTitle!,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 0.0,
              child: persistentNavigationBar,
            ),
          ],
        ),
      ),
    );

    if (!transitionBetweenRoutes || !_isTransitionable(context)) {
      return navBar;
    }

    return Hero(
      tag:
          heroTag == _defaultHeroTag
              ? _HeroTag(Navigator.of(context))
              : heroTag,
      createRectTween: _linearTranslateWithLargestRectSizeTween,
      flightShuttleBuilder: _navBarHeroFlightShuttleBuilder,
      placeholderBuilder: _navBarHeroLaunchPadBuilder,
      transitionOnUserGestures: true,
      // This is all the way down here instead of being at the top level of
      // CupertinoSliverNavigationBar like CupertinoNavigationBar because it
      // needs to wrap the top level RenderBox rather than a RenderSliver.
      child: _TransitionableNavigationBar(
        componentsKeys: keys,
        backgroundColor: CupertinoDynamicColor.resolve(
          backgroundColor,
          context,
        ),
        backButtonTextStyle:
            CupertinoTheme.of(context).textTheme.navActionTextStyle,
        titleTextStyle: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
        largeTitleTextStyle:
            CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
        border: border,
        hasUserMiddle: userMiddle != null,
        largeExpanded: showLargeTitle,
        child: navBar,
      ),
    );
  }

  @override
  bool shouldRebuild(_LargeTitleNavigationBarSliverDelegate oldDelegate) {
    return components != oldDelegate.components ||
        userMiddle != oldDelegate.userMiddle ||
        backgroundColor != oldDelegate.backgroundColor ||
        border != oldDelegate.border ||
        padding != oldDelegate.padding ||
        actionsForegroundColor != oldDelegate.actionsForegroundColor ||
        transitionBetweenRoutes != oldDelegate.transitionBetweenRoutes ||
        persistentHeight != oldDelegate.persistentHeight ||
        alwaysShowMiddle != oldDelegate.alwaysShowMiddle ||
        heroTag != oldDelegate.heroTag;
  }
}

/// The top part of the navigation bar that's never scrolled away.
///
/// Consists of the entire navigation bar without background and border when used
/// without large titles. With large titles, it's the top static half that
/// doesn't scroll.
class _PersistentNavigationBar extends StatelessWidget {
  const _PersistentNavigationBar({
    required this.components,
    this.padding,
    this.middleVisible,
  });

  final _NavigationBarStaticComponents components;

  final EdgeInsetsDirectional? padding;

  /// Whether the middle widget has a visible animated opacity. A null value
  /// means the middle opacity will not be animated.
  final bool? middleVisible;

  @override
  Widget build(BuildContext context) {
    Widget? middle = components.middle;

    if (middle != null) {
      middle = DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
        child: Semantics(header: true, child: middle),
      );
      // When the middle's visibility can change on the fly like with large title
      // slivers, wrap with animated opacity.
      middle =
          middleVisible == null
              ? middle
              : AnimatedOpacity(
                opacity: middleVisible! ? 1.0 : 0.0,
                duration: _kNavBarTitleFadeDuration,
                child: middle,
              );
    }

    Widget? leading = components.leading;
    final Widget? backChevron = components.backChevron;
    final Widget? backLabel = components.backLabel;

    if (leading == null && backChevron != null && backLabel != null) {
      leading = CupertinoNavigationBarBackButton._assemble(
        backChevron,
        backLabel,
      );
    }

    Widget paddedToolbar = NavigationToolbar(
      leading: leading,
      middle: middle,
      trailing: components.trailing,
      middleSpacing: 6.0,
    );

    if (padding != null) {
      paddedToolbar = Padding(
        padding: EdgeInsets.only(top: padding!.top, bottom: padding!.bottom),
        child: paddedToolbar,
      );
    }

    return SizedBox(
      height: _kNavBarPersistentHeight + MediaQuery.of(context).padding.top,
      child: SafeArea(bottom: false, child: paddedToolbar),
    );
  }
}

// A collection of keys always used when building static routes' nav bars's
// components with _NavigationBarStaticComponents and read in
// _NavigationBarTransition in Hero flights in order to reference the components'
// RenderBoxes for their positions.
//
// These keys should never re-appear inside the Hero flights.
@immutable
class _NavigationBarStaticComponentsKeys {
  _NavigationBarStaticComponentsKeys()
    : navBarBoxKey = GlobalKey(debugLabel: 'Navigation bar render box'),
      leadingKey = GlobalKey(debugLabel: 'Leading'),
      backChevronKey = GlobalKey(debugLabel: 'Back chevron'),
      backLabelKey = GlobalKey(debugLabel: 'Back label'),
      middleKey = GlobalKey(debugLabel: 'Middle'),
      trailingKey = GlobalKey(debugLabel: 'Trailing'),
      largeTitleKey = GlobalKey(debugLabel: 'Large title');

  final GlobalKey navBarBoxKey;
  final GlobalKey leadingKey;
  final GlobalKey backChevronKey;
  final GlobalKey backLabelKey;
  final GlobalKey middleKey;
  final GlobalKey trailingKey;
  final GlobalKey largeTitleKey;
}

// Based on various user Widgets and other parameters, construct KeyedSubtree
// components that are used in common by the CupertinoNavigationBar and
// CupertinoSliverNavigationBar. The KeyedSubtrees are inserted into static
// routes and the KeyedSubtrees' child are reused in the Hero flights.
@immutable
class _NavigationBarStaticComponents {
  _NavigationBarStaticComponents({
    required _NavigationBarStaticComponentsKeys keys,
    required ModalRoute<dynamic>? route,
    required Widget? userLeading,
    required bool automaticallyImplyLeading,
    required bool automaticallyImplyTitle,
    required String? previousPageTitle,
    required Widget? userMiddle,
    required Widget? userTrailing,
    required Widget? userLargeTitle,
    required EdgeInsetsDirectional? padding,
    required bool large,
  }) : leading = createLeading(
         leadingKey: keys.leadingKey,
         userLeading: userLeading,
         route: route,
         automaticallyImplyLeading: automaticallyImplyLeading,
         padding: padding,
       ),
       backChevron = createBackChevron(
         backChevronKey: keys.backChevronKey,
         userLeading: userLeading,
         route: route,
         automaticallyImplyLeading: automaticallyImplyLeading,
       ),
       backLabel = createBackLabel(
         backLabelKey: keys.backLabelKey,
         userLeading: userLeading,
         route: route,
         previousPageTitle: previousPageTitle,
         automaticallyImplyLeading: automaticallyImplyLeading,
       ),
       middle = createMiddle(
         middleKey: keys.middleKey,
         userMiddle: userMiddle,
         userLargeTitle: userLargeTitle,
         route: route,
         automaticallyImplyTitle: automaticallyImplyTitle,
         large: large,
       ),
       trailing = createTrailing(
         trailingKey: keys.trailingKey,
         userTrailing: userTrailing,
         padding: padding,
       ),
       largeTitle = createLargeTitle(
         largeTitleKey: keys.largeTitleKey,
         userLargeTitle: userLargeTitle,
         route: route,
         automaticImplyTitle: automaticallyImplyTitle,
         large: large,
       );

  static Widget? _derivedTitle({
    required bool automaticallyImplyTitle,
    ModalRoute<dynamic>? currentRoute,
  }) {
    // Auto use the CupertinoPageRoute's title if middle not provided.
    if (automaticallyImplyTitle &&
        currentRoute is CupertinoRouteTransitionMixin &&
        currentRoute.title != null) {
      return Text(currentRoute.title!);
    }

    return null;
  }

  final KeyedSubtree? leading;
  static KeyedSubtree? createLeading({
    required GlobalKey leadingKey,
    required Widget? userLeading,
    required ModalRoute<dynamic>? route,
    required bool automaticallyImplyLeading,
    required EdgeInsetsDirectional? padding,
  }) {
    Widget? leadingContent;

    if (userLeading != null) {
      leadingContent = userLeading;
    } else if (automaticallyImplyLeading &&
        route is PageRoute &&
        route.canPop &&
        route.fullscreenDialog) {
      leadingContent = CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          route.navigator!.maybePop();
        },
        child: const Text('Close'),
      );
    }

    if (leadingContent == null) {
      return null;
    }

    return KeyedSubtree(
      key: leadingKey,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: padding?.start ?? _kNavBarEdgePadding,
        ),
        child: IconTheme.merge(
          data: const IconThemeData(size: 32.0),
          child: leadingContent,
        ),
      ),
    );
  }

  final KeyedSubtree? backChevron;
  static KeyedSubtree? createBackChevron({
    required GlobalKey backChevronKey,
    required Widget? userLeading,
    required ModalRoute<dynamic>? route,
    required bool automaticallyImplyLeading,
  }) {
    if (userLeading != null ||
        !automaticallyImplyLeading ||
        route == null ||
        !route.canPop ||
        (route is PageRoute && route.fullscreenDialog)) {
      return null;
    }

    return KeyedSubtree(key: backChevronKey, child: const _BackChevron());
  }

  /// This widget is not decorated with a font since the font style could
  /// animate during transitions.
  final KeyedSubtree? backLabel;
  static KeyedSubtree? createBackLabel({
    required GlobalKey backLabelKey,
    required Widget? userLeading,
    required ModalRoute<dynamic>? route,
    required bool automaticallyImplyLeading,
    required String? previousPageTitle,
  }) {
    if (userLeading != null ||
        !automaticallyImplyLeading ||
        route == null ||
        !route.canPop ||
        (route is PageRoute && route.fullscreenDialog)) {
      return null;
    }

    return KeyedSubtree(
      key: backLabelKey,
      child: _BackLabel(
        specifiedPreviousTitle: previousPageTitle,
        route: route,
      ),
    );
  }

  /// This widget is not decorated with a font since the font style could
  /// animate during transitions.
  final KeyedSubtree? middle;
  static KeyedSubtree? createMiddle({
    required GlobalKey middleKey,
    required Widget? userMiddle,
    required Widget? userLargeTitle,
    required bool large,
    required bool automaticallyImplyTitle,
    required ModalRoute<dynamic>? route,
  }) {
    Widget? middleContent = userMiddle;

    if (large) {
      middleContent ??= userLargeTitle;
    }

    middleContent ??= _derivedTitle(
      automaticallyImplyTitle: automaticallyImplyTitle,
      currentRoute: route,
    );

    if (middleContent == null) {
      return null;
    }

    return KeyedSubtree(key: middleKey, child: middleContent);
  }

  final KeyedSubtree? trailing;
  static KeyedSubtree? createTrailing({
    required GlobalKey trailingKey,
    required Widget? userTrailing,
    required EdgeInsetsDirectional? padding,
  }) {
    if (userTrailing == null) {
      return null;
    }

    return KeyedSubtree(
      key: trailingKey,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          end: padding?.end ?? _kNavBarEdgePadding,
        ),
        child: IconTheme.merge(
          data: const IconThemeData(size: 32.0),
          child: userTrailing,
        ),
      ),
    );
  }

  /// This widget is not decorated with a font since the font style could
  /// animate during transitions.
  final KeyedSubtree? largeTitle;
  static KeyedSubtree? createLargeTitle({
    required GlobalKey largeTitleKey,
    required Widget? userLargeTitle,
    required bool large,
    required bool automaticImplyTitle,
    required ModalRoute<dynamic>? route,
  }) {
    if (!large) {
      return null;
    }

    final Widget? largeTitleContent =
        userLargeTitle ??
        _derivedTitle(
          automaticallyImplyTitle: automaticImplyTitle,
          currentRoute: route,
        );

    assert(
      largeTitleContent != null,
      'largeTitle was not provided and there was no title from the route.',
    );

    return KeyedSubtree(key: largeTitleKey, child: largeTitleContent!);
  }
}

/// A nav bar back button typically used in [MyCupertinoNavigationBar].
///
/// This is automatically inserted into [MyCupertinoNavigationBar] and
/// [CupertinoSliverNavigationBar]'s `leading` slot when
/// `automaticallyImplyLeading` is true.
///
/// When manually inserted, the [CupertinoNavigationBarBackButton] should only
/// be used in routes that can be popped unless a custom [onPressed] is
/// provided.
///
/// Shows a back chevron and the previous route's title when available from
/// the previous [CupertinoPageRoute.title]. If [previousPageTitle] is specified,
/// it will be shown instead.
class CupertinoNavigationBarBackButton extends StatelessWidget {
  /// Construct a [CupertinoNavigationBarBackButton] that can be used to pop
  /// the current route.
  ///
  /// The [color] parameter must not be null.
  const CupertinoNavigationBarBackButton({
    super.key,
    this.color,
    this.previousPageTitle,
    this.onPressed,
  }) : _backChevron = null,
       _backLabel = null;

  // Allow the back chevron and label to be separately created (and keyed)
  // because they animate separately during page transitions.
  const CupertinoNavigationBarBackButton._assemble(
    this._backChevron,
    this._backLabel,
  ) : previousPageTitle = null,
      color = null,
      onPressed = null;

  /// The [Color] of the back button.
  ///
  /// Can be used to override the color of the back button chevron and label.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryColor` if null.
  final Color? color;

  /// An override for showing the previous route's title. If null, it will be
  /// automatically derived from [CupertinoPageRoute.title] if the current and
  /// previous routes are both [CupertinoPageRoute]s.
  final String? previousPageTitle;

  /// An override callback to perform instead of the default behavior which is
  /// to pop the [Navigator].
  ///
  /// It can, for instance, be used to pop the platform's navigation stack
  /// via [SystemNavigator] instead of Flutter's [Navigator] in add-to-app
  /// situations.
  ///
  /// Defaults to null.
  final VoidCallback? onPressed;

  final Widget? _backChevron;

  final Widget? _backLabel;

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? currentRoute = ModalRoute.of(context);
    if (onPressed == null) {
      assert(
        currentRoute?.canPop ?? false,
        'CupertinoNavigationBarBackButton should only be used in routes that can be popped',
      );
    }

    TextStyle actionTextStyle =
        CupertinoTheme.of(context).textTheme.navActionTextStyle;
    if (color != null) {
      actionTextStyle = actionTextStyle.copyWith(
        color: CupertinoDynamicColor.maybeResolve(color, context),
      );
    }

    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Semantics(
        container: true,
        excludeSemantics: true,
        label: 'Back',
        button: true,
        child: DefaultTextStyle(
          style: actionTextStyle,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: _kNavBarBackButtonTapWidth,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(padding: EdgeInsetsDirectional.only(start: 8.0)),
                _backChevron ?? const _BackChevron(),
                const Padding(padding: EdgeInsetsDirectional.only(start: 6.0)),
                Flexible(
                  child:
                      _backLabel ??
                      _BackLabel(
                        specifiedPreviousTitle: previousPageTitle,
                        route: currentRoute,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}

class _BackChevron extends StatelessWidget {
  const _BackChevron();

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);
    final TextStyle textStyle = DefaultTextStyle.of(context).style;

    // Replicate the Icon logic here to get a tightly sized icon and add
    // custom non-square padding.
    Widget iconWidget = Padding(
      padding: const EdgeInsetsDirectional.only(start: 6, end: 2),
      child: Text.rich(
        TextSpan(
          text: String.fromCharCode(CupertinoIcons.back.codePoint),
          style: TextStyle(
            inherit: false,
            color: textStyle.color,
            fontSize: 30.0,
            fontFamily: CupertinoIcons.back.fontFamily,
            package: CupertinoIcons.back.fontPackage,
          ),
        ),
      ),
    );
    switch (textDirection) {
      case TextDirection.rtl:
        iconWidget = Transform(
          transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
          alignment: Alignment.center,
          transformHitTests: false,
          child: iconWidget,
        );
        break;
      case TextDirection.ltr:
        break;
    }

    return iconWidget;
  }
}

/// A widget that shows next to the back chevron when `automaticallyImplyLeading`
/// is true.
class _BackLabel extends StatelessWidget {
  const _BackLabel({required this.specifiedPreviousTitle, required this.route});

  final String? specifiedPreviousTitle;
  final ModalRoute<dynamic>? route;

  // `child` is never passed in into ValueListenableBuilder so it's always
  // null here and unused.
  Widget _buildPreviousTitleWidget(
    BuildContext context,
    String? previousTitle,
    Widget? child,
  ) {
    if (previousTitle == null) {
      return const SizedBox(height: 0.0, width: 0.0);
    }

    Text textWidget = Text(
      previousTitle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    if (previousTitle.length > 12) {
      textWidget = const Text('Back');
    }

    return Align(
      alignment: AlignmentDirectional.centerStart,
      widthFactor: 1.0,
      child: textWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (specifiedPreviousTitle != null) {
      return _buildPreviousTitleWidget(context, specifiedPreviousTitle, null);
    } else if (route is CupertinoRouteTransitionMixin<dynamic> &&
        !route!.isFirst) {
      final CupertinoRouteTransitionMixin<dynamic> cupertinoRoute =
          route! as CupertinoRouteTransitionMixin<dynamic>;
      // There is no timing issue because the previousTitle Listenable changes
      // happen during route modifications before the ValueListenableBuilder
      // is built.
      return ValueListenableBuilder<String?>(
        valueListenable: cupertinoRoute.previousTitle,
        builder: _buildPreviousTitleWidget,
      );
    } else {
      return const SizedBox(height: 0.0, width: 0.0);
    }
  }
}

/// This should always be the first child of Hero widgets.
///
/// This class helps each Hero transition obtain the start or end navigation
/// bar's box size and the inner components of the navigation bar that will
/// move around.
///
/// It should be wrapped around the biggest [RenderBox] of the static
/// navigation bar in each route.
class _TransitionableNavigationBar extends StatelessWidget {
  _TransitionableNavigationBar({
    required this.componentsKeys,
    required this.backgroundColor,
    required this.backButtonTextStyle,
    required this.titleTextStyle,
    required this.largeTitleTextStyle,
    required this.border,
    required this.hasUserMiddle,
    required this.largeExpanded,
    required this.child,
    this.decoration,
  }) : assert(componentsKeys != null),
       assert(largeExpanded != null),
       assert(!largeExpanded || largeTitleTextStyle != null),
       super(key: componentsKeys.navBarBoxKey);

  final _NavigationBarStaticComponentsKeys componentsKeys;
  final Color? backgroundColor;
  final TextStyle backButtonTextStyle;
  final TextStyle titleTextStyle;
  final TextStyle? largeTitleTextStyle;
  final Border? border;
  final Decoration? decoration;
  final bool hasUserMiddle;
  final bool largeExpanded;
  final Widget child;

  RenderBox get renderBox {
    final RenderBox box =
        componentsKeys.navBarBoxKey.currentContext!.findRenderObject()!
            as RenderBox;
    assert(
      box.attached,
      '_TransitionableNavigationBar.renderBox should be called when building '
      'hero flight shuttles when the from and the to nav bar boxes are already '
      'laid out and painted.',
    );
    return box;
  }

  @override
  Widget build(BuildContext context) {
    assert(() {
      bool inHero = false;
      context.visitAncestorElements((Element ancestor) {
        if (ancestor is ComponentElement) {
          assert(
            ancestor.widget.runtimeType != _NavigationBarTransition,
            '_TransitionableNavigationBar should never re-appear inside '
            '_NavigationBarTransition. Keyed _TransitionableNavigationBar should '
            'only serve as anchor points in routes rather than appearing inside '
            'Hero flights themselves.',
          );
          if (ancestor.widget.runtimeType == Hero) {
            inHero = true;
          }
        }
        return true;
      });
      assert(
        inHero,
        '_TransitionableNavigationBar should only be added as the immediate '
        'child of Hero widgets.',
      );
      return true;
    }());
    return child;
  }
}

/// This class represents the widget that will be in the Hero flight instead of
/// the 2 static navigation bars by taking inner components from both.
///
/// The `topNavBar` parameter is the nav bar that was on top regardless of
/// push/pop direction.
///
/// Similarly, the `bottomNavBar` parameter is the nav bar that was at the
/// bottom regardless of the push/pop direction.
///
/// If [MediaQuery.padding] is still present in this widget's [BuildContext],
/// that padding will become part of the transitional navigation bar as well.
///
/// [MediaQuery.padding] should be consistent between the from/to routes and
/// the Hero overlay. Inconsistent [MediaQuery.padding] will produce undetermined
/// results.
class _NavigationBarTransition extends StatelessWidget {
  _NavigationBarTransition({
    required this.animation,
    required this.topNavBar,
    required this.bottomNavBar,
  }) : heightTween = Tween<double>(
         begin: bottomNavBar.renderBox.size.height,
         end: topNavBar.renderBox.size.height,
       ),
       backgroundTween = ColorTween(
         begin: bottomNavBar.backgroundColor,
         end: topNavBar.backgroundColor,
       ),
       borderTween = BorderTween(
         begin: bottomNavBar.border,
         end: topNavBar.border,
       );

  final Animation<double> animation;
  final _TransitionableNavigationBar topNavBar;
  final _TransitionableNavigationBar bottomNavBar;

  final Tween<double> heightTween;
  final ColorTween backgroundTween;
  final BorderTween borderTween;

  @override
  Widget build(BuildContext context) {
    final _NavigationBarComponentsTransition componentsTransition =
        _NavigationBarComponentsTransition(
          animation: animation,
          bottomNavBar: bottomNavBar,
          topNavBar: topNavBar,
          directionality: Directionality.of(context),
        );

    final List<Widget> children = <Widget>[
      // Draw an empty navigation bar box with changing shape behind all the
      // moving components without any components inside it itself.
      AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return _wrapWithBackground(
            // Don't update the system status bar color mid-flight.
            updateSystemUiOverlay: false,
            backgroundColor: backgroundTween.evaluate(animation)!,
            border: borderTween.evaluate(animation),
            child: SizedBox(
              height: heightTween.evaluate(animation),
              width: double.infinity,
            ),
          );
        },
      ),
      // Draw all the components on top of the empty bar box.
      if (componentsTransition.bottomBackChevron != null)
        componentsTransition.bottomBackChevron!,
      if (componentsTransition.bottomBackLabel != null)
        componentsTransition.bottomBackLabel!,
      if (componentsTransition.bottomLeading != null)
        componentsTransition.bottomLeading!,
      if (componentsTransition.bottomMiddle != null)
        componentsTransition.bottomMiddle!,
      if (componentsTransition.bottomLargeTitle != null)
        componentsTransition.bottomLargeTitle!,
      if (componentsTransition.bottomTrailing != null)
        componentsTransition.bottomTrailing!,
      // Draw top components on top of the bottom components.
      if (componentsTransition.topLeading != null)
        componentsTransition.topLeading!,
      if (componentsTransition.topBackChevron != null)
        componentsTransition.topBackChevron!,
      if (componentsTransition.topBackLabel != null)
        componentsTransition.topBackLabel!,
      if (componentsTransition.topMiddle != null)
        componentsTransition.topMiddle!,
      if (componentsTransition.topLargeTitle != null)
        componentsTransition.topLargeTitle!,
      if (componentsTransition.topTrailing != null)
        componentsTransition.topTrailing!,
    ];

    // The actual outer box is big enough to contain both the bottom and top
    // navigation bars. It's not a direct Rect lerp because some components
    // can actually be outside the linearly lerp'ed Rect in the middle of
    // the animation, such as the topLargeTitle.
    return Container(
      height:
          math.max(heightTween.begin!, heightTween.end!) +
          MediaQuery.of(context).padding.top,
      width: double.infinity,
      decoration: componentsTransition.decoration,
      child: Stack(children: children),
    );
  }
}

/// This class helps create widgets that are in transition based on static
/// components from the bottom and top navigation bars.
///
/// It animates these transitional components both in terms of position and
/// their appearance.
///
/// Instead of running the transitional components through their normal static
/// navigation bar layout logic, this creates transitional widgets that are based
/// on these widgets' existing render objects' layout and position.
///
/// This is possible because this widget is only used during Hero transitions
/// where both the from and to routes are already built and laid out.
///
/// The components' existing layout constraints and positions are then
/// replicated using [Positioned] or [PositionedTransition] wrappers.
///
/// This class should never return [KeyedSubtree]s created by
/// _NavigationBarStaticComponents directly. Since widgets from
/// _NavigationBarStaticComponents are still present in the widget tree during the
/// hero transitions, it would cause global key duplications. Instead, return
/// only the [KeyedSubtree]s' child.
@immutable
class _NavigationBarComponentsTransition {
  _NavigationBarComponentsTransition({
    required this.animation,
    required _TransitionableNavigationBar bottomNavBar,
    required _TransitionableNavigationBar topNavBar,
    required TextDirection directionality,
  }) : bottomComponents = bottomNavBar.componentsKeys,
       topComponents = topNavBar.componentsKeys,
       bottomNavBarBox = bottomNavBar.renderBox,
       topNavBarBox = topNavBar.renderBox,
       bottomBackButtonTextStyle = bottomNavBar.backButtonTextStyle,
       topBackButtonTextStyle = topNavBar.backButtonTextStyle,
       bottomTitleTextStyle = bottomNavBar.titleTextStyle,
       topTitleTextStyle = topNavBar.titleTextStyle,
       bottomLargeTitleTextStyle = bottomNavBar.largeTitleTextStyle,
       topLargeTitleTextStyle = topNavBar.largeTitleTextStyle,
       bottomHasUserMiddle = bottomNavBar.hasUserMiddle,
       topHasUserMiddle = topNavBar.hasUserMiddle,
       bottomLargeExpanded = bottomNavBar.largeExpanded,
       decoration = bottomNavBar.decoration,
       topLargeExpanded = topNavBar.largeExpanded,
       transitionBox =
       // paintBounds are based on offset zero so it's ok to expand the Rects.
       bottomNavBar.renderBox.paintBounds.expandToInclude(
         topNavBar.renderBox.paintBounds,
       ),
       forwardDirection = directionality == TextDirection.ltr ? 1.0 : -1.0;

  static final Animatable<double> fadeOut = Tween<double>(begin: 1.0, end: 0.0);
  static final Animatable<double> fadeIn = Tween<double>(begin: 0.0, end: 1.0);

  final Animation<double> animation;
  final _NavigationBarStaticComponentsKeys bottomComponents;
  final _NavigationBarStaticComponentsKeys topComponents;

  // These render boxes that are the ancestors of all the bottom and top
  // components are used to determine the components' relative positions inside
  // their respective navigation bars.
  final RenderBox bottomNavBarBox;
  final RenderBox topNavBarBox;

  final TextStyle bottomBackButtonTextStyle;
  final TextStyle topBackButtonTextStyle;
  final TextStyle bottomTitleTextStyle;
  final TextStyle topTitleTextStyle;
  final TextStyle? bottomLargeTitleTextStyle;
  final TextStyle? topLargeTitleTextStyle;

  final bool bottomHasUserMiddle;
  final bool topHasUserMiddle;
  final bool bottomLargeExpanded;
  final Decoration? decoration;
  final bool topLargeExpanded;

  // This is the outer box in which all the components will be fitted. The
  // sizing component of RelativeRects will be based on this rect's size.
  final Rect transitionBox;

  // x-axis unity number representing the direction of growth for text.
  final double forwardDirection;

  // Take a widget it its original ancestor navigation bar render box and
  // translate it into a RelativeBox in the transition navigation bar box.
  RelativeRect positionInTransitionBox(
    GlobalKey key, {
    required RenderBox from,
  }) {
    final RenderBox componentBox =
        key.currentContext!.findRenderObject()! as RenderBox;
    assert(componentBox.attached);

    return RelativeRect.fromRect(
      componentBox.localToGlobal(Offset.zero, ancestor: from) &
          componentBox.size,
      transitionBox,
    );
  }

  // Create an animated widget that moves the given child widget between its
  // original position in its ancestor navigation bar to another widget's
  // position in that widget's navigation bar.
  //
  // Anchor their positions based on the vertical middle of their respective
  // render boxes' leading edge.
  //
  // This method assumes there's no other transforms other than translations
  // when converting a rect from the original navigation bar's coordinate space
  // to the other navigation bar's coordinate space, to avoid performing
  // floating point operations on the size of the child widget, so that the
  // incoming constraints used for sizing the child widget will be exactly the
  // same.
  _FixedSizeSlidingTransition slideFromLeadingEdge({
    required GlobalKey fromKey,
    required RenderBox fromNavBarBox,
    required GlobalKey toKey,
    required RenderBox toNavBarBox,
    required Widget child,
  }) {
    final RenderBox fromBox =
        fromKey.currentContext!.findRenderObject()! as RenderBox;
    final RenderBox toBox =
        toKey.currentContext!.findRenderObject()! as RenderBox;

    final bool isLTR = forwardDirection > 0;

    // The animation moves the fromBox so its anchor (left-center or right-center
    // depending on the writing direction) aligns with toBox's anchor.
    final Offset fromAnchorLocal = Offset(
      isLTR ? 0 : fromBox.size.width,
      fromBox.size.height / 2,
    );
    final Offset toAnchorLocal = Offset(
      isLTR ? 0 : toBox.size.width,
      toBox.size.height / 2,
    );
    final Offset fromAnchorInFromBox = fromBox.localToGlobal(
      fromAnchorLocal,
      ancestor: fromNavBarBox,
    );
    final Offset toAnchorInToBox = toBox.localToGlobal(
      toAnchorLocal,
      ancestor: toNavBarBox,
    );

    // We can't get ahold of the render box of the stack (i.e., `transitionBox`)
    // we place components on yet, but we know the stack needs to be top-leading
    // aligned with both fromNavBarBox and toNavBarBox to make the transition
    // look smooth. Also use the top-leading point as the origin for ease of
    // calculation.

    // The offset to move fromAnchor to toAnchor, in transitionBox's top-leading
    // coordinates.
    final Offset translation =
        isLTR
            ? toAnchorInToBox - fromAnchorInFromBox
            : Offset(
                  toNavBarBox.size.width - toAnchorInToBox.dx,
                  toAnchorInToBox.dy,
                ) -
                Offset(
                  fromNavBarBox.size.width - fromAnchorInFromBox.dx,
                  fromAnchorInFromBox.dy,
                );

    final RelativeRect fromBoxMargin = positionInTransitionBox(
      fromKey,
      from: fromNavBarBox,
    );
    final Offset fromOriginInTransitionBox = Offset(
      isLTR ? fromBoxMargin.left : fromBoxMargin.right,
      fromBoxMargin.top,
    );

    final Tween<Offset> anchorMovementInTransitionBox = Tween<Offset>(
      begin: fromOriginInTransitionBox,
      end: fromOriginInTransitionBox + translation,
    );

    return _FixedSizeSlidingTransition(
      isLTR: isLTR,
      offsetAnimation: animation.drive(anchorMovementInTransitionBox),
      size: fromBox.size,
      child: child,
    );
  }

  Animation<double> fadeInFrom(double t, {Curve curve = Curves.easeIn}) {
    return animation.drive(
      fadeIn.chain(CurveTween(curve: Interval(t, 1.0, curve: curve))),
    );
  }

  Animation<double> fadeOutBy(double t, {Curve curve = Curves.easeOut}) {
    return animation.drive(
      fadeOut.chain(CurveTween(curve: Interval(0.0, t, curve: curve))),
    );
  }

  Widget? get bottomLeading {
    final KeyedSubtree? bottomLeading =
        bottomComponents.leadingKey.currentWidget as KeyedSubtree?;

    if (bottomLeading == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(
        bottomComponents.leadingKey,
        from: bottomNavBarBox,
      ),
      child: FadeTransition(
        opacity: fadeOutBy(0.4),
        child: bottomLeading.child,
      ),
    );
  }

  Widget? get bottomBackChevron {
    final KeyedSubtree? bottomBackChevron =
        bottomComponents.backChevronKey.currentWidget as KeyedSubtree?;

    if (bottomBackChevron == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(
        bottomComponents.backChevronKey,
        from: bottomNavBarBox,
      ),
      child: FadeTransition(
        opacity: fadeOutBy(0.6),
        child: DefaultTextStyle(
          style: bottomBackButtonTextStyle,
          child: bottomBackChevron.child,
        ),
      ),
    );
  }

  Widget? get bottomBackLabel {
    final KeyedSubtree? bottomBackLabel =
        bottomComponents.backLabelKey.currentWidget as KeyedSubtree?;

    if (bottomBackLabel == null) {
      return null;
    }

    final RelativeRect from = positionInTransitionBox(
      bottomComponents.backLabelKey,
      from: bottomNavBarBox,
    );

    // Transition away by sliding horizontally to the leading edge off of the screen.
    final RelativeRectTween positionTween = RelativeRectTween(
      begin: from,
      end: from.shift(
        Offset(forwardDirection * (-bottomNavBarBox.size.width / 2.0), 0.0),
      ),
    );

    return PositionedTransition(
      rect: animation.drive(positionTween),
      child: FadeTransition(
        opacity: fadeOutBy(0.2),
        child: DefaultTextStyle(
          style: bottomBackButtonTextStyle,
          child: bottomBackLabel.child,
        ),
      ),
    );
  }

  Widget? get bottomMiddle {
    final KeyedSubtree? bottomMiddle =
        bottomComponents.middleKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? topBackLabel =
        topComponents.backLabelKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? topLeading =
        topComponents.leadingKey.currentWidget as KeyedSubtree?;

    // The middle component is non-null when the nav bar is a large title
    // nav bar but would be invisible when expanded, therefore don't show it here.
    if (!bottomHasUserMiddle && bottomLargeExpanded) {
      return null;
    }

    if (bottomMiddle != null && topBackLabel != null) {
      // Move from current position to the top page's back label position.
      return slideFromLeadingEdge(
        fromKey: bottomComponents.middleKey,
        fromNavBarBox: bottomNavBarBox,
        toKey: topComponents.backLabelKey,
        toNavBarBox: topNavBarBox,
        child: FadeTransition(
          // A custom middle widget like a segmented control fades away faster.
          opacity: fadeOutBy(bottomHasUserMiddle ? 0.4 : 0.7),
          child: Align(
            // As the text shrinks, make sure it's still anchored to the leading
            // edge of a constantly sized outer box.
            alignment: AlignmentDirectional.centerStart,
            child: DefaultTextStyleTransition(
              style: animation.drive(
                TextStyleTween(
                  begin: bottomTitleTextStyle,
                  end: topBackButtonTextStyle,
                ),
              ),
              child: bottomMiddle.child,
            ),
          ),
        ),
      );
    }

    // When the top page has a leading widget override (one of the few ways to
    // not have a top back label), don't move the bottom middle widget and just
    // fade.
    if (bottomMiddle != null && topLeading != null) {
      return Positioned.fromRelativeRect(
        rect: positionInTransitionBox(
          bottomComponents.middleKey,
          from: bottomNavBarBox,
        ),
        child: FadeTransition(
          opacity: fadeOutBy(bottomHasUserMiddle ? 0.4 : 0.7),
          // Keep the font when transitioning into a non-back label leading.
          child: DefaultTextStyle(
            style: bottomTitleTextStyle,
            child: bottomMiddle.child,
          ),
        ),
      );
    }

    return null;
  }

  Widget? get bottomLargeTitle {
    final KeyedSubtree? bottomLargeTitle =
        bottomComponents.largeTitleKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? topBackLabel =
        topComponents.backLabelKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? topLeading =
        topComponents.leadingKey.currentWidget as KeyedSubtree?;

    if (bottomLargeTitle == null || !bottomLargeExpanded) {
      return null;
    }

    if (bottomLargeTitle != null && topBackLabel != null) {
      // Move from current position to the top page's back label position.
      return slideFromLeadingEdge(
        fromKey: bottomComponents.largeTitleKey,
        fromNavBarBox: bottomNavBarBox,
        toKey: topComponents.backLabelKey,
        toNavBarBox: topNavBarBox,
        child: FadeTransition(
          opacity: fadeOutBy(0.6),
          child: Align(
            // As the text shrinks, make sure it's still anchored to the leading
            // edge of a constantly sized outer box.
            alignment: AlignmentDirectional.centerStart,
            child: DefaultTextStyleTransition(
              style: animation.drive(
                TextStyleTween(
                  begin: bottomLargeTitleTextStyle,
                  end: topBackButtonTextStyle,
                ),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: bottomLargeTitle.child,
            ),
          ),
        ),
      );
    }

    if (bottomLargeTitle != null && topLeading != null) {
      // Unlike bottom middle, the bottom large title moves when it can't
      // transition to the top back label position.
      final RelativeRect from = positionInTransitionBox(
        bottomComponents.largeTitleKey,
        from: bottomNavBarBox,
      );

      final RelativeRectTween positionTween = RelativeRectTween(
        begin: from,
        end: from.shift(
          Offset(forwardDirection * bottomNavBarBox.size.width / 4.0, 0.0),
        ),
      );

      // Just shift slightly towards the trailing edge instead of moving to the
      // back label position.
      return PositionedTransition(
        rect: animation.drive(positionTween),
        child: FadeTransition(
          opacity: fadeOutBy(0.4),
          // Keep the font when transitioning into a non-back-label leading.
          child: DefaultTextStyle(
            style: bottomLargeTitleTextStyle!,
            child: bottomLargeTitle.child,
          ),
        ),
      );
    }

    return null;
  }

  Widget? get bottomTrailing {
    final KeyedSubtree? bottomTrailing =
        bottomComponents.trailingKey.currentWidget as KeyedSubtree?;

    if (bottomTrailing == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(
        bottomComponents.trailingKey,
        from: bottomNavBarBox,
      ),
      child: FadeTransition(
        opacity: fadeOutBy(0.6),
        child: bottomTrailing.child,
      ),
    );
  }

  Widget? get topLeading {
    final KeyedSubtree? topLeading =
        topComponents.leadingKey.currentWidget as KeyedSubtree?;

    if (topLeading == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(
        topComponents.leadingKey,
        from: topNavBarBox,
      ),
      child: FadeTransition(opacity: fadeInFrom(0.6), child: topLeading.child),
    );
  }

  Widget? get topBackChevron {
    final KeyedSubtree? topBackChevron =
        topComponents.backChevronKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? bottomBackChevron =
        bottomComponents.backChevronKey.currentWidget as KeyedSubtree?;

    if (topBackChevron == null) {
      return null;
    }

    final RelativeRect to = positionInTransitionBox(
      topComponents.backChevronKey,
      from: topNavBarBox,
    );
    RelativeRect from = to;

    // If it's the first page with a back chevron, shift in slightly from the
    // right.
    if (bottomBackChevron == null) {
      final RenderBox topBackChevronBox =
          topComponents.backChevronKey.currentContext!.findRenderObject()!
              as RenderBox;
      from = to.shift(
        Offset(forwardDirection * topBackChevronBox.size.width * 2.0, 0.0),
      );
    }

    final RelativeRectTween positionTween = RelativeRectTween(
      begin: from,
      end: to,
    );

    return PositionedTransition(
      rect: animation.drive(positionTween),
      child: FadeTransition(
        opacity: fadeInFrom(bottomBackChevron == null ? 0.7 : 0.4),
        child: DefaultTextStyle(
          style: topBackButtonTextStyle,
          child: topBackChevron.child,
        ),
      ),
    );
  }

  Widget? get topBackLabel {
    final KeyedSubtree? bottomMiddle =
        bottomComponents.middleKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? bottomLargeTitle =
        bottomComponents.largeTitleKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? topBackLabel =
        topComponents.backLabelKey.currentWidget as KeyedSubtree?;

    if (topBackLabel == null) {
      return null;
    }

    final RenderAnimatedOpacity? topBackLabelOpacity =
        topComponents.backLabelKey.currentContext
            ?.findAncestorRenderObjectOfType<RenderAnimatedOpacity>();

    Animation<double>? midClickOpacity;
    if (topBackLabelOpacity != null &&
        topBackLabelOpacity.opacity.value < 1.0) {
      midClickOpacity = animation.drive(
        Tween<double>(begin: 0.0, end: topBackLabelOpacity.opacity.value),
      );
    }

    // Pick up from an incoming transition from the large title. This is
    // duplicated here from the bottomLargeTitle transition widget because the
    // content text might be different. For instance, if the bottomLargeTitle
    // text is too long, the topBackLabel will say 'Back' instead of the original
    // text.
    if (bottomLargeTitle != null &&
        topBackLabel != null &&
        bottomLargeExpanded) {
      return slideFromLeadingEdge(
        fromKey: bottomComponents.largeTitleKey,
        fromNavBarBox: bottomNavBarBox,
        toKey: topComponents.backLabelKey,
        toNavBarBox: topNavBarBox,
        child: FadeTransition(
          opacity: midClickOpacity ?? fadeInFrom(0.4),
          child: DefaultTextStyleTransition(
            style: animation.drive(
              TextStyleTween(
                begin: bottomLargeTitleTextStyle,
                end: topBackButtonTextStyle,
              ),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            child: topBackLabel.child,
          ),
        ),
      );
    }

    // The topBackLabel always comes from the large title first if available
    // and expanded instead of middle.
    if (bottomMiddle != null && topBackLabel != null) {
      return slideFromLeadingEdge(
        fromKey: bottomComponents.middleKey,
        fromNavBarBox: bottomNavBarBox,
        toKey: topComponents.backLabelKey,
        toNavBarBox: topNavBarBox,
        child: FadeTransition(
          opacity: midClickOpacity ?? fadeInFrom(0.3),
          child: DefaultTextStyleTransition(
            style: animation.drive(
              TextStyleTween(
                begin: bottomTitleTextStyle,
                end: topBackButtonTextStyle,
              ),
            ),
            child: topBackLabel.child,
          ),
        ),
      );
    }

    return null;
  }

  Widget? get topMiddle {
    final KeyedSubtree? topMiddle =
        topComponents.middleKey.currentWidget as KeyedSubtree?;

    if (topMiddle == null) {
      return null;
    }

    // The middle component is non-null when the nav bar is a large title
    // nav bar but would be invisible when expanded, therefore don't show it here.
    if (!topHasUserMiddle && topLargeExpanded) {
      return null;
    }

    final RelativeRect to = positionInTransitionBox(
      topComponents.middleKey,
      from: topNavBarBox,
    );
    final RenderBox toBox =
        topComponents.middleKey.currentContext!.findRenderObject()!
            as RenderBox;

    final bool isLTR = forwardDirection > 0;

    // Anchor is the top-leading point of toBox, in transition box's top-leading
    // coordinate space.
    final Offset toAnchorInTransitionBox = Offset(
      isLTR ? to.left : to.right,
      to.top,
    );

    // Shift in from the trailing edge of the screen.
    final Tween<Offset> anchorMovementInTransitionBox = Tween<Offset>(
      begin: Offset(
        // the "width / 2" here makes the middle widget's horizontal center on
        // the trailing edge of the top nav bar.
        topNavBarBox.size.width - toBox.size.width / 2,
        to.top,
      ),
      end: toAnchorInTransitionBox,
    );

    return _FixedSizeSlidingTransition(
      isLTR: isLTR,
      offsetAnimation: animation.drive(anchorMovementInTransitionBox),
      size: toBox.size,
      child: FadeTransition(
        opacity: fadeInFrom(0.25),
        child: DefaultTextStyle(
          style: topTitleTextStyle,
          child: topMiddle.child,
        ),
      ),
    );
  }

  Widget? get topTrailing {
    final KeyedSubtree? topTrailing =
        topComponents.trailingKey.currentWidget as KeyedSubtree?;

    if (topTrailing == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(
        topComponents.trailingKey,
        from: topNavBarBox,
      ),
      child: FadeTransition(opacity: fadeInFrom(0.4), child: topTrailing.child),
    );
  }

  Widget? get topLargeTitle {
    final KeyedSubtree? topLargeTitle =
        topComponents.largeTitleKey.currentWidget as KeyedSubtree?;

    if (topLargeTitle == null || !topLargeExpanded) {
      return null;
    }

    final RelativeRect to = positionInTransitionBox(
      topComponents.largeTitleKey,
      from: topNavBarBox,
    );

    // Shift in from the trailing edge of the screen.
    final RelativeRectTween positionTween = RelativeRectTween(
      begin: to.shift(Offset(forwardDirection * topNavBarBox.size.width, 0.0)),
      end: to,
    );

    return PositionedTransition(
      rect: animation.drive(positionTween),
      child: FadeTransition(
        opacity: fadeInFrom(0.3),
        child: DefaultTextStyle(
          style: topLargeTitleTextStyle!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          child: topLargeTitle.child,
        ),
      ),
    );
  }
}

/// Navigation bars' hero rect tween that will move between the static bars
/// but keep a constant size that's the bigger of both navigation bars.
RectTween _linearTranslateWithLargestRectSizeTween(Rect? begin, Rect? end) {
  final Size largestSize = Size(
    math.max(begin!.size.width, end!.size.width),
    math.max(begin.size.height, end.size.height),
  );
  return RectTween(
    begin: begin.topLeft & largestSize,
    end: end.topLeft & largestSize,
  );
}

Widget _navBarHeroLaunchPadBuilder(
  BuildContext context,
  Size heroSize,
  Widget child,
) {
  assert(child is _TransitionableNavigationBar);
  // Tree reshaping is fine here because the Heroes' child is always a
  // _TransitionableNavigationBar which has a GlobalKey.

  // Keeping the Hero subtree here is needed (instead of just swapping out the
  // anchor nav bars for fixed size boxes during flights) because the nav bar
  // and their specific component children may serve as anchor points again if
  // another mid-transition flight diversion is triggered.

  // This is ok performance-wise because static nav bars are generally cheap to
  // build and layout but expensive to GPU render (due to clips and blurs) which
  // we're skipping here.
  return Visibility(
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    visible: false,
    child: child,
  );
}

/// Navigation bars' hero flight shuttle builder.
Widget _navBarHeroFlightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  assert(animation != null);
  assert(flightDirection != null);
  assert(fromHeroContext != null);
  assert(toHeroContext != null);
  assert(fromHeroContext.widget is Hero);
  assert(toHeroContext.widget is Hero);

  final Hero fromHeroWidget = fromHeroContext.widget as Hero;
  final Hero toHeroWidget = toHeroContext.widget as Hero;

  assert(fromHeroWidget.child is _TransitionableNavigationBar);
  assert(toHeroWidget.child is _TransitionableNavigationBar);

  final _TransitionableNavigationBar fromNavBar =
      fromHeroWidget.child as _TransitionableNavigationBar;
  final _TransitionableNavigationBar toNavBar =
      toHeroWidget.child as _TransitionableNavigationBar;

  assert(fromNavBar.componentsKeys != null);
  assert(toNavBar.componentsKeys != null);

  assert(
    fromNavBar.componentsKeys.navBarBoxKey.currentContext!.owner != null,
    'The from nav bar to Hero must have been mounted in the previous frame',
  );
  assert(
    toNavBar.componentsKeys.navBarBoxKey.currentContext!.owner != null,
    'The to nav bar to Hero must have been mounted in the previous frame',
  );

  switch (flightDirection) {
    case HeroFlightDirection.push:
      return _NavigationBarTransition(
        animation: animation,
        bottomNavBar: fromNavBar,
        topNavBar: toNavBar,
      );
    case HeroFlightDirection.pop:
      return _NavigationBarTransition(
        animation: animation,
        bottomNavBar: toNavBar,
        topNavBar: fromNavBar,
      );
  }
}
