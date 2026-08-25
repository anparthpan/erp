Balamurugan ERP
A Flutter accounting and service-management application for Balamurugan Enterprises. The original workflow is Tally-inspired, with a modern Zoho Books-style layer for automation, bank workflows, and operational visibility.

Current capabilities
Unified Invoices & Vouchers workspace for sales invoices, purchase bills, payments, receipts, journals, quotations, and proforma invoices
Configurable payment terms and invoice due dates
GST-aware invoices with configurable per-invoice GST rates and HSN/item details
PDF, A4, thermal, UPI QR, and invoice print previews
Customer/supplier ledgers, stock items, low-stock alerts, service jobs, and technician reports
Profit and loss, balance sheet, ageing, party statements, audit logs, backup/restore, user roles, and multi-company support
Optional PocketBase LAN synchronization and local-first SharedPreferences storage
Zoho Books-inspired enhancements in this version
Unified invoice and voucher entry
Sales, New Invoice, and Voucher Entry previously opened the same workflow from multiple places. They are now consolidated into Invoices & Vouchers in the main navigation. The entry screen includes a visible document-type selector so users can switch between sales, purchases, payments, receipts, journals, quotations, and proforma invoices from one place.

The right-side keyboard shortcuts remain available for fast entry, but duplicate Sales, Quotation, and Proforma buttons have been removed from the visible navigation.

Recurring invoices
Open Recurring Invoices from the left navigation to create monthly, quarterly, or yearly templates. Each template supports:

Customer and service description
Amount and GST rate
Next-run date and optional end date
Pause/resume
Generate invoice now
Generated invoice count and audit logging
Generated invoices are stored as normal sales vouchers, so they appear in the day book, receivables, reports, and PDF workflows.

Bank reconciliation
Open Bank Reconciliation to:

Add statement lines manually
Import a simple CSV with columns Date, Description, Type, Amount, Reference
Filter reconciled/unreconciled lines
Compare statement balance with payment/receipt book entries
Mark statement lines or book vouchers as reconciled
Keep reconciliation activity in the audit log
Dashboard upgrades
The dashboard includes quick actions for recurring invoices and bank reconciliation, plus outstanding receivables, overdue balances, and active automation metrics.

Development
This is a Flutter project. Install Flutter and run:

Bash

flutter pub get
flutter test
flutter run -d windows
Windows desktop builds require Visual Studio with the Desktop development with C++ workload, Windows SDK, MSVC, and CMake tools.

For Android support, generate the Android platform files from the project root if the project does not already contain them:

Bash

flutter create --platforms=android .
Default local login: admin / 123.

The Agent workspace does not include the Flutter SDK, so validation here is limited to source inspection and diff checks. Run the commands above in a Flutter-enabled development environment before release.