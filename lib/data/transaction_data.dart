enum ExpenseCategories {
  food,
  mobileData,
  transportation,
  utilities,
  shopping,
  transfer,
  digitalServices,
}

List<Map<String, dynamic>> categories = [
  {
    'id': 'income',
    'name': 'Income',
    'items': [
      {'Salary & Wages'},
      {'Freelance & Client Work'},
      {'Transfers Received'},
      {'Investments & Yields'},
      {'Gifts & Bonuses'},
      {'Refunds & Reversals'},
    ],
  },
  {
    'id': 'expense',
    'name': 'Expense',
    'items': [
      {'id': ExpenseCategories.food, 'name': 'Food & Dining'},
      {'id': ExpenseCategories.mobileData, 'name': 'Airtime & Data'},
      {'id': ExpenseCategories.transportation, 'name': 'Transportation'},
      {'id': ExpenseCategories.utilities, 'name': 'Bills & Utilities'},
      {'id': ExpenseCategories.shopping, 'name': 'Shopping & Gear'},
      {'id': ExpenseCategories.transfer, 'name': 'Transfer & Remittance'},
      {'id': ExpenseCategories.digitalServices, 'name': 'Tech & Digital Services'},
    ],
  },
];


final expCat = categories.firstWhere((cat) => cat['id'] == 'expense')['items'];


void expSet(List<String> expenseList) {
  final expCat = categories.firstWhere((cat) => cat['id'] == 'expense')['items'];
  for (var cat in expCat) {
    expenseList.add(cat['name']);
  }
}

String expNameLocate(ExpenseCategories categoryId) {
  final expCat = categories.firstWhere((cat) => cat['id'] == 'expense')['items'];
  final expenseData = (expCat as List<Map<String, dynamic>>).firstWhere((ex) => ex['id'] == categoryId);
  return expenseData['name'];
}

dynamic expIdLocate(String categoryName) {
  final expCat = categories.firstWhere((cat) => cat['id'] == 'expense')['items'];
  final expenseData = (expCat as List<Map<String, dynamic>>).firstWhere((ex) => ex['name'] == categoryName);
  return expenseData['id'];
}