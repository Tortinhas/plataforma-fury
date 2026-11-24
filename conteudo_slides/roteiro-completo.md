# Fury

## Dicas de design

- Todos slides devem conter a logomarca da Universidade de Caxias do Sul, sendo que na capa o logo deve ser [extenso](https://www.ucs.br/site/midia/arquivos/Logo-UCS-Horizontal_Branco.png), enquanto nso demais slides pode ser o [logo menor](https://www.ucs.br/site/midia/arquivos/Logo-UCS-Vertical-Reduzido-Branco.png)
- Máximo de 5 linhas de texto por bloco; o resto vai na fala.
- Usar o mesmo padrão visual dos outros temas (peçam o modelo ao colega que está consolidando).
- Adicionar o logo do Fury ou do Mercado Livre apenas no Slide 1.
- Citar as fontes no rodapé de cada slide e listar todas no slide final de referências do grupo.

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

## Slide 6: 1. Golden Paths: do zero à produção em 4 passos

Os *Golden Paths* são fluxos padronizados que orientam os desenvolvedores desde a criação de uma aplicação até sua publicação em produção.

Esse processo pode ser resumido em quatro etapas:

1. `Criação:` o desenvolvedor inicia uma aplicação utilizando **templates e configurações predefinidas**.
2. `Configuração:` o Fury disponibiliza **recursos de infraestrutura, ambientes e dependências** necessários para a aplicação.
3. `Build e validação:` o código passa por **processos automatizados de compilação, testes e verificações.**
4. `Deploy:` a aplicação é publicada na infraestrutura **gerenciada pela plataforma**, utilizando tecnologias como Kubernetes.

> Título + Descrição e bloco com o título de cada etapa e um resumo sintético

## Slide 7: Relação com Gerência de Configuração

O Fury aplica diversos conceitos de Gerência de Configuração de Software:

- `Itens de configuração:` código-fonte, dependências, arquivos de configuração e recursos de infraestrutura.
- `Baselines:` **configurações padronizadas** que servem como referência para as aplicações.
- `Gestão de ambientes:` **padronização dos ambientes** de desenvolvimento, testes e produção.
- `Infraestrutura como Código (IaC):` automatização e definição da infraestrutura por meio de configurações declarativas.

> Título + Descrição e bloco com o título de cada conceito e um resumo sintético

## Slide 8: O impacto:

Com isso, o Fury reduz configurações manuais, evita inconsistências entre ambientes e facilita a reprodução e manutenção das aplicações.

O principal benefício é permitir que os desenvolvedores foquem na **implementação das funcionalidades**, enquanto a plataforma automatiza grande parte da infraestrutura e garante padrões de configuração.

> Título, descrição e texto. À direita um desenho de um caminho dourado (na cor de destaque dos sldies)

## Slides 9-11: Repositórios, PRs e Auditoria Automática do código

Pendente.

## Slides 12-14: Pipelines Pré-Configuradas e Rollback Automático

Pendente.

## Slide 15: Mais microsserviços, menos visibilidade

- Monolito dividido em **mais de 26 mil microsserviços** [13]
- Difícil saber se cada time segue boas práticas e aplica atualizações [2]
- Fury (2015) nasceu com 3 objetivos [2]:
  - Economia
  - **Governança e controle**
  - **Segurança**

> Três ícones lado a lado (moeda, escudo, cadeado), com os dois últimos destacados.

**Rodapé:** Fontes: [2], [13]

---

## Slide 16: Governança embutida no fluxo de desenvolvimento

1. **Acesso ao código** [13]
   - Permissões por times
   - 4 níveis de visibilidade: público, interno, privado, bloqueado

2. **Pipeline como portão** [13]
   - Para chegar à branch estável: testes, boa cobertura, bibliotecas seguras e **sem segredos no código**

3. **Vulnerabilidades e deploy** [14][2]
   - A plataforma sugere ou aplica correções de falhas críticas
   - Auditoria, rollback e mudanças de segurança centralizados no deploy

> Um diagrama simples, da esquerda para a direita: `Acesso ao código → Pull request + verificações → Branch estável → Deploy → Correção de vulnerabilidades`

**Rodapé:** Fontes: [2], [13], [14]

---

## Slide 17: Fury na prática da GC

| Conceito de GC                    | No Fury                                    |
| --------------------------------- | ------------------------------------------ |
| Controle de acesso ao repositório | Times e níveis de visibilidade             |
| Controle de mudanças              | Pull requests com verificações automáticas |
| Baseline                          | Branch estável com critérios de entrada    |
| Auditoria de configuração         | Auditoria centralizada no deploy           |
| Mudança corretiva                 | Correção de vulnerabilidades críticas      |
| Retorno à baseline anterior       | Rollback centralizado                      |

**Frase de destaque (rodapé do slide):** _Controlled freedom_: padronização sem engessar os times [2]

**Rodapé:** Fontes: [2], [13], [14]. Conceitos de GC: ajustar aos termos da disciplina (e, se o grupo confirmar, [6] IEEE 828).

> Diagrama relacionando os conceitos com o que está presente na plataforma, com a frase em destaque na parte inferior do slide

## Slides 18-20: Observabilidade:

Pendente.

## Slide 21 -  O que o Fury tem a ver com Gerência de Configuração?

-   **Identificação:** aplicações, versões e recursos.
-   **Controle de mudanças:** repositórios, branches e pull requests.
-   **Padronização:** ambientes e configurações consistentes.
-   **Auditoria:** rastreabilidade e validações.
-   **Controle de releases:** pipelines e rollback.

**Referência:**\
IEEE. *IEEE Std 828-2012 --- Standard for Configuration Management in
Systems and Software Engineering.*

> Título e um bloco para cada tópico

## Slide 22 - Fury e a aproximação do NoOps

`NoOps:` redução da intervenção operacional manual.

-   **Automação de tarefas** de infraestrutura e implantação.
-   **Abstração da complexidade** por plataformas.
-   Mais **autonomia** para os desenvolvedores.
-   Operações continuam existindo, mas com **maior automação**.

**Relação com o Fury:** - Criação e configuração automatizada de
aplicações. - Infraestrutura abstraída pela plataforma e pelo
Kubernetes. - Implantação, escalabilidade e monitoramento integrados.

**Referência:**\
STEFANAC, Tommy; COLOMO-PALACIOS, Ricardo. *NoOps -- A Multivocal
Literature Review* (2022). DOI: 10.1016/j.procs.2021.12.002.

> Título no topo, NoOps e sua descrição no centro com os tópicos ao redor

## Slide 23 - O principal aprendizado

**GERÊNCIA DE CONFIGURAÇÃO**\
Controle · Organização · Rastreabilidade · Padronização

                  ↓

**FURY**\
Automação · Integração · Abstração · Escalabilidade

                 ↓

**MENOS TRABALHO OPERACIONAL MANUAL**\
Mais autonomia e foco no desenvolvimento

> Estruturar os tópicos (título e descrição) como um fluxo

### Slide 24: Frase de encerramento

> Gerenciar a configuração não é apenas controlar o código, mas todo o
> ambiente necessário para desenvolver, implantar e manter um software.


## Referências

### 1. How Kubernetes became the right fit for Mercado Libre’s internal developer platform

[Link](https://medium.com/mercadolibre-tech/how-kubernetes-became-the-right-fit-for-mercado-libres-internal-developer-platform-fb02df289def)

Mar. 2025 - Mercado Libre Tech

---

### 2. Scaling from 2K engineers to 12K engineers and 10K deploys per day

[Link](https://platformengineering.org/talks-library/scaling-from-2k-engineers-to-12k-engineers-and-10k-deploys-per-day)

Jan. 2023 - Platform Engineering

---

### 3. Podcast: Conheça o Fury do Mercado Livre

[Apple Podcasts](https://podcasts.apple.com/fi/podcast/16-conhe%C3%A7a-o-fury-do-mercado-livre/id1810894909?i=1000708823528) | 
[Spotify](https://open.spotify.com/episode/7z9G7h7Zv85dBi6ZvvBbgg?si=342a3618f2a64cbd)

Mai. 2025 - Platform Engineering

---

### 4. NoOps – A Multivocal Literature Review

[Link](https://doi.org/10.1016/j.procs.2021.12.002)

2022 - Procedia Computer Science (Tommy Stefanac & Ricardo Colomo-Palacios)

---

### 5. The Technological Evolution at Mercado Libre: From the Monolith to the Multicloud Platform

[Link](https://medium.com/mercadolibre-tech/the-technological-evolution-at-mercado-libre-fb269776a4e8)

2024 - Mercado Libre Tech (Juliano Marcos Martins)

---

### 6. IEEE Standard for Configuration Management in Systems and Software Engineering (IEEE Std 828-2012)

[Link](https://standards.ieee.org/ieee/828/5367/)

2012 - IEEE

---

### 7. Building a large-scale Observability Ecosystem

[Link](https://medium.com/mercadolibre-tech/building-a-large-scale-observability-ecosystem-1edf654b249e)

Mercado Libre Tech (Juan Pi)

---

### 8. How Mercado Libre rebuilt its observability platform on ClickHouse Cloud with 75x faster trace queries

[Link](https://clickhouse.com/ja/blog/mercado-libre-observability-on-clickhouse-cloud)

Ago. 2026 - ClickHouse

---

### 9. Mercado Libre ensures 100% infrastructure uptime during Black Friday with Datadog observability at scale

[Link](https://www.datadoghq.com/case-studies/mercado-libre)

Datadog (estudo de caso)

---

### 10. Scaling Innovation with NoOps: How Mercado Libre Manages 30,000 Microservices and 25 million RPS

[Link](https://qconsf.com/presentation/nov2024/scaling-innovation-noops-how-mercado-libre-manages-30000-microservices-and-25)

Nov. 2024 - QCon San Francisco (Juliano Martins & Marcelo Quadros)

---

### 11. The surprising economics of Horizontal Pod Autoscaling tuning

[Link](https://cloud.google.com/blog/products/containers-kubernetes/tuning-the-kubernetes-hpa-in-gke)

Google Cloud

---

### 12. Compute scaling in Azure Fluid Relay

[Link](https://devblogs.microsoft.com/microsoft365dev/compute-scaling-in-azure-fluid-relay/)

Microsoft 365 Developer Blog

---

### 13. Safe but flexible: the DevEx-based code management culture at Mercado Libre

[Link](https://medium.com/mercadolibre-tech/safe-but-flexible-the-devex-based-code-management-culture-at-mercado-libre-9b1dfde6f1b6)

Abr. 2024 - Mercado Libre Tech (Javi Cardoso)

---

### 14. Scaling from 2K Engineers to 12K Engineers and 10K Deploys/Day

[Link](https://qconsf.com/presentation/oct2022/scaling-2k-engineers-12k-engineers-and-10k-deploys-day)

Out. 2022 - QCon San Francisco (resumo da palestra)

---

### 15. Unveiling the secrets of a successful journey: Mercado Libre's internal developer platform

[Link](https://platformengineering.org/blog/unveiling-the-secrets-of-a-successful-journey-mercado-libres-internal-developer-platform)

Platform Engineering (blog)

---

### 16. GitHub Copilot Deployment at Scale: Enhancing Developer Productivity

[Link](https://www.zenml.io/llmops-database/github-copilot-deployment-at-scale-enhancing-developer-productivity)

ZenML (LLMOps Database) - fonte secundária, resume um caso do Mercado Livre com GitHub Advanced Security

---

### 17. Vídeo da palestra "Scaling from 2K engineers to 12K engineers and 10K deploys per day"

[YouTube](https://youtu.be/FNZFKelH530)

Platform Engineering - vídeo da palestra do item 2 (inclui o caso do Log4j)

---

### 18. Vídeo "Plataforma Fury no Mercado Livre, Full Cycle"

[Youtube](https://www.youtube.com/watch?v=jhSoFPONQ5s) em 24/08/2020

---

### 19. Vídeo "Conheça a IDP do Mercado Livre - Platform Talks, Plataform Rocks"

[YouTube](https://www.youtube.com/watch?v=aFJTxKak6sM) em 05/05/2025. Trecho: 27:14 - 32:35