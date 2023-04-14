public class Pedido {
  public String Id;
  public loja loja;
  public Decimal precoTotal = 0;
  public String name;
  public Map<Produto, Integer> produtosPedido; //tem q ser uma lista de produtos

  public Pedido(String name, String Id, Loja loja) {
    this.name = name;
    this.id = id;
    this.loja = loja;
    produtosPedido = new Map<Produto, Integer>();
    this.precoTotal = precoTotal;
  }

  //add produtos no pedido, checa se esta no estoque, diminui o estoque.

  public void addItemPedido(Produto p, integer quantidade) {
    Estoque estoque = loja.listaEstoques;
    if (estoque.getEstoque(p) >= quantidade) {
      produtosPedido.put(p, quantidade);
      estoque.removeProduto(p, quantidade);
    } else if (quantidade > estoque.getEstoque(p)) {
      Integer valorPossivel = estoque.getEstoque(p);
      produtosPedido.put(p, valorPossivel);

      estoque.removeProduto(p, estoque.getEstoque(p));
      system.debug(
        'o valor que voce pediu: ' +
        quantidade +
        ' é mais do que se encontra no estoque ' +
        'o valor maximo do estoque é ' +
        valorPossivel +
        ' e foi adicionado em seu pedido'
      );
    }
  }

  ///verifica se o produto esta no catalogo de preco
  // verifica se esta em estoque
  //valor total

  public void valorTotalPedido(Map<Produto, Integer> itensPedido) {
    CatalogoPreco catalogo = loja.catalogo;

    for (Produto prod : itensPedido.keySet()) {
      Integer quantidade = itensPedido.get(prod);
      Decimal valor = catalogo.getCatalogoPreco(prod);
      Decimal valorTotal = quantidade * valor;
      precoTotal += valorTotal;

      System.debug(
        'Quantidade de ' +
        quantidade +
        ' do produto ' +
        prod.getName() +
        ' com o preço de ' +
        valor +
        ' é de ' +
        valorTotal
      );
    }
    System.debug('Preço total do pedido: ' + precoTotal);
  }

  //metodos getter and setters
  public String getName() {
    return name;
  }

  public Loja getLoja() {
    return loja;
  }

  public Decimal getPrecoTotal() {
    return precoTotal;
  }

  public Map<Produto, Integer> getProdutosPedido() {
    return produtosPedido;
  }

  //gerar pedido com produtos vendidos
  public String getPedido() {
    String resultado = 'pedido feito por: ' + this.getName() + '\n';
    resultado += ' pela loja: ' + this.loja.name + '\n';
    resultado += ' preço total do pedido: ' + this.getPrecoTotal() + '\n';
    resultado += ' produtos adquiridos: ' + this.getProdutosPedido() + '\n';
    return resultado;
  }
}
