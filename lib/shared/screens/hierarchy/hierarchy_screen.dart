import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/models/hierarchy_model.dart';
import 'package:hrms_yb/shared/screens/hierarchy/hierarchy_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

// =============================================================================
// HierarchyScreen
// =============================================================================
class HierarchyScreen extends StatelessWidget {
  const HierarchyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HierarchyProvider(context: context),
      child: Consumer<HierarchyProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: CommonWidget.backButton(onTap: () => context.pop()),
              title: const Text("Organization Hierarchy"),
            ),
            body: _buildBody(context: context, provider: provider),
          );
        },
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required HierarchyProvider provider,
  }) {
    if (provider.isLoading) {
      return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: CommonWidget.defaultLoader(),
      );
    }
    if (provider.hierarchy.isEmpty) {
      return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: const Center(child: Text("No hierarchy found")),
      );
    }

    return SizedBox.expand(
      child: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: provider.hierarchy
                  .map((item) => HierarchyTreeNode(node: item))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// HierarchyTreeNode  –  recursive, collapsible tree card
// =============================================================================
class HierarchyTreeNode extends StatefulWidget {
  final HierarchyModel node;

  const HierarchyTreeNode({super.key, required this.node});

  @override
  State<HierarchyTreeNode> createState() => _HierarchyTreeNodeState();
}

class _HierarchyTreeNodeState extends State<HierarchyTreeNode> {
  bool _expanded = false;

  bool get _hasChildren => widget.node.children.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── CARD ─────────────────────────────────────────────────────────
        _NodeCard(
          node: widget.node,
          hasChildren: _hasChildren,
          expanded: _expanded,
          colorScheme: colorScheme,
          onTap: () {
            if (_hasChildren) setState(() => _expanded = !_expanded);
          },
        ),

        // ── CONNECTORS + CHILDREN ─────────────────────────────────────
        if (_hasChildren && _expanded) ...[
          // ↓ vertical line dropping from the parent card
          SizedBox(height: 4),
          _verticalLine(colorScheme.outline),

          // Horizontal bridge + children row kept together inside
          // IntrinsicWidth so the line always matches the row width exactly.
          IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Horizontal bridge (only when > 1 child)
                if (widget.node.children.length > 1)
                  Container(
                    height: 2,
                    color: colorScheme.outline,
                    //Remove margin if horizontal line is not enough for child
                    margin: EdgeInsets.symmetric(horizontal: 94),
                  ),

                // Children row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.node.children.map((child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ↓ vertical line dropping to each child
                          _verticalLine(colorScheme.outline),
                          HierarchyTreeNode(node: child),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _verticalLine(Color color) =>
      Container(width: 2, height: 25, color: color);
}

// =============================================================================
// _NodeCard  –  the visual card for a single employee
// =============================================================================
class _NodeCard extends StatelessWidget {
  const _NodeCard({
    required this.node,
    required this.hasChildren,
    required this.expanded,
    required this.colorScheme,
    required this.onTap,
  });

  final HierarchyModel node;
  final bool hasChildren;
  final bool expanded;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Card body
          Card(
            margin: EdgeInsets.zero,
            child: Container(
              constraints: const BoxConstraints(minWidth: 150),
              padding: EdgeInsets.fromLTRB(14, 14, 14, hasChildren ? 28 : 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(node.profilePhoto),
                  ),
                  const SizedBox(height: AppSize.verticalWidgetSpacing / 2),

                  // Name
                  Text(
                    node.name,
                    textAlign: TextAlign.center,
                    style: AppTextStyle().titleTextStyle(context: context),
                  ),

                  // Designation
                  Text(
                    node.designation,
                    textAlign: TextAlign.center,
                    style: AppTextStyle().lableTextStyle(
                      context: context,
                      color: AppColors.greyColor,
                      fontSize: 11,
                    ),
                  ),

                  // Role name
                  Text(
                    node.roleName,
                    textAlign: TextAlign.center,
                    style: AppTextStyle().lableTextStyle(
                      context: context,
                      color: AppColors.greyColor,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expand / collapse chevron badge
          if (hasChildren)
            Positioned(
              bottom: -4,
              child: GestureDetector(
                onTap: onTap,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: AppColors.errorColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    child: Icon(
                      expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 20,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
