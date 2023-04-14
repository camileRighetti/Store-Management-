public class Loja {
  public String name;
  public Estoque listaEstoques;
  public catalogoPreco catalogo;

  //farmacia precisa de um catalogo e um estoque

  public loja(String name, Estoque listaEstoques, catalogoPreco catalogo) {
    this.name = name;
    this.listaEstoques = listaEstoques;
    this.catalogo = catalogo;
  }
}
