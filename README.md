<img src="https://login.salesforce.com/img/logo190.png" align="right" width="300">

<h1> Project: </h1>

This is a set of classes that represent an inventory and sales management system. The system contains a product catalog, inventory management, and order management functionalities.

<h3>Classes: </h3>

<h4>Produto</h4>
The Produto class represents a product that can be sold. It contains a name and a description. It has getter and setter methods for each attribute.

<h4>CatalogoPreco</h4>

The CatalogoPreco class represents a product catalog that contains the prices for each product. It is implemented as a map between products and their prices. It has a method to add a new product to the catalog and a method to retrieve the price of a product.

<h4>Estoque</h4>
The Estoque class represents the inventory management of the system. It keeps track of the quantity of each product available in stock. It is implemented as a map between products and their quantities. It has methods to add and remove products from the inventory, as well as a method to retrieve the quantity of a specific product.

- new version of <b>Estoque.cls</b>:
  The <b>addProdutoEstoque</b> method receives a list of produtos**c and their quantities and adds them to the Estoque**c. The method <b>temEstoque</b> takes an order item and checks whether there is enough stock to fulfill the requested quantity. The method <b>BuscaQtd</b> is used internally to search the quantity available in stock of a specific product.

<h4>Loja</h4>
The Loja class represents a store that sells products. It contains a name, an inventory (Estoque), and a product catalog (CatalogoPreco).

<h4>Pedido</h4>

The Pedido class represents an order placed by a customer. It contains the name of the customer, a unique identifier (id), the store (Loja) where the order was placed, the total price of the order, and a map of the products and quantities ordered. It has a method to add a product to the order, which checks if the product is in stock and removes it from the inventory, and a method to calculate the total price of the order. It also has getter methods for each attribute and a method to generate a string representation of the order.

- new version of <b>Pedido.cls</b>: in this new version, class has a static method "validaPedidos" that takes a list of order IDs to be validated considering it's quantity.

<h3>Usage</h3>
  
  The classes can be used to build a system for managing a store's inventory and sales. The Pedido class can be used to place orders and keep track of the sales, while the Estoque class can be used to manage the inventory levels. The CatalogoPreco class can be used to keep track of the prices of the products, while the Produto class represents the products themselves. Finally, the Loja class can be used to tie everything together and represent the store.

- How to use it:

```Apex
//Criando alguns produtos
Produto p1 = new Produto('Produto 1', 'Descrição do produto 1');
Produto p2 = new Produto('Produto 2', 'Descrição do produto 2');
Produto p3 = new Produto('Produto 3', 'Descrição do produto 3');

Estoque estoqueLoja = new Estoque('Estoque da loja');

//Criando uma loja com o estoque e um catálogo de preços
catalogoPreco catalogo = new catalogoPreco();
Loja loja = new Loja('Minha Loja', estoqueLoja, catalogo);

//Validando o pedido
Pedido.validaPedidos(new List<Id>{''});
obs: inside '' paste the id of a pedido__c already created inside salesforce plataform.
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
