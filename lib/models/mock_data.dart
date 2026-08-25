import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/nav_entry.dart';
import 'package:balamurugan_erp/models/transaction_item.dart';
import 'package:balamurugan_erp/models/stat_data.dart';
import 'package:balamurugan_erp/models/task_data.dart';
import 'package:balamurugan_erp/models/feature_data.dart';
import 'package:balamurugan_erp/models/customer.dart';
import 'package:balamurugan_erp/models/vendor.dart';
import 'package:balamurugan_erp/models/inventory_item.dart';
import 'package:balamurugan_erp/models/invoice_item.dart';

const navEntries = <NavEntry>[
  NavEntry(label: 'OVERVIEW', icon: Icons.grid_view_rounded),
  NavEntry(label: 'GETTING STARTED', icon: Icons.auto_awesome_rounded, badge: '4'),
  NavEntry(label: 'INVOICES', icon: Icons.description_outlined, badge: '12'),
  NavEntry(label: 'PAYMENTS RECEIVED', icon: Icons.account_balance_wallet_outlined),
  NavEntry(label: 'CUSTOMERS', icon: Icons.people_outline_rounded),
  NavEntry(label: 'SERVICE JOBS', icon: Icons.build_circle_outlined),
  NavEntry(label: 'BILLS', icon: Icons.receipt_long_outlined, badge: '9'),
  NavEntry(label: 'EXPENSES', icon: Icons.request_quote_outlined),
  NavEntry(label: 'VENDORS', icon: Icons.storefront_outlined),
  NavEntry(label: 'BANKING', icon: Icons.account_balance_outlined, badge: '2'),
  NavEntry(label: 'INVENTORY', icon: Icons.inventory_2_outlined),
  NavEntry(label: 'PROJECTS & TIME', icon: Icons.business_center_outlined),
  NavEntry(label: 'REPORTS', icon: Icons.bar_chart_rounded),
  NavEntry(label: 'USER MANAGEMENT', icon: Icons.manage_accounts_outlined),
];

const customersData = [
  Customer(
    name: 'Northstar Labs',
    email: 'contact@northstar.com',
    balance: '₹42,500',
    status: 'Active',
    address: '45 Tech Park, North Wing, Bengaluru',
    gstNumber: '29AAACN1234F1Z1',
    mobile: '9876543210',
  ),
  Customer(
    name: 'Bluefin Retail',
    email: 'billing@bluefin.in',
    balance: '₹0',
    status: 'Active',
    address: 'Bluefin Heights, Marine Drive, Kochi',
    gstNumber: '32AABCB5678G1Z2',
    mobile: '9988776655',
  ),
  Customer(
    name: 'Mango Tree Foods',
    email: 'orders@mangotree.com',
    balance: '₹16,520',
    status: 'Overdue',
    address: 'Mango Orchard, Salem Main Road, Dharmapuri',
    gstNumber: '33AACCY9012H1Z3',
    mobile: '9443322110',
  ),
  Customer(
    name: 'Acme Corp',
    email: 'info@acme.com',
    balance: '₹1,20,000',
    status: 'Active',
    address: 'Acme Plaza, Industrial Area, Noida',
    gstNumber: '09AAACA3456I1Z4',
    mobile: '9112233445',
  ),
];

const vendorsData = [
  Vendor(name: 'Paper & Pixel Studio', contact: 'hello@paperpixel.com', type: 'Design Services'),
  Vendor(name: 'Cloudline Hosting', contact: 'support@cloudline.net', type: 'IT Infrastructure'),
  Vendor(name: 'Office Depot', contact: 'sales@officedepot.com', type: 'Supplies'),
];

const inventoryData = [
  InventoryItem(name: 'MacBook Pro M3', sku: 'LAP-001', stock: 12, price: '₹1,54,900'),
  InventoryItem(name: 'Dell UltraSharp 27', sku: 'MON-042', stock: 5, price: '₹42,000'),
  InventoryItem(name: 'Logitech MX Master 3', sku: 'ACC-088', stock: 24, price: '₹9,500'),
  InventoryItem(name: 'Keychron K2 V2', sku: 'ACC-091', stock: 0, price: '₹8,200'),
];

