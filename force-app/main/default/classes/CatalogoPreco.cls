public with sharing class CatalogoPreco {
  public Map<Produto, Decimal> catalogo;
  public String Name;

  public CatalogoPreco(String name) {
    this.catalogo = new Map<Produto, Decimal>();
    this.name = name;
  }

  public void addCatalogoPreco(Produto p, Decimal valor) {
    if (!catalogo.containsKey(p)) {
      catalogo.put(p, valor);
    } else {
      system.debug(
        'o produto: ' +
        p.getName() +
        ' já existe dentro do catalogo'
      );
    }
  }
  //metodo get

  public Decimal getCatalogoPreco(Produto p) {
    Decimal valorProduto = catalogo.get(p);
    return valorProduto;
  }
}
