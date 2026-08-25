import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:balamurugan_erp/models/invoice_model.dart';

class InvoicePreviewScreen extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoicePreviewScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Invoice Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sent to printer...')),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Container(
            width: 800,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 40),
                _buildTitle(),
                const SizedBox(height: 30),
                _buildClientInfo(),
                const SizedBox(height: 30),
                _buildDatesTable(),
                const SizedBox(height: 30),
                _buildItemsTable(),
                const SizedBox(height: 30),
                _buildTotals(),
                const SizedBox(height: 60),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company Logo
        SizedBox(
          height: 80,
          width: 200,
          child: Image.asset(
            "assets/logo.png",
            alignment: Alignment.centerLeft,
            fit: BoxFit.contain,
          ),
        ),
        // Company Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              invoice.company.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              invoice.company.address,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Color(0xFF666666), fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFEEEEEE), thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'INVOICE',
            style: TextStyle(
              fontSize: 24,
              letterSpacing: 4,
              color: Color(0xFF333333),
            ),
          ),
        ),
        Expanded(child: Divider(color: Color(0xFFEEEEEE), thickness: 1)),
      ],
    );
  }

  Widget _buildClientInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bill To', style: TextStyle(color: Color(0xFF999999), fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              invoice.billToName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              invoice.billToAddress,
              style: const TextStyle(color: Color(0xFF333333), fontSize: 13),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('Invoice#', style: TextStyle(color: Color(0xFF999999), fontSize: 12)),
            Text(
              invoice.id,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDatesTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        children: [
          Container(
            color: const Color(0xFF2B9A86),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: const Row(
              children: [
                Expanded(child: Text('Invoice Date', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(child: Text('Terms', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(child: Text('Due Date', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: Row(
              children: [
                Expanded(child: Text(DateFormat('dd MMM yyyy').format(invoice.date), style: const TextStyle(fontSize: 13))),
                Expanded(child: Text(invoice.terms, style: const TextStyle(fontSize: 13))),
                Expanded(child: Text(DateFormat('dd MMM yyyy').format(invoice.dueDate), style: const TextStyle(fontSize: 13))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsTable() {
    return Column(
      children: [
        Container(
          color: const Color(0xFF2B9A86),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            children: [
              const SizedBox(width: 30, child: Text('#', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
              const Expanded(flex: 3, child: Text('Item & Description', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
              if (invoice.applyGst)
                const Expanded(child: Text('HSN/SAC', textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
              const Expanded(child: Text('Qty', textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
              const Expanded(child: Text('Rate', textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
              const Expanded(child: Text('Amount', textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        ...invoice.items.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          final isEven = i % 2 != 0;
          return Container(
            color: isEven ? const Color(0xFFF9F9F9) : Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 30, child: Text('${i + 1}', style: const TextStyle(fontSize: 13))),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.description, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      if (item.subDescription.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(item.subDescription, style: const TextStyle(color: Color(0xFF666666), fontSize: 11)),
                      ],
                    ],
                  ),
                ),
                if (invoice.applyGst)
                  Expanded(child: Text(item.hsnCode ?? '-', textAlign: TextAlign.right, style: const TextStyle(fontSize: 12))),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(item.quantity.toStringAsFixed(2), style: const TextStyle(fontSize: 13)),
                      Text(item.unit, style: const TextStyle(color: Color(0xFF999999), fontSize: 10)),
                    ],
                  ),
                ),
                Expanded(child: Text(NumberFormat("#,##,##0.00", "en_IN").format(item.rate), textAlign: TextAlign.right, style: const TextStyle(fontSize: 13))),
                Expanded(child: Text(NumberFormat("#,##,##0.00", "en_IN").format(item.amount), textAlign: TextAlign.right, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTotals() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            _totalRow('Sub Total', NumberFormat("#,##,##0.00", "en_IN").format(invoice.subTotal)),
            if (invoice.applyGst)
              _totalRow('GST (18%)', NumberFormat("#,##,##0.00", "en_IN").format(invoice.taxAmount)),
            _totalRow('Total', '₹${NumberFormat("#,##,##0.00", "en_IN").format(invoice.total)}', isBold: true),
            const SizedBox(height: 10),
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              color: const Color(0xFFE8F5F1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Balance Due', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text('₹${NumberFormat("#,##,##0.00", "en_IN").format(invoice.total)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _totalRow(String label, String value, {bool isBold = false}) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: isBold ? Colors.black : const Color(0xFF666666))),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Thanks for your business.', style: TextStyle(fontSize: 13)),
        SizedBox(height: 40),
        Text(
          'Terms & Conditions',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 8),
        Text(
          'Full payment is due upon receipt of this invoice. Late payments may incur additional charges or interest as per the applicable laws.',
          style: TextStyle(color: Color(0xFF666666), fontSize: 12, height: 1.5),
        ),
      ],
    );
  }
}
