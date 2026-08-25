import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/mock_data.dart';
import 'package:balamurugan_erp/widgets/sidebar.dart';
import 'package:balamurugan_erp/widgets/top_bar.dart';
import 'package:balamurugan_erp/widgets/notification_dialog.dart';
import 'package:balamurugan_erp/models/company_profile.dart';
import 'package:balamurugan_erp/models/transaction_item.dart';
import 'package:balamurugan_erp/models/invoice_item.dart';
import 'package:balamurugan_erp/models/invoice_model.dart';
import 'package:balamurugan_erp/models/customer.dart';
import 'package:balamurugan_erp/models/vendor.dart';
import 'package:balamurugan_erp/models/inventory_item.dart';
import 'package:balamurugan_erp/models/user_model.dart';
import 'package:balamurugan_erp/models/service_job.dart';
import 'package:balamurugan_erp/models/project.dart';
import 'package:balamurugan_erp/screens/auth/login_screen.dart';
import 'package:balamurugan_erp/screens/dashboard/widgets/dashboard_content.dart';
import 'package:balamurugan_erp/screens/dashboard/widgets/invoice_dialog.dart';
import 'package:balamurugan_erp/screens/dashboard/widgets/transaction_dialog.dart';
import 'package:balamurugan_erp/screens/getting_started/getting_started_screen.dart';
import 'package:balamurugan_erp/screens/invoices/invoices_screen.dart';
import 'package:balamurugan_erp/screens/invoices/invoice_preview_screen.dart';
import 'package:balamurugan_erp/screens/payments/payments_screen.dart';
import 'package:balamurugan_erp/screens/customers/customers_screen.dart';
import 'package:balamurugan_erp/screens/customers/widgets/customer_dialog.dart';
import 'package:balamurugan_erp/screens/bills/bills_screen.dart';
import 'package:balamurugan_erp/screens/expenses/expenses_screen.dart';
import 'package:balamurugan_erp/screens/vendors/vendors_screen.dart';
import 'package:balamurugan_erp/screens/vendors/widgets/vendor_dialog.dart';
import 'package:balamurugan_erp/screens/banking/banking_screen.dart';
import 'package:balamurugan_erp/screens/inventory/inventory_screen.dart';
import 'package:balamurugan_erp/screens/inventory/widgets/inventory_dialog.dart';
import 'package:balamurugan_erp/screens/projects/projects_screen.dart';
import 'package:balamurugan_erp/screens/projects/widgets/project_dialog.dart';
import 'package:balamurugan_erp/screens/reports/reports_screen.dart';
import 'package:balamurugan_erp/screens/settings/user_management_screen.dart';
import 'package:balamurugan_erp/screens/settings/widgets/user_dialog.dart';
import 'package:balamurugan_erp/screens/service_jobs/service_jobs_screen.dart';
import 'package:balamurugan_erp/screens/service_jobs/widgets/service_job_dialog.dart';
import 'package:balamurugan_erp/utils/persistence_service.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  final UserModel loggedInUser;
  
  const DashboardScreen({super.key, required this.loggedInUser});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PersistenceService _persistence = PersistenceService();
  final searchController = TextEditingController();
  int selectedNav = 0;
  bool sidebarCollapsed = false;
  bool hasUnreadNotifications = true;
  String transactionFilter = 'all';
  String chartRange = 'Last 6 months';
  
  List<TransactionItem> allTransactions = [];
  List<Customer> allCustomers = [];
  List<Vendor> allVendors = [];
  List<InventoryItem> allInventory = [];
  List<UserModel> allUsers = [];
  List<ServiceJob> allServiceJobs = [];
  List<Project> allProjects = [];
  bool _isLoaded = false;

  CompanyProfile companyProfile = CompanyProfile(
    name: 'BALAMURUGAN ENTERPRISES',
    address: 'Plot No 2, YasothaIllam, Santhosh Aveune, Kundrathur, Chennai - 600069, India',
    gstNumber: '33ABCDE1234F1Z5',
    currency: 'INR',
    email: 'p.arunthen@gmail.com',
    phone: '+91 98417 72418 & 94452 04530',
  );

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final customers = await _persistence.loadCustomers();
    final vendors = await _persistence.loadVendors();
    final inventory = await _persistence.loadInventory();
    final transactions = await _persistence.loadTransactions();
    final users = await _persistence.loadUsers();
    final jobs = await _persistence.loadServiceJobs();
    final projects = await _persistence.loadProjects();

    if (mounted) {
      setState(() {
        allCustomers = customers;
        allVendors = vendors;
        allInventory = inventory;
        allTransactions = transactions;
        allUsers = users;
        allServiceJobs = jobs;
        allProjects = projects;
        _isLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void showToast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Container(
                width: 21,
                height: 21,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 13),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF236B56),
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFFF0FBF7),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
            side: const BorderSide(color: Color(0xFFBCE6D7)),
          ),
        ),
      );
  }

  void updateCompanyProfile(CompanyProfile newProfile) {
    setState(() {
      companyProfile = newProfile;
    });
  }

  Widget _buildMainContent(bool compact) {
    if (!_isLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    Widget content;

    switch (selectedNav) {
      case 0:
        content = DashboardContent(
          compact: compact,
          transactions: allTransactions,
          searchQuery: searchController.text,
          selectedNav: selectedNav,
          transactionFilter: transactionFilter,
          chartRange: chartRange,
          onCreateInvoice: openInvoiceDialog,
          onImport: () => showToast('Import center opened'),
          onToast: showToast,
          onFilterChanged: (value) => setState(() => transactionFilter = value),
          onChartRangeChanged: (value) => setState(() => chartRange = value),
          onExport: () => showToast('Transactions exported as CSV'),
          onFilter: () => showToast('Advanced filters are ready'),
        );
        break;
      case 1:
        content = GettingStartedScreen(
          compact: compact,
          companyProfile: companyProfile,
          onUpdateCompany: updateCompanyProfile,
        );
        break;
      case 2:
        content = InvoicesScreen(
          compact: compact,
          invoices: allTransactions.where((t) => t.category == 'sales').toList(),
          onCreateInvoice: openInvoiceDialog,
          onEditInvoice: (invoice) => openInvoiceDialog(invoice: invoice),
          onDeleteInvoice: deleteInvoice,
          onPrintInvoice: printInvoice,
          onMarkPaid: (invoice) => _markTransactionAsPaid(invoice),
        );
        break;
      case 3:
        content = PaymentsScreen(
          compact: compact,
          payments: allTransactions.where((t) => t.type == 'Payment received').toList(),
        );
        break;
      case 4:
        content = CustomersScreen(
          compact: compact,
          customers: allCustomers,
          onCreate: () => openCustomerDialog(),
          onEdit: (Customer customer) => openCustomerDialog(customer: customer),
          onDelete: (Customer customer) {
            setState(() {
              allCustomers.removeWhere((c) => c.name == customer.name);
              _persistence.saveCustomers(allCustomers);
            });
            showToast('Customer ${customer.name} removed');
          },
        );
        break;
      case 5:
        content = ServiceJobsScreen(
          jobs: allServiceJobs,
          onCreateJob: () => openServiceJobDialog(),
          onEditJob: (job) => openServiceJobDialog(job: job),
          onDeleteJob: (job) {
             setState(() {
               allServiceJobs.removeWhere((x) => x.id == job.id);
               _persistence.saveServiceJobs(allServiceJobs);
             });
             showToast('Service Job ${job.id} removed');
          },
          onMarkPaid: (job) => _markServiceJobAsPaid(job),
        );
        break;
      case 6:
        content = BillsScreen(
          compact: compact,
          bills: allTransactions.where((t) => t.category == 'purchases').toList(),
          onCreate: () => openTransactionDialog('purchases'),
          onEdit: (TransactionItem bill) => openTransactionDialog('purchases', transaction: bill),
          onDelete: deleteInvoice,
        );
        break;
      case 7:
        content = ExpensesScreen(
          compact: compact,
          expenses: allTransactions.where((t) => t.category == 'expenses').toList(),
          onCreate: () => openTransactionDialog('expenses'),
          onEdit: (TransactionItem expense) => openTransactionDialog('expenses', transaction: expense),
          onDelete: deleteInvoice,
        );
        break;
      case 8:
        content = VendorsScreen(
          compact: compact,
          vendors: allVendors,
          onCreate: () => openVendorDialog(),
          onEdit: (Vendor vendor) => openVendorDialog(vendor: vendor),
          onDelete: (Vendor vendor) {
            setState(() {
              allVendors.removeWhere((v) => v.name == vendor.name);
              _persistence.saveVendors(allVendors);
            });
            showToast('Vendor ${vendor.name} removed');
          },
        );
        break;
      case 9:
        content = BankingScreen(
          compact: compact,
          transactions: allTransactions.where((t) => t.category == 'banking').toList(),
          onConnect: () => openTransactionDialog('banking'),
          onEdit: (TransactionItem tx) => openTransactionDialog('banking', transaction: tx),
          onDelete: deleteInvoice,
        );
        break;
      case 10:
        content = InventoryScreen(
          compact: compact,
          inventory: allInventory,
          onCreate: () => openInventoryDialog(),
          onEdit: (InventoryItem item) => openInventoryDialog(item: item),
          onDelete: (InventoryItem item) {
            setState(() {
              allInventory.removeWhere((i) => i.sku == item.sku);
              _persistence.saveInventory(allInventory);
            });
            showToast('Item ${item.name} removed');
          },
        );
        break;
      case 11:
        content = ProjectsScreen(
          compact: compact,
          projects: allProjects,
          onCreate: () => openProjectDialog(),
          onEdit: (p) => openProjectDialog(project: p),
          onDelete: (p) {
             setState(() {
               allProjects.removeWhere((x) => x.id == p.id);
               _persistence.saveProjects(allProjects);
             });
             showToast('Project ${p.name} removed');
          },
        );
        break;
      case 12:
        content = ReportsScreen(
          compact: compact,
          transactions: allTransactions,
          serviceJobs: allServiceJobs,
        );
        break;
      case 13:
        content = UserManagementScreen(
          users: allUsers,
          onCreateUser: () => openUserDialog(),
          onResetPassword: (u) => openUserDialog(user: u),
          onDeleteUser: (u) {
             if (u.id == widget.loggedInUser.id) {
               showToast('Cannot delete currently logged in user');
               return;
             }
             setState(() {
               allUsers.removeWhere((x) => x.id == u.id);
               _persistence.saveUsers(allUsers);
             });
             showToast('User ${u.name} removed');
          },
        );
        break;
      default:
        content = const Center(child: Text('Coming Soon'));
    }

    return SingleChildScrollView(
      key: PageStorageKey('module_$selectedNav'),
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 16 : 34,
        vertical: compact ? 23 : 31,
      ),
      child: content,
    );
  }

  void _markTransactionAsPaid(TransactionItem invoice) {
    setState(() {
      final index = allTransactions.indexWhere((t) => t.id == invoice.id);
      if (index != -1) {
        final updated = allTransactions[index].copyWith(status: 'Paid');
        allTransactions[index] = updated;
        
        // Add a payment entry
        allTransactions.insert(0, TransactionItem(
          id: 'PMT-${1000 + DateTime.now().millisecond}',
          type: 'Payment received',
          party: invoice.party,
          date: DateFormat('dd MMM yyyy').format(DateTime.now()),
          amount: updated.amount,
          status: 'Deposited',
          category: 'banking',
          icon: Icons.account_balance_wallet_outlined,
          color: AppColors.green,
          background: AppColors.greenSoft,
          positive: true,
        ));
        
        _persistence.saveTransactions(allTransactions);
        showToast('Payment recorded for ${invoice.id}');
      }
    });
  }

  void _markServiceJobAsPaid(ServiceJob job) {
    setState(() {
      final index = allServiceJobs.indexWhere((x) => x.id == job.id);
      if (index != -1) {
        allServiceJobs[index] = allServiceJobs[index].copyWith(status: 'Paid');
        _persistence.saveServiceJobs(allServiceJobs);

        // Record payment in general ledger
        allTransactions.insert(0, TransactionItem(
          id: 'PMT-SJ-${1000 + DateTime.now().millisecond}',
          type: 'Payment received',
          party: job.customerName,
          date: DateFormat('dd MMM yyyy').format(DateTime.now()),
          amount: '₹${NumberFormat("#,##,##0.00", "en_IN").format(job.total)}',
          status: 'Deposited',
          category: 'banking',
          icon: Icons.account_balance_wallet_outlined,
          color: AppColors.green,
          background: AppColors.greenSoft,
          positive: true,
        ));
        _persistence.saveTransactions(allTransactions);
        
        showToast('Service job ${job.id} marked as paid');
      }
    });
  }

  Future<void> openInvoiceDialog({TransactionItem? invoice}) async {
    final TransactionItem? result = await showDialog<TransactionItem>(
      context: context,
      builder: (context) => InvoiceDialog(invoice: invoice, customers: allCustomers),
    );

    if (result != null && mounted) {
      setState(() {
        if (invoice != null) {
          final index = allTransactions.indexWhere((t) => t.id == invoice.id);
          if (index != -1) {
            allTransactions[index] = result;
          }
        } else {
          allTransactions.insert(0, result);
        }
        _persistence.saveTransactions(allTransactions);
      });
      showToast(invoice == null
          ? 'Invoice created successfully.'
          : 'Invoice updated successfully.');
    }
  }

  void deleteInvoice(TransactionItem invoice) {
    setState(() {
      allTransactions.removeWhere((t) => t.id == invoice.id);
      _persistence.saveTransactions(allTransactions);
    });
    showToast('${invoice.type} ${invoice.id} deleted.');
  }

  Future<void> openCustomerDialog({Customer? customer}) async {
    final Customer? result = await showDialog<Customer>(
      context: context,
      builder: (context) => CustomerDialog(customer: customer),
    );
    if (result != null && mounted) {
      setState(() {
        if (customer != null) {
          final index = allCustomers.indexOf(customer);
          allCustomers[index] = result;
        } else {
          allCustomers.add(result);
        }
        _persistence.saveCustomers(allCustomers);
      });
      showToast(customer == null ? 'Customer added' : 'Customer updated');
    }
  }

  Future<void> openVendorDialog({Vendor? vendor}) async {
    final Vendor? result = await showDialog<Vendor>(
      context: context,
      builder: (context) => VendorDialog(vendor: vendor),
    );
    if (result != null && mounted) {
      setState(() {
        if (vendor != null) {
          final index = allVendors.indexOf(vendor);
          allVendors[index] = result;
        } else {
          allVendors.add(result);
        }
        _persistence.saveVendors(allVendors);
      });
      showToast(vendor == null ? 'Vendor added' : 'Vendor updated');
    }
  }

  Future<void> openInventoryDialog({InventoryItem? item}) async {
    final InventoryItem? result = await showDialog<InventoryItem>(
      context: context,
      builder: (context) => InventoryItemDialog(item: item),
    );
    if (result != null && mounted) {
      setState(() {
        if (item != null) {
          final index = allInventory.indexOf(item);
          allInventory[index] = result;
        } else {
          allInventory.add(result);
        }
        _persistence.saveInventory(allInventory);
      });
      showToast(item == null ? 'Inventory item added' : 'Inventory item updated');
    }
  }

  Future<void> openServiceJobDialog({ServiceJob? job}) async {
    final ServiceJob? result = await showDialog<ServiceJob>(
      context: context,
      builder: (context) => ServiceJobDialog(job: job, customers: allCustomers),
    );
    if (result != null && mounted) {
      setState(() {
        if (job != null) {
          final index = allServiceJobs.indexWhere((x) => x.id == job.id);
          if (index != -1) allServiceJobs[index] = result;
        } else {
          allServiceJobs.insert(0, result);
        }
        _persistence.saveServiceJobs(allServiceJobs);
      });
      showToast(job == null ? 'Service job created' : 'Service job updated');
    }
  }

  Future<void> openProjectDialog({Project? project}) async {
    final Project? result = await showDialog<Project>(
      context: context,
      builder: (context) => ProjectDialog(project: project, customers: allCustomers),
    );
    if (result != null && mounted) {
      setState(() {
        if (project != null) {
          final index = allProjects.indexWhere((x) => x.id == project.id);
          if (index != -1) allProjects[index] = result;
        } else {
          allProjects.insert(0, result);
        }
        _persistence.saveProjects(allProjects);
      });
      showToast(project == null ? 'Project created' : 'Project updated');
    }
  }

  Future<void> openTransactionDialog(String category, {TransactionItem? transaction}) async {
    final TransactionItem? result = await showDialog<TransactionItem>(
      context: context,
      builder: (context) => TransactionDialog(transaction: transaction, category: category),
    );
    if (result != null && mounted) {
      setState(() {
        if (transaction != null) {
          final index = allTransactions.indexWhere((t) => t.id == transaction.id);
          if (index != -1) allTransactions[index] = result;
        } else {
          allTransactions.insert(0, result);
        }
        _persistence.saveTransactions(allTransactions);
      });
      showToast(transaction == null ? 'Transaction added' : 'Transaction updated');
    }
  }

  Future<void> openUserDialog({UserModel? user}) async {
    final UserModel? result = await showDialog<UserModel>(
      context: context,
      builder: (context) => UserDialog(user: user),
    );
    if (result != null && mounted) {
      setState(() {
        if (user != null) {
          final index = allUsers.indexWhere((x) => x.id == user.id);
          allUsers[index] = result;
        } else {
          allUsers.add(result);
        }
        _persistence.saveUsers(allUsers);
      });
      showToast(user == null ? 'User added' : 'User profile updated');
    }
  }

  void printInvoice(TransactionItem invoice) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InvoicePreviewScreen(
          invoice: InvoiceModel(
            id: invoice.id,
            date: DateTime.now(),
            dueDate: DateTime.now().add(const Duration(days: 15)),
            terms: 'Due on Receipt',
            company: companyProfile,
            billToName: invoice.party,
            billToAddress: invoice.customerAddress ?? 'No address provided',
            items: invoice.items ?? [
              InvoiceItem(
                description: 'Default Product',
                subDescription: 'Sample description',
                quantity: 1.0,
                unit: 'Piece',
                rate: 0.0,
              ),
            ],
            applyGst: invoice.applyGst,
          ),
        ),
      ),
    );
  }

  void selectNav(int index) {
    setState(() => selectedNav = index);
    if (index != 0) {
      showToast('${navEntries[index].label} module selected');
    }
  }

  void _logout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 900;
        return Scaffold(
          drawer: compact
              ? Drawer(
                  width: 254,
                  backgroundColor: AppColors.navy,
                  child: Sidebar(
                    collapsed: false,
                    selectedIndex: selectedNav,
                    companyName: companyProfile.name.toUpperCase(),
                    isAdmin: widget.loggedInUser.isAdmin,
                    onSelect: (index) {
                      selectNav(index);
                      Navigator.pop(context);
                    },
                    onCollapse: () {},
                    onLogout: _logout,
                  ),
                )
              : null,
          body: Builder(
            builder: (scaffoldContext) => Row(
              children: [
                if (!compact)
                  Sidebar(
                    collapsed: sidebarCollapsed,
                    selectedIndex: selectedNav,
                    companyName: companyProfile.name.toUpperCase(),
                    isAdmin: widget.loggedInUser.isAdmin,
                    onSelect: selectNav,
                    onCollapse: () =>
                        setState(() => sidebarCollapsed = !sidebarCollapsed),
                    onLogout: _logout,
                  ),
                Expanded(
                  child: Column(
                    children: [
                      TopBar(
                        compact: compact,
                        hasUnread: hasUnreadNotifications,
                        controller: searchController,
                        onMenu: () => Scaffold.of(scaffoldContext).openDrawer(),
                        onSearch: (_) => setState(() {}),
                        onNotifications: () async {
                          await showDialog<void>(
                            context: context,
                            builder: (context) => NotificationDialog(
                              onMarkRead: () {
                                setState(() => hasUnreadNotifications = false);
                                Navigator.pop(context);
                                showToast('All notifications marked as read');
                              },
                            ),
                          );
                        },
                        user: widget.loggedInUser,
                      ),
                      Expanded(
                        child: _buildMainContent(compact),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
