enum ExpenseCategories {
  food,
  mobileData,
  transportation,
  utilities,
  shopping,
  transfer,
  digitalServices,
}

enum IncomeCategories {
  wages,
  clientWork,
  transfers,
  investments,
  gifts,
  refunds,
}

List<Map<String, dynamic>> categories = [
  {
    'id': 'income',
    'name': 'Income',
    'items': [
      {'id': IncomeCategories.wages, 'name': 'Salary & Wages'},
      {'id': IncomeCategories.clientWork, 'name': 'Freelance & Client Work'},
      {'id': IncomeCategories.transfers, 'name': 'Transfers Received'},
      {'id': IncomeCategories.investments, 'name': 'Investments & Yields'},
      {'id': IncomeCategories.gifts, 'name': 'Gifts & Bonuses'},
      {'id': IncomeCategories.refunds, 'name': 'Refunds & Reversals'},
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
      {
        'id': ExpenseCategories.digitalServices,
        'name': 'Tech & Digital Services',
      },
    ],
  },
];

final expCat = categories.firstWhere((cat) => cat['id'] == 'expense')['items'];

void expSet(List<String> expenseList) {
  final expCat = categories.firstWhere(
    (cat) => cat['id'] == 'expense',
  )['items'];
  for (var cat in expCat) {
    expenseList.add(cat['name']);
  }
}

void incSet(List<String> incomeList) {
  final List<Map<String, dynamic>> incCat =
      categories.firstWhere((cat) => cat['id'] == 'income')['items']
          as List<Map<String, dynamic>>;
  for (var c in incCat) {
    incomeList.add(c['name']);
  }
}

String expNameLocate(ExpenseCategories categoryId) {
  final expCat = categories.firstWhere(
    (cat) => cat['id'] == 'expense',
  )['items'];
  final expenseData = (expCat as List<Map<String, dynamic>>).firstWhere(
    (ex) => ex['id'] == categoryId,
  );
  return expenseData['name'];
}

String incNameLocate(IncomeCategories categoryId) {
  final List<Map<String, dynamic>> incCat = categories.firstWhere(
    (cat) => cat['id'] == 'income',
  )['items'];
  final incomeData = incCat.firstWhere((inc) => inc['id'] == categoryId);
  return incomeData['name'];
}

dynamic expIdLocate(String categoryName) {
  final List<Map<String, dynamic>> expCat = categories.firstWhere(
    (cat) => cat['id'] == 'expense',
  )['items'];
  final Map<String, dynamic> expenseData = expCat.firstWhere(
    (ex) => ex['name'] == categoryName,
  );
  return expenseData['id'];
}

dynamic incIdLocate(String categoryName) {
  final List<Map<String, dynamic>> incCat = categories.firstWhere(
    (cat) => cat['id'] == 'income',
  )['items'];
  final Map<String, dynamic> incData = incCat.firstWhere(
    (inc) => inc['name'] == categoryName,
  );
  return incData['id'];
}
