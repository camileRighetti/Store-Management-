public class Produto {
  String name;
  String descricao;

  //contrutor
  public Produto(String name, String descricao) {
    this.name = name;
    this.descricao = descricao;
  }

  //metodo get e set
  public void setName(String name) {
    this.name = name;
  }

  public String getName() {
    return name;
  }

  public void setDescricao(String descricao) {
    this.descricao = descricao;
  }

  public String getDescricao() {
    return descricao;
  }
}