final transactionItems = <TransactionItem>[
  TransactionItem(
    id: 'INV-1048',
    type: 'Sales invoice',
    party: 'Northstar Labs',
    date: '21 Aug 2026',
    amount: '₹42,500',
    status: 'Paid',
    category: 'sales',
    icon: Icons.description_outlined,
    color: AppColors.primary,
    background: AppColors.primarySoft,
    applyGst: true,
    items: [
      InvoiceItem(
        description: 'Dell XPS 15 Laptop',
        subDescription: '13th Gen Intel Core i7, 16GB RAM, 512GB SSD, Windows 11 Home',
        hsnCode: '8471',
        quantity: 1,
        unit: 'Piece',
        rate: 36016.95,
      ),
    ],
  ),
  const TransactionItem(
    id: 'BILL-0286',
    type: 'Vendor bill',
    party: 'Paper & Pixel Studio',
    date: '20 Aug 2026',
    amount: '₹18,900',
    status: 'Pending',
    category: 'purchases',
    icon: Icons.receipt_long_outlined,
    color: AppColors.purple,
    background: AppColors.purpleSoft,
  ),
  const TransactionItem(
    id: 'EXP-0731',
    type: 'Business expense',
    party: 'Office supplies',
    date: '20 Aug 2026',
    amount: '₹4,260',
    status: 'Reimbursed',
    category: 'expenses',
    icon: Icons.request_quote_outlined,
    color: AppColors.amber,
    background: AppColors.amberSoft,
  ),
  const TransactionItem(
    id: 'PMT-0919',
    type: 'Payment received',
    party: 'Bluefin Retail',
    date: '19 Aug 2026',
    amount: '+ ₹27,800',
    status: 'Deposited',
    category: 'banking',
    icon: Icons.account_balance_wallet_outlined,
    color: AppColors.green,
    background: AppColors.greenSoft,
    positive: true,
  ),
  TransactionItem(
    id: 'INV-1047',
    type: 'Sales invoice',
    party: 'Mango Tree Foods',
    date: '18 Aug 2026',
    amount: '₹16,520',
    status: 'Overdue',
    category: 'sales',
    icon: Icons.description_outlined,
    color: AppColors.primary,
    background: AppColors.primarySoft,
    applyGst: false,
    items: [
      InvoiceItem(
        description: 'Commercial Blender',
        subDescription: 'High-speed professional blender for food processing',
        quantity: 1,
        unit: 'Piece',
        rate: 16520.00,
      ),
    ],
  ),
  const TransactionItem(
    id: 'BILL-0285',
    type: 'Vendor bill',
    party: 'Cloudline Hosting',
    date: '17 Aug 2026',
    amount: '₹7,080',
    status: 'Draft',
    category: 'purchases',
    icon: Icons.receipt_long_outlined,
    color: AppColors.purple,
    background: AppColors.purpleSoft,
  ),
];

const statCardsData = [
  StatData(
    title: 'Cash & bank',
    value: '₹8,42,580',
    foot: 'vs. last month',
    trend: '12.8%',
    positive: true,
    icon: Icons.account_balance_wallet_outlined,
    color: AppColors.primary,
    softColor: AppColors.primarySoft,
    points: [28, 25, 27, 18, 21, 13, 15, 3],
  ),
  StatData(
    title: 'Receivables',
    value: '₹2,18,400',
    foot: '17 open invoices',
    trend: '8.4%',
    positive: true,
    icon: Icons.call_received_rounded,
    color: AppColors.green,
    softColor: AppColors.greenSoft,
    points: [25, 27, 19, 21, 14, 17, 9, 11],
  ),
  StatData(
    title: 'Payables',
    value: '₹1,06,720',
    foot: '9 bills to pay',
    trend: '3.1%',
    positive: false,
    icon: Icons.call_made_rounded,
    color: AppColors.amber,
    softColor: AppColors.amberSoft,
    points: [6, 11, 9, 19, 13, 20, 17, 29],
  ),
  StatData(
    title: 'Net profit',
    value: '₹3,64,180',
    foot: 'this financial year',
    trend: '8.6%',
    positive: true,
    icon: Icons.trending_up_rounded,
    color: AppColors.purple,
    softColor: AppColors.purpleSoft,
    points: [28, 23, 24, 19, 21, 12, 15, 4],
  ),
];

const tasksData = [
  TaskData(
    title: '3 invoices are overdue',
    detail: '₹38,750 is waiting to be collected',
    action: 'Review',
    icon: Icons.warning_amber_rounded,
    color: AppColors.red,
    background: AppColors.redSoft,
  ),
  TaskData(
    title: 'GSTR-3B filing due soon',
    detail: 'Due in 6 days · 12 transactions pending',
    action: 'Prepare',
    icon: Icons.calendar_today_outlined,
    color: AppColors.amber,
    background: AppColors.amberSoft,
  ),
  TaskData(
    title: '2 bank transactions to match',
    detail: 'HDFC Bank · Last synced 18 min ago',
    action: 'Match',
    icon: Icons.account_balance_outlined,
    color: AppColors.primary,
    background: AppColors.primarySoft,
  ),
  TaskData(
    title: 'Recurring invoice ready',
    detail: 'Monthly retainer for Northstar Labs',
    action: 'Send',
    icon: Icons.autorenew_rounded,
    color: AppColors.green,
    background: AppColors.greenSoft,
  ),
];

const featuresData = [
  FeatureData(
    title: 'Bank feeds',
    detail: '2 accounts synced automatically',
    icon: Icons.account_balance_outlined,
    color: AppColors.green,
    background: AppColors.greenSoft,
    status: 'Connected',
  ),
  FeatureData(
    title: 'Recurring invoices',
    detail: '7 active schedules',
    icon: Icons.autorenew_rounded,
    color: AppColors.purple,
    background: AppColors.purpleSoft,
    action: 'Manage schedules →',
  ),
  FeatureData(
    title: 'GST compliance',
    detail: 'e-invoice & tax reports ready',
    icon: Icons.verified_user_outlined,
    color: AppColors.amber,
    background: AppColors.amberSoft,
    action: 'Open compliance →',
  ),
];
