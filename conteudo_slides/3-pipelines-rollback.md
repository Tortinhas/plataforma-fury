**Slide 1: Pipelines pré-configuradas — do código à produção**

No Fury, as pipelines automatizam etapas do desenvolvimento e ajudam as equipes a seguir um processo padronizado para **validar, construir e implantar aplicações**.

Esse fluxo pode ser resumido em quatro etapas:

1. **`Integração do código:`** a alteração é enviada para o repositório e entra no fluxo de integração.
2. **`Validação:`** o *Release Process* executa verificações de qualidade, como testes, cobertura de código, dependências e credenciais. Se uma checagem falha, o fluxo é interrompido até que o problema seja corrigido.
3. **`Build:`** o código validado é transformado em um artefato, como uma imagem Docker, que representa uma versão da aplicação.
4. **`Deploy:`** a versão é implantada em um ou mais ambientes, usando estratégias como *Blue-Green* ou *Canary*.

> **Elementos do slide:** título, descrição e quatro etapas com um resumo sintético. O artigo da equipe do Mercado Livre descreve sete validações automáticas no processo de integração. ([Fonte](https://medium.com/mercadolibre-tech/the-technological-evolution-at-mercado-libre-fb269776a4e8))

## **Slide 2: Relação com a Gerência de Configuração**

As pipelines e o rollback apoiam a **Gerência de Configuração** porque organizam versões, validações, implantações e formas de recuperar um estado anterior.

- **`Itens de configuração:`** código-fonte, dependências, artefatos gerados e configurações da aplicação.
- **`Baseline:`** versão validada que serve como referência para implantação e recuperação.
- **`Build e release:`** criação da versão e implantação são etapas separadas. O mesmo artefato pode ser implantado em diferentes ambientes sem ser reconstruído.
- **`Rollback:`** retorno a uma versão anterior estável quando uma falha ou anomalia é detectada.
- **`Estratégias de deploy:`** *Blue-Green* e *Canary* permitem controlar a liberação da nova versão e facilitar a reversão.

> **Elementos do slide:** título, descrição e um bloco para cada conceito, com um resumo sintético. ([Fonte 1](https://medium.com/mercadolibre-tech/the-technological-evolution-at-mercado-libre-fb269776a4e8); [Fonte 2](https://medium.com/mercadolibre-tech/30-000-deployments-per-day-heres-how-we-operate-without-losing-our-minds-0eddc0480fb9))

## **Slide 3: O impacto**

A automação é importante porque o Fury opera em grande escala e precisa validar e acompanhar muitas mudanças. Um artigo de 2024 da equipe do Mercado Livre menciona **25 mil pull requests abertos por semana** e **19 mil implantações por dia**. Em 2025, outro artigo da equipe relata cerca de **30 mil implantações diárias**. Os valores vêm de períodos diferentes e ajudam a ilustrar o crescimento da operação.

Com pipelines padronizadas e rollback, as equipes podem liberar mudanças com mais consistência e recuperar uma versão estável com rapidez. Isso contribui para **reduzir o trabalho manual** e aproxima a operação da ideia de **NoOps**.

> **Elementos do slide:** título, descrição e texto. À direita, sugerir uma ilustração de pipeline com uma seta que retorna da versão nova para a baseline estável. ([Fonte de 2024](https://medium.com/mercadolibre-tech/safe-but-flexible-the-devex-based-code-management-culture-at-mercado-libre-9b1dfde6f1b6); [Fonte de 2025](https://medium.com/mercadolibre-tech/30-000-deployments-per-day-heres-how-we-operate-without-losing-our-minds-0eddc0480fb9))
```
