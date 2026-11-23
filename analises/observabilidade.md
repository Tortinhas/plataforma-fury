# Análise: Observabilidade

## 1. Observabilidade do Fury

### 1.1 Por que virou um problema de plataforma

O time de observabilidade descreve a situação assim:

- Em serviços de pagamento, um único fluxo pode envolver mais de 100 microsserviços e mais de 1.000 operações diferentes. Achar "o que está falhando e por quê" fica difícil sem contexto preservado entre os serviços.
- À medida que o Fury cresceu, surgiram **várias ferramentas** (de terceiros, open source e internas), com agentes e bibliotecas de instrumentação diferentes. Faltava um vocabulário comum entre sinais e ferramentas, o que dificultava correlacionar dados.
- O volume de telemetria cresceu junto com a plataforma, o que trouxe **custo** e **ruído**, e o ruído atrapalha a detecção e a resolução de incidentes.

Por isso criaram um time de plataforma dedicado, com dois focos: **enablement** (SDKs, agentes, coleta, armazenamento, ferramentas de exploração e treinamento) e **eficiência** (crescimento saudável das soluções, controle de custo e uso de recursos).

### 1.2 Como organizaram a solução

| Decisão | O que foi feito |
|---|---|
| Diagnóstico | Avaliação de maturidade de observabilidade, com metas e critérios (MTTx, instrumentação, correlação, visualização), feita com SRE e FinOps |
| Experiência "out of the box" | Instrumentação automática, visões pré-configuradas e alertas pré-configurados vindos da plataforma, com agentes de telemetria abstraídos |
| Padronização | Adoção do **OpenTelemetry** para ter dados próprios, convenções comuns e menos dependência de fornecedor |
| Sinais novos | **Tracing distribuído** e **profiling** (pontual e contínuo) |
| Visão unificada | "First Pane of Glass": ponto central de visibilidade entre fontes de telemetria |
| Governança | *Service framework* por ferramenta, com garantias, cotas de ingestão, armazenamento e retenção; amostragem e tratamento de *noisy neighbors* |
| Evitar sobreposição | Análise para escolher uma ferramenta por caso de uso, com diretrizes para não duplicar |

### 1.3 Escala (ordens de grandeza, com data)

- Time de observabilidade (artigo da MercadoLibre Tech): mais de **40 TB de logs por dia**, mais de **200 milhões de spans por minuto** e mais de **250 milhões de métricas por minuto**.
- Sessão com a Datadog: mais de 30.000 microsserviços em 100.000 instâncias, e o alerta de que o volume de telemetria gera ruído e perda de controle de custo.
- Caso Datadog (Black Friday): mais de 30.000 microsserviços e mais de 200.000 pods, com integração nativa em todas as aplicações via Fury. Segundo o estudo, a empresa sustentou 900 milhões de requisições por minuto, com carga até 40% maior, e 100% de uptime de infraestrutura .
- Plataforma de eventos de observabilidade ("O11y events", 2026): reconstruída sobre ClickHouse Cloud, chegou a 70 milhões de spans por minuto. Consultas de traces que levavam mais de cinco minutos passaram a cerca de quatro segundos (75 vezes mais rápido), e a compressão chega a até 89%.


## 2. Dashboards e custos

### 2.1 O que o Fury mostra ao desenvolvedor

Segundo a palestra da PlatformEngineering.org:

- O Fury oferece **dashboards-resumo** em que o desenvolvedor vê quanto está gastando (ou desperdiçando) em infraestrutura e recebe **estimativas de custo** de diferentes estratégias tecnológicas.
- A plataforma faz **recomendações automáticas** de melhoria de desempenho e permite aplicá-las sem afetar a disponibilidade.
- O fluxo de criação de um serviço inclui um passo de definição do *scope* (autoscaling, infraestrutura, tráfego, logging), com **sugestões da plataforma** sobre o que funciona melhor.

O resumo da sessão da QCon SF 2022 cita um mecanismo de "oportunidades" que sugere ou aplica atualizações (por exemplo, para vulnerabilidades críticas) e fala em gestão de custo integrada [9]. A sessão da QCon SF 2024 apresenta o modelo **NoOps** como automação de ponta a ponta, que inclui observabilidade completa e gestão de custos.

### 2.2 Custo em duas camadas

É útil separar, na apresentação:

1. **Custo do que roda** (computação): reduzido por mudanças como a migração do modelo *Standard* para o *Serverless* sobre Kubernetes.
2. **Custo de observar o que roda** (telemetria): controlado por cotas, amostragem, retenção por camada e escolha de armazenamento.

O ponto de GC é que **as duas camadas são configuração versionável e auditável** (cotas, retenção, parâmetros de escala), e não decisões informais de cada time.

---

## 3. Autoscaling

### 3.1 Evolução no Fury

Segundo o artigo sobre Kubernetes no Mercado Libre (lido na tradução publicada pela Flant):

