# Tipos de Dados

A primeira coisa que devemos ter conhecimento ao criar uma tabela são os tipos dos dados. Os tipos são como as informações daquela coluna serão armazenas. Cada tipo é armazenado de forma diferente na memória e podem ser aplicadas operações distintas, apesar de algumas operações servirem para vários tipos diferentes.

O `SQL` tem suporte a vários tipos de dados, podendo ocorrer algumas mudanças entre diferentes **SGBDs**. 

### Tipos Numéricos

Estes tipos salvam valores numéricos. Com eles podemos fazer operações aritméticas, ou utilizar funções que permitem retirar valores estatísticos. 

Eles são dividos entre números **inteiros** e **decimais**.

+ **inteiros**: guardam números inteiros, ou sejam sem a parte decimal, existem vários tipos de dados inteiros, que se diferencia pelo tamanho de bits necessários para guardar o valor.

+ **smallint**: são inteiros de 2 bytes (16 bits).

+ **interger**: inteiros de 4 bytes (32 bits).

+ **bigint**: inteiros de 8 bytes (64 bits).

+ **decimais**: estes são os valores que guardam números decimais, ou sejam que tem pontos, eles também são dividos segundo sua precisão.

+ **real**: números decimais de 4 bytes (32 bits).

+ **double precision**: números decimais de 8 bytes (64 bit).

### Tipos Textuais

Este tipos representam textos. Textos na computação são listas de caracteres *(letras e símbolos)*. Estes tipos se diferenciam pelo números de caracteres possíveis de guardar.

+ **character(n) ou char(n)**: tem um número fixo de n símbolos.

+ **character varying (n) ou varchar(n)**: tem variado de símbolos, porém com máximo de n.

+ **text**: esse tipo de dado tem um número ilimitado de símbolos.

### Data

Estes são os valores utilizados para se salvar datas. Com ele é possível acessar a contagem de tempo por diferentes valores *(dia, mês, anos, minutos, segundos, microssegundos)*. Também é possível compara duas datas, verificando, por exemplo, se uma data é maior que outra.

+ **Date**: Formato de dados com 4 bytes utilizando para salvar a data com precisão máxima de um dia.

+ **Time**: Formato de dados com valores entre 8 a 12 bytes, utilizado para salvar datas com precisão máxima de 1 microssegundo. Em alguns **SGBDs** conhecido como **datetime**.

+ **TimeStamp**: Formato alternativo, de 8 bytes, utilizado salvar valores de data com precisão de 1 microssegundo, porém não suporta operações com as datas.

+ **Tipos Lógicos**: Formato utilizado para cálculos booleanos, com apenas dois estados, verdadeiro ou falso.

+ **Bolean**: Formato padrão, aonde os valores são salvos por padrão como **'TRUE'** ou **'FALSE'**, porém também permite leituras diferentes como por exemplo a utilizada no bit.

+ **Bit**: Formato logico padrão em **SGBDs** como **MySQL**, aceitam dois tipos de valores inteiros, 1 representando verdadeiro e 0 representando falso.

### Enumerados

+ **ENUM**: São tipos personalizados, que podem ser comparados com dicionários ordenado, nele passamos alguns valores em ordem, a cada um e atribuído um valor segundo ordem. Por exemplo podemos criar um ``ENUM`` para criar um tipo que salva valores do clima, sendo *(ensolarado, nublado, chuvoso)*, com isto teremos o ensolarado com um valor 0, o nublado como 1, e o chuvoso com 2, assim podemos compara se um clima é maior que o outro, ou ordenar um tabela por clima.

### Outros

Existem outros tipos de dados aceitos nos **PostgreSQL**, porém não tem o uso tão comum como os descritos acima e alguns não são padrões de outros **SGBDs**, aqui será feito uma breve descrição destes formatos.

+ **Geográfico**

+ **Monetário**

+ **Endereço de rede**

+ **Bit String**

+ **Text Search**

+ **XML**

+ **JSON**

