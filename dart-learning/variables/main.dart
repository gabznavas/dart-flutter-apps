class Product {
  String name = '';
  double price = 0.0;
  String description = '';

  Product({this.name = '', this.price = 0.0});

  // Product(String name, double price);

  // Product(String name, double price) {
  //   this.name = name;
  //   this.price = price;
  // }

  void morePrice(String description, {int price = 0}) {
    this.price += price;
    this.description = description;
  }
}

int soma(int a, int b) {
  return a + b;
}

int exec(int x, int y, int Function(int a, int b) fn) {
  return fn(x, y);
}

main() {
  dynamic x = false;
  x = 2.4;
  x = 'opa';
  print(x);

  int a = 2;
  double b = 2.2;
  var c = "opa";

  print(a);
  print(b);
  print(c);

  var nomes = ["a", "b", "c"];
  nomes.add("d");
  print(nomes.elementAt(0));
  for (var nomes in nomes) {
    print(nomes);
  }

  Set<int> conjunto = {0, 2, 3, 4};
  for (var n in conjunto) {
    print(n);
  }

  Map<String, double> notasAlunos = {
    'jose': 5.2,
    'jose1': 5.2,
    'jose2': 5.2,
    'jose3': 5.2,
  };

  for (var n in notasAlunos.entries) {
    print('${n.key} = ${n.value}');
  }

  final name = 'gabriel';
  // name = 'no!';

  final r = exec(2, 3, (a, b) => a * b + 100);
  print(r);

  var p1 = new Product(name: 'Apple', price: 123);
  print("${p1.price}");
  p1.morePrice("product is nice", price: 2);
  print("${p1.price}");
  print("${p1.description}");
}
