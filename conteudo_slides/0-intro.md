# Fury

Todos slides devem conter a logomarca da Universidade de Caxias do Sul, sendo que na capa o logo deve ser [extenso](https://www.ucs.br/site/midia/arquivos/Logo-UCS-Horizontal_Branco.png), enquanto nso demais slides pode ser o [logo menor](https://www.ucs.br/site/midia/arquivos/Logo-UCS-Vertical-Reduzido-Branco.png)

## Slide Inicial (Capa):

Deve conter:
* `Disciplina:` Gerência de Configurações
* `Título:` Fury:
* `Subtítulo:` IDP do Mercado Livre
* `Integrantes:` Eduarda, Franco, Guilherme, Heitor, Henrique, Larissa e Luiz
* `Logo:` Citada no início do arquivo


## Slide 1: Introdução ao tema

Acredito que todos tenham noção do tamanho que é o Mercado Livre, porém as plataformas desenvolvidas por eles vão bem além de apenas um marketplace digital. Dentro do ecossistema do Meli existem outras empresas no ramo de ERP, logística e pagamento, por exemplo. Somando tudo, hoje são mais de 30 mil microserviços compondo todo este ecossistema, porém é importante lembrar que nem sempre foi assim, o software já foi moldado como um monolito.

## Slide 2: Contextualização

Com a migrança para a arquitetura baseada em microserviços surgiu um problema:**O controle disso**, que tanto pela equipe de suporte quanto pelas próprias equipes de desenvolvimento, era bastante custoso e muitas vezes falho. 

> Estrela da morte dos microsserviços estilizada nas cores do slide

## Slide 3: Objetivo Central

É neste contexto então que surge a plataforma de desenvolvimento Fury com o objetivo principal de **abstrair a complexidade** dos procedimentos de Build, Deploy e Virtualização, que vimos em aula para que o desenvolvedor se preocupe apenas com a implementação das regras de negócio e não com a infraestrutura.

> Destacar "Abstração da Complexidade"

## Slide 4: Funcionalidades Principais

Para além disso a plataforma também:

* oferece **componentes reutilizáves**, como para o acesso à banco de dados, que é feito por um serviço abstraído na plataforma Fury, e mantido por uma equipe dedicada exclusivamente para isso;
* **padroniza o ambiente**, permitindo a replicação e garantindo o comportamento entre o que é testado em desenvolvimento e o que é visto no ambiente de produção; e 
* simplicifica a **alocação de recursos e hospedagem** para os serviços desenvolvidos.

> Blocos com as principais funcionalidades

## Slide 5: Referência ao Dashboard

Por fim o Fury também traz um **dashboard administrativo**, permitindo que os líderes de cada equipe tenham acesso aos dados mais cruciais sobre a saúde do microserviço que estão desenvolvendo.

> Ilustração de um dashboard simplificado com gráficos de de consumo

## Fontes: Inclusas apenas no último slide

Plataforma Fury no Mercado Livre, Full Cycle, no Youtube em 24/08/2020. Disponível em https://www.youtube.com/watch?v=jhSoFPONQ5s

Conheça a IDP do Mercado Livre - Platform Talks, Plataform Rocks, no YouTube em 05/05/2025. Disponível em https://www.youtube.com/watch?v=aFJTxKak6sM, minutagem: 27:14 - 32:35