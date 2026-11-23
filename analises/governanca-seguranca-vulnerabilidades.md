Governança, Segurança e Gestão de Vulnerabilidades

## 1. Resumo em uma frase

O Fury transforma governança e segurança em parte do fluxo normal de desenvolvimento: o acesso ao código é controlado por times, a pipeline só deixa o código chegar à branch estável se ele cumprir critérios de qualidade e segurança, e a plataforma centraliza auditoria, rollback e correção de vulnerabilidades, sem depender de cada time fazer tudo manualmente [1][2].

---

## 2. Contexto: por que isso virou um problema

- O Mercado Livre começou com um monolito em Java. Por volta de 2010 ele já não dava conta: os deploys geravam erros e os rollbacks eram frequentes [2].
- A solução foi quebrar o monolito em microsserviços, o que trouxe agilidade, mas também **mais carga cognitiva** para os desenvolvedores [2].
- Com muitos serviços, **governança, compliance e segurança ficaram prejudicados**: era difícil saber de relance se os times seguiam boas práticas ou aplicavam atualizações corretamente [2].
- Em 2015 nasceu o Fury, com **três objetivos**: economizar dinheiro, melhorar governança e controle, e melhorar a segurança [2].

**Escala (para contextualizar):**

| Indicador                        | Valor                                              | Fonte    |
| -------------------------------- | -------------------------------------------------- | -------- |
| Microsserviços                   | mais de 26 mil                                     | [1]      |
| Pull requests abertos por semana | 25 mil                                             | [1]      |
| Deploys por dia                  | 19 mil (artigo de 2024); a palestra fala em 10 mil | [1], [2] |
| Repositórios no GitHub           | 26 mil                                             | [1]      |
| Pessoas em tecnologia            | cerca de 15 mil (2024)                             | [1]      |

---

## 3. Como o Fury implementa governança e segurança

### 3.1 Controle de acesso ao código (AuthN/AuthZ) [1]

Com 26 mil repositórios e 15 mil desenvolvedores, dar acesso a tudo para todos seria um risco. O que o Mercado Livre faz:

- **Autenticação:** restrição de acesso por lista de IPs permitidos e uso do recurso _Enterprise Managed Users_ (EMU) do GitHub, que controla todo o ciclo de vida do usuário (criação, convite, remoção).
- **Autorização por times:** os times do GitHub espelham a estrutura organizacional. Um time de 100 pessoas, por exemplo, acessa apenas os seus 200 repositórios.
- **Autorização por visibilidade (inner sourcing):** quatro níveis de repositório:
  - **públicos:** contribuição para open source;
  - **internos:** visíveis a toda a empresa, incentivam colaboração;
  - **privados:** só para o time dono;
  - **bloqueados:** muito sensíveis, só desenvolvedores autorizados.
- **Especialistas por tecnologia:** times de especialistas podem recomendar, por exemplo, atualizar um SDK ou parar de usar uma biblioteca, aplicando boas práticas em toda a empresa.

### 3.2 Pipelines padrão como "portão de qualidade" [1][2]

Independentemente da linguagem (o artigo cita Java e Golang) ou do modelo de branches (gitflow ou trunk-based), existe uma **branch estável**, que representa o código pronto para produção. Para chegar nela, o código precisa cumprir critérios [1]:

- alta cobertura de testes;
- todos os testes passando;
- uso apenas de bibliotecas seguras e estáveis;
- **nenhum segredo fixo no código (hard-coded secrets)**;
- poucos _code smells_ e más práticas.

Esses critérios **evoluem com o tempo**. Para apoiá-los, o Fury oferece blocos que tratam de cobertura, qualidade de código, **dependências** e **avaliação de vulnerabilidades**, além de ferramentas de _shift left_, como _pre-commit hooks_ e proteção contra o envio acidental de dados sensíveis [1].

Na palestra, o fluxo "do zero à produção" mostra o mesmo princípio: ao abrir um pull request, disparam-se automaticamente verificações de qualidade, validação, linting e métricas, **antes** de a versão ser criada [2].

### 3.3 Release Process (CI/CD próprio) e deploy centralizado [1][2]

- O **Release Process** é o sistema de CI/CD proprietário do Fury. Ele cuida da criação de versões e prepara o deploy **Blue-Green** (uma das estratégias de deploy disponíveis) com uma ação de dois cliques [1].
- O **Deployment Service** orquestra diferentes estratégias de deploy [1].
- Como o deploy passa sempre pela plataforma, o Mercado Livre consegue **centralizar práticas como auditoria, rollbacks e mudanças de segurança** [2].
- Existem também repositórios de artefatos (para dependências) e um _Building System_ que constrói e armazena os pacotes das aplicações [1].

### 3.4 Gestão de vulnerabilidades e dependências [3][2]

- Na palestra do QCon (2022), o time descreve um mecanismo que **sugere ou aplica atualizações para vulnerabilidades críticas**, além de otimização de custos e outras melhorias (as _opportunities_) [3].
- A mesma palestra fala em **sidecars** que dão mais controle de segurança, compliance e NoOps a cada microsserviço [3].
- O resumo da palestra na PlatformEngineering.org informa que ela mostra como o Mercado Livre usou o Fury para **lidar com a vulnerabilidade do Log4j** em larga escala [2]. O texto não traz detalhes; eles estão no vídeo [6].

