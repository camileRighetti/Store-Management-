public class Pedido {
  public static void validaPedidos(List<Id> pedidosId) {
    //armazena a quantidade dos pedidos, pega seu estoque e id do pedido
    list<Pedido__c> pedidos = [
      SELECT
        Id,
        loja__r.Estoque__c,
        pedidoStatus__c,
        (
          SELECT Id, quantidade__c, Pedido__r.Id, produto__r.Name
          FROM produtos__r //para poder acessar os dados de produtos atraves de pp, é necessario trazer pedido__r.Id
        )
      FROM Pedido__c
      WHERE Id IN :pedidosId
    ];

    List<produtos_do_pedido__c> produtosPedido = new List<produtos_do_pedido__c>(); //ao iterar sobre os pedidos, irá adicionar os produtos nessa lista
    List<Id> estoqueId = new List<Id>(); //os estoques id de cada pedido serao adicionados a essa lista.

    for (Pedido__c pedidoId : pedidos) {
      estoqueId.add(pedidoId.loja__r.Estoque__c); // cada pedido tem um unico estoque, por isso é add
      produtosPedido.addAll(pedidoId.produtos__r); // cada pedido pode ter varios produtos do pedido, por isso é um addAll.
    }

    //ira buscar as informacoes dos estoques dos pedidos
    list<Estoque__c> estoquesId = [
      SELECT Id, (SELECT Id, quantidade__c, produto__r.Name FROM Produtos__r)
      FROM Estoque__c
      WHERE Id IN :estoqueId //filtro atraves da lista de estoqueId que criei, aonde peguei a lista dos pedidos e peguei os ids do estoque de cada um
    ];

    //lista de produtos do estoque
    List<EstoqueProduto__c> produtosEstoque = new List<EstoqueProduto__c>(); //crio uma nova lista que sera aonde eu vou armazenar os produtos do estoque, utilizando a query acima que busca os estoque a partir dos estoques id de cada pedido
    for (Estoque__c estoques : estoquesId) {
      produtosEstoque.addAll(estoques.Produtos__r); //é aonde eu irei adicionar todos os produtos que tiverem dentro de estoque de cada pedido
    }

    for (produtos_do_pedido__c pp : produtosPedido) {
      for (EstoqueProduto__c pe : produtosEstoque) {
        if (pe.produto__r.Name == pp.produto__r.Name) {
          //comparo se produto estoque, nome do produto__c é igual ao o produtos pedidos, produto__c name
          if (pp.quantidade__c > pe.quantidade__c) {
            //se a quantidade de produtos do pedido for maior signfica que nao tem em estoque
            system.debug('o estoque não possue produtos suficientes');
            pp.Pendencia__c = true;
            pp.Pedido__r.pedidoStatus__c = 'Parcial'; //atualizo o status do pedido relacionado
            pe.quantidade__c -= pp.quantidade__c; //atualizo o estoque
            break;
          } else {
            system.debug('o pedido pode ser feito');
            pp.Pedido__r.pedidoStatus__c = 'Completo';
            pe.quantidade__c -= pp.quantidade__c;
          }
        }
        update pe;
      }
      update pp.Pedido__r; //é necessario atualizar o campo de pedido dentro de produto pedido
      update pp; //atualiza o produto pedido.
    }
  }
}

//Validar pedido
//recebe id de pedido ou lista de id > melhor
// valida se tem todos os produtos em estoque
// se tiver : atualizar o status do pedido para completo
// atualiza a quantidade em estoque e decrementa

//se não tiver algum:
//atualiza o status do pedido para parcial,
//atualiza quantidade de todos que tiverem em estoque, os que não tiverem em estoque
//atualiza produto do pedido que não tiver estoque: uma checkbox em produto do pedido ‘pendencia’ para true
//validar estoque

