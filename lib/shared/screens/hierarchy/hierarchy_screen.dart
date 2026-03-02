import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/models/hierarchy_model.dart';
import 'package:hrms_yb/shared/screens/hierarchy/hierarchy_provider.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

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

  Widget _buildBody({required BuildContext context, required HierarchyProvider provider}) {
    return provider.isLoading
        ? CommonWidget.defaultLoader()
        : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: provider.hierarchy.length,
            itemBuilder: (context, index) {
              return HierarchyTile(model: provider.hierarchy[index], level: 0);
            },
          );
  }
}

class HierarchyTile extends StatefulWidget {
  final HierarchyModel model;
  final int level;

  const HierarchyTile({super.key, required this.model, required this.level});

  @override
  State<HierarchyTile> createState() => _HierarchyTileState();
}

class _HierarchyTileState extends State<HierarchyTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasChildren = widget.model.children.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: widget.level * 25),
          child: GestureDetector(
            onTap: hasChildren
                ? () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  }
                : () {},
            child: Card(
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(widget.model.profilePhoto)),
                title: Text(widget.model.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text("${widget.model.designation} • ${widget.model.roleName}"),
                trailing: hasChildren
                    ? IconButton(
                        icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
        ),

        /// CHILDREN
        if (hasChildren && isExpanded)
          ...widget.model.children.map((child) => HierarchyTile(model: child, level: widget.level + 1)),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hrms_yb/models/hierarchy_model.dart';
// import 'package:hrms_yb/shared/widgets/common_widget.dart';
// import 'package:provider/provider.dart';
// import 'hierarchy_provider.dart';

// class HierarchyScreen extends StatelessWidget {
//   const HierarchyScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => HierarchyProvider(context: context),
//       child: const _HierarchyView(),
//     );
//   }
// }

// class _HierarchyView extends StatelessWidget {
//   const _HierarchyView();

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<HierarchyProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         leading: CommonWidget.backButton(onTap: () => context.pop()),
//         title: const Text("Organization Hierarchy"),
//         centerTitle: true,
//       ),
//       body: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : provider.hierarchy.isEmpty
//           ? const Center(child: Text("No hierarchy found"))
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: HierarchyTree(root: provider.hierarchy.first),
//             ),
//     );
//   }
// }

// class HierarchyTree extends StatelessWidget {
//   final HierarchyModel root;

//   const HierarchyTree({super.key, required this.root});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         /// TOP PERSON
//         EmployeeCard(model: root, isPrimary: false),

//         const VerticalConnector(),

//         /// SECOND LEVEL (Manager Highlight)
//         if (root.children.isNotEmpty) EmployeeCard(model: root.children.first, isPrimary: true),

//         const SizedBox(height: 10),

//         if (root.children.isNotEmpty)
//           Text(
//             "${root.children.first.children.length} Direct Reports",
//             style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
//           ),

//         const SizedBox(height: 12),

//         /// GRID REPORTS
//         if (root.children.isNotEmpty)
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: root.children.first.children.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisExtent: 95,
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 10,
//             ),
//             itemBuilder: (_, index) {
//               final emp = root.children.first.children[index];
//               return EmployeeSmallCard(model: emp);
//             },
//           ),
//       ],
//     );
//   }
// }

// class VerticalConnector extends StatelessWidget {
//   const VerticalConnector({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 12),
//       width: 2,
//       height: 30,
//       color: Colors.grey.shade400,
//     );
//   }
// }

// class EmployeeCard extends StatelessWidget {
//   final HierarchyModel model;
//   final bool isPrimary;

//   const EmployeeCard({super.key, required this.model, required this.isPrimary});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 320,
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: isPrimary ? Border.all(color: Colors.blue.shade200, width: 2) : null,
//         boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black.withValues(alpha: .05))],
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(radius: 28, backgroundImage: NetworkImage(model.profilePhoto)),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(model.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                 Text(model.designation),
//                 Text(model.roleName, style: const TextStyle(color: Colors.grey)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EmployeeSmallCard extends StatelessWidget {
//   final HierarchyModel model;

//   const EmployeeSmallCard({super.key, required this.model});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black.withValues(alpha: .05))],
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(radius: 20, backgroundImage: NetworkImage(model.profilePhoto)),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   model.name,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 Text(model.designation, style: const TextStyle(fontSize: 12, color: Colors.grey)),
//               ],
//             ),
//           ),
//           const Icon(Icons.chevron_right),
//         ],
//       ),
//     );
//   }
// }
