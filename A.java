Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Dynamic Invoice Generator"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildTextField(_invoiceNumberController, "Invoice Number", Icons.receipt),
                    _buildTextField(_invoiceDateController, "Invoice Date", Icons.date_range),
                    _buildTextField(_dueDateController, "Due Date", Icons.event),
                    _buildTextField(_sellerNameController, "Seller Name", Icons.store),
                    _buildTextField(_sellerAddressController, "Seller Address", Icons.location_on),
                    _buildTextField(_sellerContactController, "Seller Contact", Icons.phone),
                    _buildTextField(_sellerTaxNumberController, "Seller Tax Number", Icons.confirmation_number),
                    _buildTextField(_buyerNameController, "Buyer Name", Icons.person),
                    _buildTextField(_buyerAddressController, "Buyer Address", Icons.home),
                    _buildTextField(_buyerContactController, "Buyer Contact", Icons.phone),
                    _buildTextField(_paymentTypeController, "Payment Type", Icons.payment),
                    _buildTextField(_accountDetailsController, "Account Details", Icons.account_balance),

                    const SizedBox(height: 20),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            _addItemDialog();
                          },
                          icon: const Icon(Icons.add_circle),
                          label: const Text("Add Item"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            _printInvoice();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Invoice Generated")),
                            );
                            _clearFields();
                          },
                          icon: const Icon(Icons.picture_as_pdf),
                          label: const Text("Generate PDF"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),