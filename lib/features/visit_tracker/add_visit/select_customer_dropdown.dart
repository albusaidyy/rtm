import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rtm/features/visit_tracker/data/_index.dart';
import 'package:rtm/shared/services/hive_service.dart';
import 'package:rtm/utils/_index.dart';
import 'package:rtm/utils/singletons.dart';

class SelectCustomerDropdown extends StatelessWidget {
  const SelectCustomerDropdown({
    required this.selectedCustomer,
    super.key,
  });

  final void Function(Customer customer) selectedCustomer;

  @override
  Widget build(BuildContext context) {
    final customers = getIt<HiveService>().getCustomers();

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 10),
            for (final customer in customers) ...[
              InkWell(
                onTap: () {
                  selectedCustomer(customer);
                  GoRouter.of(context).pop();
                },
                child: Text(
                  customer.name,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Graphik',
                  ),
                ),
              ),
              if (customers.isEmpty)
                const Text(
                  'No data found',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.kDullGreyColor,
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}
