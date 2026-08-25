# Balamurugan ERP Flutter desktop app

Balamurugan ERP is a Tally-inspired accounting dashboard with Zoho Books-style workflows for sales, purchases, banking, GST compliance, recurring invoices, and reporting.

## Run on Windows

Install the Flutter SDK and Visual Studio 2022 with the **Desktop development with C++** workload.

From PowerShell in this folder:

```powershell
flutter config --enable-windows-desktop
flutter create --platforms=windows .
flutter pub get
flutter run -d windows
```

The `flutter create` command is safe to run here. It adds the native Windows runner files and keeps the existing `lib/main.dart` and `pubspec.yaml`.

For a release executable:

```powershell
flutter build windows --release
```

The output is placed under `build\windows\x64\runner\Release\`.

## Included desktop interactions

- Collapsible left navigation
- Responsive drawer navigation at smaller window sizes
- Business overview cards for cash, receivables, payables, and net profit
- Income versus expenses chart
- Invoice creation dialog with customer, payment terms, GST, and currency options
- Tasks for overdue invoices, bank matching, recurring invoices, and GST filing
- Transaction filters, search, pagination controls, and export feedback
- Notifications and automation shortcuts

This project intentionally uses only Flutter SDK widgets and Material icons, so it does not need any third-party runtime packages.
