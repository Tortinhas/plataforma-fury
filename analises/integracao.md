# Fechamento: Fury e Gerência de Configuração

## 1. Base Tecnológica (Artigos do Mercado Livre)

* **Do Monólito à Plataforma Multicloud (Martins, 2024):** A migração para microsserviços aumentou a complexidade de configurações e ambientes. Criado em 2015, o Fury centralizou ferramentas em autosserviço com padronização tecnológica, containers, **Scopes** (separação de ambientes e estratégias de deploy) e o fluxo de **Release** (validações automáticas de qualidade e segurança em mais de 26 mil repositórios).
* **Adoção do Kubernetes (Martins, 2025):** A transição do modelo *Standard* (uma instância por réplica) para clusters gerenciados de Kubernetes (EKS e GKE) otimizou o uso de recursos, a escalabilidade automática e a portabilidade multicloud, mantendo a infraestrutura abstraída dos desenvolvedores.

## 2. Conexão com a Norma IEEE 828-2012

Embora os artigos não declarem conformidade formal, o Fury materializa na prática os processos fundamentais da norma:

| Processo da IEEE 828-2012 | Como aparece no Fury |
| :--- | :--- |
| **Identificação de itens** | Organização padronizada de aplicações, repositórios, versões, containers e recursos. |
| **Baselines e padronização** | Templates predefinidos, componentes reutilizáveis e ambientes replicáveis. |
| **Controle de mudanças e auditoria** | Fluxos via Git, branches, pull requests e validações automáticas no processo de *Release*. |
| **Gerência de builds, releases e ambientes** | Pipelines de CI/CD automatizadas e *Scopes* (desenvolvimento, teste e produção). |
| **Controle de status** | Monitoramento contínuo por meio de métricas, logs, alertas e dashboards. |

## 3. Integração com os temas citados em aula 

1. **Golden Paths (do zero à produção):** Padroniza baselines e infraestrutura como código, reduzindo divergências entre aplicações e ambientes.
2. **Repositórios, PRs e auditoria automática:** Garante controle de versão, revisão e rastreabilidade com checagens automáticas de dependências, cobertura de código e credenciais.
3. **Pipelines pré-configuradas e rollback:** Controla builds e entregas (incluindo *Blue-Green Deployment*), permitindo retorno rápido a versões estáveis conhecidas.
4. **Governança e segurança:** Aplica políticas globais de controle de acesso, verificação de vulnerabilidades e bloqueio de segredos expostos no código.
5. **Observabilidade, custos e autoscaling:** Garante visibilidade do estado dos itens em produção e ajuste dinâmico de recursos computacionais.