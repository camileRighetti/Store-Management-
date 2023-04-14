public class Estoque {
  //estoque precisa receber um produto e uma quantidade, produto é uma classe e recebe uma quantidade

  public Map<Produto, Integer> EstoqueProduto;

  public String cidade;
  public String nome;

  public Estoque(String cidade, String nome) {
    this.cidade = cidade;
    this.nome = nome;
    EstoqueProduto = new Map<Produto, Integer>();
  }

  public void IncrementaQuantidadeProdutoDescricao(
    String descricao,
    Integer quantidade
  ) {
    for (Produto p : EstoqueProduto.keySet()) {
      if (p.GetDescricao() == descricao) {
        addProduto(p, quantidade);
      }
    }
  }
  //metodo que adiciona produtos no estoqueProduto

  public void addProduto(Produto p, Integer quantidade) {
    if (!EstoqueProduto.containsKey(p)) {
      EstoqueProduto.put(p, 0); //se nao houver uma chave, adiciona uma chave com o valor 0
    }
    EstoqueProduto.put(p, (EstoqueProduto.get(p) + quantidade)); //adiciona quantidade no produto que antes estava como 0
  }
  //remove produto de estoque
  public void removeProduto(Produto p, Integer quantidade) {
    if (EstoqueProduto.containsKey(p)) {
      //verifica a quantidade atual de p em estoqueProduto

      Integer quantidadeAtual = EstoqueProduto.get(p);

      if (quantidadeAtual >= quantidade) {
        quantidadeAtual -= quantidade;
        EstoqueProduto.put(p, quantidadeAtual);
      } else {
        EstoqueProduto.remove(p);
      }
    }
  }

  //metodo tem estoque, usa para adionar uma quantidade no pedido

  public Integer getEstoque(Produto p) {
    Integer qtd = EstoqueProduto.get(p);

    if (EstoqueProduto.containsKey(p) && qtd > 0) {
      return qtd;
    } else {
      return null;
    }
  }
  //metodo pra pegar o produto com o menor estoque.
  //precisa iterar sobre a lista de estoqueProduto, usa for each porque
  // vai precisar fazer end to end da lista, como é o valor de estoque que vai ser o mandatorio
  // utiliza o keySet que ira retornar o set de todas chaves
  public List<Produto> getProdutosEstoqueMenor(Integer Valor) {
    List<Produto> produtosEstoque = new List<Produto>();
    for (Produto prod : EstoqueProduto.keySet()) {
      Integer quantidade = EstoqueProduto.get(prod); //atraves do map, faz um get na chave produto que ira retornar o valor dessa chave
      if (quantidade < Valor) {
        produtosEstoque.add(prod);
      }
    }
    return produtosEstoque;
  }
}
