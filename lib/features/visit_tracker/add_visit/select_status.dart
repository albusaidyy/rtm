import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rtm/utils/_index.dart';

class SelectStatusPage extends StatefulWidget {
  const SelectStatusPage({
    required this.selectedStatus,
    super.key,
  });

  final void Function(String status) selectedStatus;
  @override
  State<SelectStatusPage> createState() => _SelectStatusPageState();
}

class _SelectStatusPageState extends State<SelectStatusPage> {
  final _searchController = TextEditingController();
  final List<VisitStatus> statusList = VisitStatus.values;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(
      filterStatus,
    );
  }

  void filterStatus() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        shadowColor: AppTheme.kSecondaryGreyColor.addOpacity(0.25),
        backgroundColor: AppTheme.kBackgroundColor,
        surfaceTintColor: AppTheme.kBackgroundColor,
        elevation: 0,
        title: Transform.translate(
          offset: const Offset(-20, 0),
          child: const Text(
            '',
            style: TextStyle(
              color: AppTheme.kBlackColor,
              fontSize: 15.48,
              fontFamily: 'Helvetica Neue',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        leading: IntrinsicWidth(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            splashRadius: 18,
            icon: const Icon(Icons.close),
            color: AppTheme.kBlackColor,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          for (final status in statusList) ...[
            StatusTileDisplay(
              status: status.name,
              onTap: () {
                GoRouter.of(context).pop();
                widget.selectedStatus(status.name);
                
              },
            ),
          ],
          if (statusList.isEmpty)
            const Text(
              'No data found',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.kDullGreyColor,
              ),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class StatusTileDisplay extends StatelessWidget {
  const StatusTileDisplay({
    required this.status,
    this.onTap,
    super.key,
  });

  final String status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minLeadingWidth: 10.5,
      minVerticalPadding: 4,
      contentPadding: const EdgeInsets.only(left: 20),
      visualDensity: VisualDensity.standard,
      onTap: onTap,
      leading: Container(
        color: Misc.getStatusColor(status),
        height: 23,
        width: 21,
      ),
      title: Text(
        status,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontFamily: 'Graphik',
        ),
      ),
    );
  }
}