### 3.5 Ferramentas de terceiros que complementam [5]

- O Mercado Livre usa **GitHub Enterprise** com **GitHub Advanced Security**, que inclui _secret scanning_ e roda automaticamente em segundo plano [5]. Isso é ferramenta do GitHub integrada ao fluxo, **não** uma funcionalidade nativa do Fury.

### 3.6 O equilíbrio entre liberdade e controle [1][2][4]

- A palestra destaca o conceito de **_controlled freedom_**: há um _trade-off_ entre liberdade do desenvolvedor e controle central, e equilibrar os dois aumenta a adoção [2].
- O Fury suporta 10 tipos de aplicação e 11 linguagens, e a ideia é padronizar o fluxo sem engessar as escolhas [1].
- Em casos de borda (sandboxes, provas de conceito, integrações não validadas), a recomendação é usar infraestrutura como código, treinamento e suporte para impor o máximo de estrutura possível [2].
- A adoção foi incentivada por **valor percebido**, não por imposição: a plataforma foi apresentada como algo melhor do que o que os times faziam sozinhos [2][4].
- Os desenvolvedores continuam responsáveis pela operação e pelo uptime dos seus apps; a plataforma só abstrai o trabalho de DevOps [4]. Isso é importante para o conceito de NoOps do fechamento.

---

## 4. Relação com os conceitos de Gerência de Configuração

| Conceito de GC                                            | Como aparece no Fury                                                                                             |
| --------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| **Controle de acesso à biblioteca de controle de versão** | AuthN/AuthZ por times, EMU, IP allowlist, níveis de visibilidade dos repositórios [1]                            |
| **Controle de mudanças**                                  | Todo código novo entra por pull request, com verificações automáticas antes de gerar a versão [2]                |
| **Baseline**                                              | A branch estável só recebe código que cumpre os critérios (testes, cobertura, libs seguras, sem segredos) [1]    |
| **Auditoria de configuração**                             | Verificações automáticas e auditoria centralizada no deploy, com rastreabilidade do que foi para produção [1][2] |
| **Gestão de dependências / itens de configuração**        | Repositórios de artefatos, SDKs oficiais, recomendação de atualizar ou abandonar bibliotecas [1]                 |
| **Mudança corretiva**                                     | Atualizações de vulnerabilidades críticas sugeridas ou aplicadas pela plataforma (ex.: caso Log4j) [2][3]        |
| **Retorno a uma baseline anterior**                       | Rollback centralizado no deploy [2]                                                                              |
| **Padronização e compliance**                             | Pipelines padrão, critérios que evoluem, infraestrutura como código para casos de borda [1][2]                   |

---

## 5. Pontos críticos e limitações

- **Liberdade vs. controle:** padronizar demais pode atrapalhar, e de menos enfraquece a governança. A própria empresa reconhece que não há regra universal [2].
- **A plataforma não cobre todos os casos:** casos de borda exigem modelos de governança específicos [2].
- **Dependência de ferramentas de terceiros** (GitHub): parte da segurança vem dessas ferramentas [1][5].
- **Adoção:** a plataforma precisa de suporte, treinamento e gestão de conhecimento, e não só de tecnologia [2].
- **Fontes por data:** parte do material é de 2022 a 2024, e funcionalidades podem ter mudado.

---

## 6. Referências

[1] CARDOSO, Javi. **Safe but flexible: the DevEx-based code management culture at Mercado Libre.** Mercado Libre Tech (Medium), 11 abr. 2024. Disponível em: https://medium.com/mercadolibre-tech/safe-but-flexible-the-devex-based-code-management-culture-at-mercado-libre-9b1dfde6f1b6

[2] PLATFORMENGINEERING.ORG. **Scaling from 2K engineers to 12K engineers and 10K deploys per day.** Palestra com Lucia Brizuela e Juliano Martins. Disponível em: https://platformengineering.org/talks-library/scaling-from-2k-engineers-to-12k-engineers-and-10k-deploys-per-day

[3] QCON SAN FRANCISCO. **Scaling from 2K Engineers to 12K Engineers and 10K Deploys/Day.** Resumo da palestra, out. 2022. Disponível em: https://qconsf.com/presentation/oct2022/scaling-2k-engineers-12k-engineers-and-10k-deploys-day

[4] PLATFORMENGINEERING.ORG. **Unveiling the secrets of a successful journey: Mercado Libre's internal developer platform.** Disponível em: https://platformengineering.org/blog/unveiling-the-secrets-of-a-successful-journey-mercado-libres-internal-developer-platform

[5] ZENML. **GitHub Copilot Deployment at Scale: Enhancing Developer Productivity** (caso do Mercado Livre, LLMOps Database). Disponível em: https://www.zenml.io/llmops-database/github-copilot-deployment-at-scale-enhancing-developer-productivity

[6] PLATFORMENGINEERING.ORG. **Vídeo da palestra** (Log4j e demais detalhes). Disponível em: https://youtu.be/FNZFKelH530
