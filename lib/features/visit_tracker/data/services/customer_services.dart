import 'package:rtm/features/visit_tracker/data/models/customer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CustomerService {
  Future<List<Customer>> getCustomers();
  // Other visit services like create, update, delete, etc.
  Future<String> createCustomer(Customer customer);
}

class CustomerServiceImpl implements CustomerService {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Customer>> getCustomers() async {
    try {
      final response = await supabase.from('customers').select();

      final customersList = (response as List)
          .map((json) => Customer.fromJson(json as Map<String, dynamic>))
          .toList();
      return customersList;
    } on Exception catch (e, _) {
      rethrow;
    }
  }

  @override
  Future<String> createCustomer(Customer customer) async {
    try {
      await supabase.from('customers').insert(customer.toJson());
      return 'Customer created successfully';
    } on Exception catch (_) {
      rethrow;
    }
  }
}
