class BankServices {
  static const _bankLogoPath = "assets/logos/banks";
  List<Map<String, dynamic>> bankList = [
    {
      'id': 'access',
      'name': 'Access Bank Plc',
      'icon': '$_bankLogoPath/access.png',
    },
    {
      'id': 'alpha_morgan',
      'name': 'Alpha Morgan Bank',
      'icon': '$_bankLogoPath/alpha_morgan.png',
    },
    {'id': 'citi', 'name': 'Citibank Ltd', 'icon': '$_bankLogoPath/citi.png'},
  ];
  String getNameById(String id) {
    final bankLocation = bankList.firstWhere((bank) => bank['id'] == id);
    return bankLocation['name'];
  }
}
