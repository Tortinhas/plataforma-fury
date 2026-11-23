# Análise: NoOps 

**Artigo base:** *NoOps – A Multivocal Literature Review* — Tommy Stefanac e Ricardo Colomo-Palacios (*Procedia Computer Science*, v. 196, p. 167–174, 2022).  
**DOI:** https://doi.org/10.1016/j.procs.2021.12.002

---

## 1. O que é NoOps?

O conceito de **NoOps** (*No Operations*) parte da evolução da infraestrutura tradicional para ambientes em nuvem nos quais tarefas operacionais repetitivas são automatizadas ou abstraídas por plataformas e serviços gerenciados (como arquiteturas *serverless* e automações apoiadas por IA).

O objetivo não é extinguir o trabalho operacional, mas deslocá-lo para provedores de nuvem e plataformas internas para que as equipes de desenvolvimento concentrem esforços na criação e evolução do produto.

## 2. Principais Benefícios e Desafios

* **Benefícios:** redução de tarefas manuais repetitivas, maior velocidade de entrega, melhor aproveitamento da escalabilidade em nuvem e foco no desenvolvimento de software.
* **Desafios:** necessidade de planejar e manter a automação, supervisão contínua em sistemas críticos, dependência de plataformas/provedores e exigência de processos maduros de segurança e monitoramento.

## 3. Relação entre NoOps e o Fury

Criado pelo Mercado Livre em 2015 como uma plataforma interna de autosserviço, o **Fury** aproxima a empresa dos princípios de NoOps ao abstrair a complexidade da infraestrutura para os desenvolvedores, oferecendo:

* Criação padronizada de aplicações e repositórios.
* Pipelines automatizadas de integração e entrega contínua (CI/CD).
* Provisionamento de ambientes (desenvolvimento, teste e produção).
* Escalabilidade, monitoramento e abstração de múltiplos provedores de nuvem.

**Obs:** o Mercado Livre não opera em um modelo de "NoOps puro". Equipes especializadas continuam desenvolvendo, mantendo e evoluindo o próprio Fury. Na prática, a plataforma reduz ao máximo a intervenção operacional manual no dia a dia dos desenvolvedores.

## 4. Ideia Principal 

> **NoOps não significa deixar de ter operações, mas reduzir a intervenção manual por meio da automação e da abstração da infraestrutura** — papel cumprido pelo Fury ao permitir que desenvolvedores criem, implantem e monitorem aplicações sem gerenciar servidores diretamente.