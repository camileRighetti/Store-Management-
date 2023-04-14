public class Estoque {
  private Estoque__c est;
  public Map<EstoqueProduto__c, Decimal> prods;

  public Estoque(String name) {
    est = new Estoque__c();
    est.Name = name;
    insert est;
    prods = new Map<EstoqueProduto__c, Decimal>();
  }

  public void addProdutoEstoque(
    Map<EstoqueProduto__c, Decimal> estoqueProdutos
  ) {
    List<EstoqueProduto__c> estoqueProdutoObj = new List<EstoqueProduto__c>();
    //Map<EstoqueProduto__c, Decimal> estProd = new Map<EstoqueProduto__c, Decimal>();
    for (EstoqueProduto__c prod : estoqueProdutos.keySet()) {
      Decimal quantidade = estoqueProdutos.get(prod);
      prod.Estoque__c = est.Id;
      prod.quantidade__c = quantidade;

      prods.put(prod, quantidade);
      estoqueProdutoObj.add(prod);
    }
    //prods.add(estProd);
    Database.insert(estoqueProdutoObj);
  }

  //metodo temEstoque usa o metodo busca qtd e metodo compara quantidade em estoque e a quantidade do pedido
  public static boolean temEstoque(produtos_do_pedido__c pp) {
    Id est = pp.Pedido__r.loja__r.Estoque__c;
    Id pedido = pp.Pedido__c;
    Id produtoId = pp.produto__c;
    Decimal qtdPedido = pp.quantidade__c;
    Decimal qtdEstoque = buscaQtd(produtoId, est);
    return qtdPedido <= qtdEstoque;
  }
  private static Decimal buscaQtd(Id produtoId, Id est) {
    List<EstoqueProduto__c> produtosEstoque = [
      SELECT Id, quantidade__c
      FROM EstoqueProduto__c
      WHERE produto__c = :produtoId AND Estoque__c = :est
    ];
    if (!produtosEstoque.isEmpty()) {
      return produtosEstoque[0].quantidade__c;
    }

    return 0;
  }

  public Id getId() {
    return est.Id;
  }
}
