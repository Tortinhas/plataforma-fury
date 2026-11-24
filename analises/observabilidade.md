# Análise: Observabilidade

---

## 1. O que é observabilidade

Observabilidade é a capacidade de entender um sistema "por fora", fazendo perguntas sobre ele sem precisar conhecer seu funcionamento interno. Ela ajuda a investigar problemas novos e a responder "por que isso está acontecendo?".

Para isso, a aplicação precisa ser instrumentada, ou seja, emitir sinais como **traces, métricas e logs**. Uma aplicação está bem instrumentada quando os desenvolvedores não precisam adicionar mais instrumentação para investigar um problema, porque já têm todas as informações.

Em arquiteturas de microsserviços isso pesa ainda mais. No Mercado Livre, um único fluxo de pagamento pode passar por mais de 100 microsserviços e mais de 1.000 operações diferentes. Sem contexto compartilhado entre os serviços, achar a causa de uma falha é difícil.

---

## 2. Observabilidade no Fury

### 2.1 Tratada como plataforma, não como ferramenta

Com o crescimento do Fury, surgiram várias ferramentas de observabilidade (de terceiros, open source e internas), com agentes e bibliotecas de instrumentação diferentes. Faltava um vocabulário comum, o que dificultava correlacionar dados. O volume de telemetria também trouxe custo e ruído, que atrapalham a detecção e a resolução de incidentes.

A resposta foi criar um **time de plataforma dedicado**, com dois focos:

- **Enablement:** SDKs, agentes, coleta, armazenamento, ferramentas de exploração e treinamento.
- **Eficiência:** crescimento saudável das soluções, controle de custo e uso de recursos.

As principais decisões descritas pelo time:

| Decisão | O que foi feito |
|---|---|
| Diagnóstico | Avaliação de maturidade de observabilidade, feita com SRE e FinOps |
| Experiência pronta | Instrumentação automática, visões e alertas pré-configurados, com agentes abstraídos |
| Padronização | Adoção do **OpenTelemetry**, para ter convenções comuns e menos dependência de fornecedor |
| Sinais novos | Tracing distribuído e profiling |
| Visão unificada | "First Pane of Glass": um ponto central de visibilidade entre as fontes de telemetria |
| Governança da telemetria | Cotas de ingestão, armazenamento e retenção, amostragem e tratamento de *noisy neighbors* |
| Evitar sobreposição | Uma ferramenta por caso de uso, com diretrizes |

### 2.2 Escala

Os números abaixo variam conforme a fonte e o ano, então vale citar sempre a origem:

- O time de observabilidade fala em mais de **40 TB de logs por dia**, mais de **200 milhões de spans por minuto** e mais de **250 milhões de métricas por minuto**.
- Em 2026, a plataforma de eventos de observabilidade foi reconstruída sobre ClickHouse Cloud e chegou a **70 milhões de spans por minuto**. Consultas de traces que levavam mais de cinco minutos passaram a cerca de quatro segundos, e a compressão chega a até 89%.

### 2.3 Custo da telemetria como decisão de arquitetura

O projeto de 2026 mostra como custo e retenção viram escolhas de projeto:

- Amostragem de **100% do tráfego de aplicações críticas**.
- Camadas de dados com prazos diferentes: dados brutos por 1 dia, spans por 30 dias e métricas por 90 dias.
- Um dos requisitos foi a **escala sustentável**: o custo da observabilidade não deveria crescer na mesma proporção do negócio.

### 2.4 Dashboards e custo para o desenvolvedor

O Fury oferece dashboards-resumo em que o desenvolvedor vê **quanto está gastando ou desperdiçando** em infraestrutura. A plataforma também dá estimativas de custo de diferentes estratégias tecnológicas e faz recomendações automáticas de melhoria, que podem ser aplicadas sem afetar a disponibilidade.

Esse é um ponto central: o custo não fica restrito a uma área financeira, ele aparece para quem toma as decisões técnicas.

### 2.5 Autoscaling

O autoscaling do Fury mudou junto com a arquitetura de computação:

- **Modelo *Standard* (desde 2015):** instâncias de nuvem, com cada réplica da aplicação em uma instância própria. O autoscaling foi implementado **dentro do módulo de computação do Fury**, independente dos recursos de cada nuvem, para ser multivendor.
- **Problemas:** baixa eficiência (uma réplica por instância deixava espaço para reduzir custos) e uso limitado dos recursos nativos de cada provedor.
- **Modelo *Serverless*, sobre Kubernetes gerenciado (EKS e GKE):** a plataforma cria os objetos de Kubernetes necessários, incluindo **ReplicaSets e Horizontal Pod Autoscalers (HPA)**, e o desenvolvedor não precisa lidar com servidores.
- **Escala citada:** mais de 130.000 instâncias, segmentadas por região, provedor e criticidade.

### 2.6 Calibrar o autoscaling (material complementar)

As fontes do Mercado Livre não detalham como ajustar a escala. A literatura complementar mostra por que isso importa:

- A mesma aplicação tem custo e desempenho diferentes conforme a **meta de utilização de CPU do HPA** e os *resource requests* dos pods. Uma meta baixa parece segura, mas pode custar mais.
- HPA e Cluster Autoscaler trabalham juntos. Em um caso da Microsoft, requests mal dimensionados e `maxReplicas` inalterado atrapalharam o escalonamento de nós no pico, e requests altos demais impediam o *scale-in* fora do pico. A solução envolveu ajustar requests com base em percentis de uso e monitorar.

---

## 3. Benefícios para as equipes

1. **Visibilidade do que está em produção.** Telemetria padronizada, visões e alertas prontos permitem investigar falhas sem montar tudo do zero.
2. **Consciência de custo.** Gasto e desperdício aparecem em dashboards, com estimativas e recomendações.
3. **Escala sem lidar com servidores.** A plataforma cria o HPA, e a migração para Kubernetes buscou mais eficiência e menor custo.
4. **Estabilidade em picos.** Segundo um estudo de caso da Datadog, a plataforma sustentou 900 milhões de requisições por minuto na Black Friday, com carga até 40% maior e 100% de uptime de infraestrutura. É uma alegação do fornecedor, sem avaliação independente.
5. **Menos intervenção operacional.** Observabilidade e custos automatizados fazem parte da proposta de NoOps do Mercado Livre, segundo o resumo da palestra na QCon SF 2024.
