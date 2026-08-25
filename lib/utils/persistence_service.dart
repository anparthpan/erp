import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:balamurugan_erp/models/customer.dart';
import 'package:balamurugan_erp/models/vendor.dart';
import 'package:balamurugan_erp/models/inventory_item.dart';
import 'package:balamurugan_erp/models/transaction_item.dart';
import 'package:balamurugan_erp/models/user_model.dart';
import 'package:balamurugan_erp/models/mock_data.dart';
import 'package:balamurugan_erp/models/service_job.dart';
import 'package:balamurugan_erp/models/project.dart';

class PersistenceService {
  static const String _customersKey = 'customers';
  static const String _vendorsKey = 'vendors';
  static const String _inventoryKey = 'inventory';
  static const String _transactionsKey = 'transactions';
  static const String _usersKey = 'users';
  static const String _serviceJobsKey = 'service_jobs';
  static const String _projectsKey = 'projects';

  Future<void> saveProjects(List<Project> projects) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(projects.map((e) => e.toJson()).toList());
    await prefs.setString(_projectsKey, json);
  }

  Future<List<Project>> loadProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_projectsKey);
    if (json == null) {
      return [
        const Project(id: '1', name: 'Website Redesign', client: 'Northstar Labs', progress: 0.75, status: 'In Progress'),
        const Project(id: '2', name: 'Mobile App Dev', client: 'Acme Corp', progress: 0.30, status: 'In Progress'),
        const Project(id: '3', name: 'SEO Optimization', client: 'Bluefin Retail', progress: 1.0, status: 'Completed'),
      ];
    }
    final List list = jsonDecode(json);
    return list.map((e) => Project.fromJson(e)).toList();
  }

  Future<void> saveServiceJobs(List<ServiceJob> jobs) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(jobs.map((e) => e.toJson()).toList());
    await prefs.setString(_serviceJobsKey, json);
  }

  Future<List<ServiceJob>> loadServiceJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_serviceJobsKey);
    if (json == null) return [];
    final List list = jsonDecode(json);
    return list.map((e) => ServiceJob.fromJson(e)).toList();
  }

  Future<void> saveUsers(List<UserModel> users) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(users.map((e) => e.toJson()).toList());
    await prefs.setString(_usersKey, json);
  }

  Future<List<UserModel>> loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_usersKey);
    if (json == null) {
      return [
        UserModel(
          id: '1',
          name: 'Admin',
          email: 'admin@balamurugan.in',
          password: 'admin',
          role: UserRole.admin,
        ),
        UserModel(
          id: '2',
          name: 'Staff User',
          email: 'staff@balamurugan.in',
          password: 'staff',
          role: UserRole.staff,
        ),
      ];
    }
    final List list = jsonDecode(json);
    return list.map((e) => UserModel.fromJson(e)).toList();
  }

  Future<void> saveCustomers(List<Customer> customers) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(customers.map((e) => e.toJson()).toList());
    await prefs.setString(_customersKey, json);
  }

  Future<List<Customer>> loadCustomers() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_customersKey);
    if (json == null) return List.from(customersData);
    final List list = jsonDecode(json);
    return list.map((e) => Customer.fromJson(e)).toList();
  }

  Future<void> saveVendors(List<Vendor> vendors) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(vendors.map((e) => e.toJson()).toList());
    await prefs.setString(_vendorsKey, json);
  }

  Future<List<Vendor>> loadVendors() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_vendorsKey);
    if (json == null) return List.from(vendorsData);
    final List list = jsonDecode(json);
    return list.map((e) => Vendor.fromJson(e)).toList();
  }

  Future<void> saveInventory(List<InventoryItem> inventory) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(inventory.map((e) => e.toJson()).toList());
    await prefs.setString(_inventoryKey, json);
  }

  Future<List<InventoryItem>> loadInventory() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_inventoryKey);
    if (json == null) return List.from(inventoryData);
    final List list = jsonDecode(json);
    return list.map((e) => InventoryItem.fromJson(e)).toList();
  }

  Future<void> saveTransactions(List<TransactionItem> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(transactions.map((e) => e.toJson()).toList());
    await prefs.setString(_transactionsKey, json);
  }

  Future<List<TransactionItem>> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_transactionsKey);
    if (json == null) return List.from(transactionItems);
    final List list = jsonDecode(json);
    return list.map((e) => TransactionItem.fromJson(e)).toList();
  }
}
