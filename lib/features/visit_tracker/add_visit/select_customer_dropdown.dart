import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtm/features/visit_tracker/cubit/_index.dart';
import 'package:rtm/features/visit_tracker/data/_index.dart';
import 'package:rtm/utils/_index.dart';

class SelectCustomerDropdown extends StatefulWidget {
  const SelectCustomerDropdown({
    required this.selectedCustomer,
    super.key,
  });

  final void Function(Customer customer) selectedCustomer;

  @override
  State<SelectCustomerDropdown> createState() => _SelectCustomerDropdownState();
}

class _SelectCustomerDropdownState extends State<SelectCustomerDropdown> {
  late List<Customer> customers;

  @override
  void initState() {
    super.initState();

    customers = context.read<GetCustomersCubit>().state.maybeWhen(
          orElse: () => const [],
          loaded: (customers) => customers,
        );
  }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 10),
            for (final customer in customers) ...[
              InkWell(
                onTap: () {
                  widget.selectedCustomer(customer);
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
