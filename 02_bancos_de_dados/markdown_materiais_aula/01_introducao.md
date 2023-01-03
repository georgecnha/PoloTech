# **Introdução a Banco de Dados**
Vamos imaginar uma compra na internet. Você está navegando pelo site de uma loja e se interessa por um produto, o adiciona no carrinho de compras, verifica o valor de frete e decide seguir com a compra. Nesse momento você clica no botão “comprar”, automaticamente o site te direciona para uma página de cadastro, ali você informa alguns de seus **dados pessoais**: Nome; Sobrenome, E-mail, CPF e Endereço.

Um próximo passo é escolher a **forma de pagamento**: Cartão de crédito, Débito, Boleto bancário. Você decide usar o cartão de crédito.

Após essas etapas, o site apresenta uma mensagem semelhante à:  

**"Estamos validando o seu pagamento junto ao banco emissor do cartão."**
 
Em questões de segundos essa mensagem é substituída pela confirmação de compra e você já recebe um e-mail com o número do pedido.**  

Pois bem, **todas essas informações estão armazenadas** em um Banco de Dados.

> **"O principio básico de um Banco de Dados é armazenar informações de um sistema."**

Um site é parte de um sistema. Podemos simplificar um sistema em 3 camadas: 

**Front-end** e **Back-end** e **Banco de Dados**.

+ **Front-end**  
É a parte que o cliente visualiza de um site, suas cores, animações, disposições de texto, imagem e campos.

+ **Back-end**  
É tudo que ocorre nos bastidores de um site, é toda a lógica de instruções e comandos que faz com que o site faça o que queremos.

+ **Banco de Dados**  
É onde todos os dados informados no site são gravados.

![](https://www.homehost.com.br/blog/wp-content/uploads/2019/09/1557080784763701500.jpg)

## Tipos de Banco de Dados

Assim como existem tipos de Linguagens de Programação [Java](https://letscode.com.br/cursos/java), [C#](https://letscode.com.br/cursos/csharp), [Python](https://letscode.com.br/cursos/python_adulto), entre outras, nós também temos **tipos de Banco de Dados**. Eles podem ser dividos em **Relacionais** e **Não Relacionais**.

### Relacionais

São dados estruturados em um formato de tabela, coluna e linha *(podemos imaginar uma planilha de excel)*. Utiliza-se da linguagem SQL para manipulação dos dados.

```sql
SELECT * FROM usuarios WHERE estado = "Rio de Janeiro"
```

#### Exemplos de Sistemas de Gerenciamento de Banco de Dados Relacionais Open Source (Grátis)  
[MySQL](https://www.mysql.com/)  

[PostgreSQL](https://www.postgresql.org/)

[BigQuery](https://cloud.google.com/bigquery?hl=pt-br)

#### Exemplos de Sistemas de Gerenciamento de Banco de Dados Relacionais Pago  
[SQLServer](https://www.microsoft.com/pt-br/sql-server/sql-server-2019)  

[Oracle](https://www.oracle.com/index.html)

### Não Relacionais

São dados não estruturados, utiliza-se o conceito de Chave e Valor ou Orientado a Documento *(podemos imaginar um bloco json)*. Utiliza-se sintaxe de linguagem JSON para manipulação dos dados.

```json
db.usuarios.find(
    { estado: { $eq: "Rio de Janeiro" } }
)
```

#### Exemplos de Sistemas de Gerenciamento de Banco de Dados Não Relacionais

[Cassandra](https://cassandra.apache.org/)  
[MongoDB](https://www.mongodb.com/)  
[AWS DynamoDB](https://aws.amazon.com/dynamodb/?sc_channel=PS&sc_campaign=acquisition_BR&sc_publisher=google&sc_medium=english_dynamodb_b&sc_content=dynamodb_e&sc_detail=dynamodb%20aws&sc_category=dynamodb&sc_segment=89108950468&sc_matchtype=e&sc_country=BR&s_kwcid=AL!4422!3!89108950468!e!!g!!dynamodb%20aws&ef_id=CjwKCAiAxeX_BRASEiwAc1QdkQgIqmcplyErSngutzlCn39g6P7Cb3h_ypgxU7KigpMhQ-OP57QZRRoCkM8QAvD_BwE:G:s&s_kwcid=AL!4422!3!89108950468!e!!g!!dynamodb%20aws)  
[AWS DocumentDB](https://aws.amazon.com/pt/documentdb/)  
###### Cassandra e MongoDB tem versões pagas e gratuitas, que podem ser instaladas localmente. Os Banco de Dados na AWS são pagos 'sob demanda' e não possuem versão local.