- **Modelo *Standard* (2015 em diante):** instâncias de nuvem (EC2, Compute Engine), com cada réplica da aplicação em uma instância própria. O gerenciamento de autoscaling foi **implementado dentro do módulo de computação do Fury**, independente dos Auto Scaling Groups da AWS ou de recursos equivalentes de outras nuvens, justamente para ser multivendor.
- **Problemas que apareceram:** baixa eficiência (uma réplica por instância deixava espaço para reduzir custos mesmo com reservas, spot e ARM) e uso limitado dos recursos nativos dos provedores, por causa das abstrações.
- **Modelo *Serverless* (Kubernetes gerenciado, EKS e GKE):** o nome indica que o desenvolvedor não precisa saber de servidores. Um componente chamado Cluster API (diferente da API do Kubernetes) cria as peças de Kubernetes necessárias, incluindo **ReplicaSets e Horizontal Pod Autoscalers (HPA)**. A equipe preferiu ReplicaSets a Deployments porque as funções extras dos Deployments já existem na própria plataforma.
- **Escala citada no artigo:** mais de 130.000 instâncias, segmentadas por região, provedor e criticidade.

### 3.2 Como o estado é mantido consistente

O mesmo artigo descreve mecanismos que interessam para GC:

- Um controlador no cluster observa pods e nós e **reconcilia o estado do cluster com o estado externo mantido pela plataforma**, avisando o módulo Serverless de qualquer mudança.
- Em implantações blue-green, ao final a plataforma **atualiza seu estado interno** para refletir as duas versões, mantendo controle detalhado de ambas.
- A estratégia **safe deployment** acompanha métricas e decide rollback automático ou recomenda ajustes.
- A estratégia **migration** move cargas entre fornecedores, regiões ou modelos de computação conforme requisitos de resiliência e custo.
- Atualizações do plano de controle começam por clusters menos críticos e ambientes de teste e só depois chegam aos mais críticos. Para os componentes internos do motor de computação usam GitOps

---

## 4. Relação com Gerência de Configuração

### 4.1 O conceito: o que é o relatório de status da configuração

Em GC, a **contabilização de status** (*configuration status accounting*, CSA) é a atividade de registrar e reportar as informações necessárias para gerenciar o sistema: lista de itens de configuração aprovados, estado das mudanças propostas e implementação das mudanças aprovadas. A NASA o descreve como o registro de status, conteúdo e mudanças dos itens de configuração ao longo do ciclo de vida, e sugere incluir versão de cada item, se está em edição, quem mudou, quando e o que mudou, além do status de pedidos de mudança e relatos de problema. O SWEBOK coloca a CSA ao lado de identificação, controle, auditoria e gerência de releases.

### 4.2 Mapeamento proposto (interpretação do grupo)

| Conceito de GC | O que observamos no Fury
|---|---|
| **Item de configuração (CI)** | Aplicação, *scope* (autoscaling, infraestrutura, tráfego, logging), HPA, cotas e retenção de telemetria |
| **Identificação** | Criação do serviço a partir de opções pré-aprovadas, gerando repositório estruturado |
| **Controle de mudanças** | Pull request dispara validações, lint e métricas antes de criar a versão; estratégias de deploy com rollback; atualizações escalonadas por criticidade |
| **Baseline** | Versão implantada de cada serviço; blue-green mantém duas versões sob controle até a promoção |
| **Status accounting** | Dashboards, First Pane of Glass, estado interno da plataforma atualizado a cada deploy e reconciliado com o cluster |
| **Auditoria de configuração** | Reconciliação contínua entre estado real e estado esperado; centralização de auditoria e rollbacks no deploy |
| **Gerência de releases** | Estratégias de deploy (all-in, blue-green, canary, safe deployment, migration) |

---

## 5. Análise crítica e cuidados

**Pontos fortes**

- Governança embutida no caminho padrão (observabilidade, custo e escala já configurados na criação do serviço), com liberdade controlada.
- Padronização aberta (OpenTelemetry) que reduz dependência de fornecedor.
- Observabilidade com orçamento explícito, em vez de coletar tudo e descobrir o custo depois.

**Limites e riscos**

- **Dependência da própria plataforma.** Se o Fury é a fonte do estado, falhas ou lacunas dele afetam o registro de status e a auditoria. As fontes não discutem como validam o Fury com um mecanismo independente.
- **Amostragem e retenção são trocas.** Reter menos reduz custo, mas limita investigações antigas. O caso de 2026 mostra camadas com prazos diferentes.
- **Autoscaling mal calibrado** pode custar caro ou faltar capacidade no pico, como mostram os casos de Google e Microsoft.
- **Complexidade operacional.** O próprio time de observabilidade cita o problema de ferramentas sobrepostas e agentes múltiplos.

**Qualidade das fontes**

- Boa parte do material vem **da própria empresa ou de fornecedores parceiros** (Datadog, ClickHouse), com viés de divulgação. Os resultados de desempenho e disponibilidade são alegações dos autores e não passaram por avaliação independente.
- Os **números mudam entre fontes e anos** (por exemplo, 26.000, 30.000 e mais de 35.000 microsserviços; 100.000, 130.000 instâncias; 200.000 pods). Na apresentação, cite o número com a fonte e o ano.
- Uma fonte secundária (um artigo no Medium/Level Up sobre "plataforma para 10.000 engenheiros") traz métricas atribuídas a palestras, mas não conseguimos verificá-las em fonte primária. **Não foram usadas** neste documento.
- A tradução da Flant foi lida no lugar do original do Medium, que não pôde ser aberto automaticamente. Antes de entregar, **confira os trechos citados no artigo original**.

---
