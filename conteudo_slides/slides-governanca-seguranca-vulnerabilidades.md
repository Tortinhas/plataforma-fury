# Sugestão de slides: Governança, Segurança e Gestão de Vulnerabilidades no Fury

## Slide 1: Por que governança e segurança?

**Título:** Mais microsserviços, menos visibilidade

**Conteúdo:**

- Monolito dividido em **mais de 26 mil microsserviços** [13]
- Difícil saber se cada time segue boas práticas e aplica atualizações [2]
- Fury (2015) nasceu com 3 objetivos [2]:
  - Economia
  - **Governança e controle**
  - **Segurança**

**Sugestão visual:** três ícones lado a lado (moeda, escudo, cadeado), com os dois últimos destacados.

**Rodapé:** Fontes: [2], [13]

---

## Slide 2: Como o Fury resolve

**Título:** Governança embutida no fluxo de desenvolvimento

**Conteúdo (3 colunas ou 3 blocos):**

1. **Acesso ao código** [13]
   - Permissões por times
   - 4 níveis de visibilidade: público, interno, privado, bloqueado

2. **Pipeline como portão** [13]
   - Para chegar à branch estável: testes, boa cobertura, bibliotecas seguras e **sem segredos no código**

3. **Vulnerabilidades e deploy** [14][2]
   - A plataforma sugere ou aplica correções de falhas críticas
   - Auditoria, rollback e mudanças de segurança centralizados no deploy

**Sugestão visual:** um diagrama simples, da esquerda para a direita:
`Acesso ao código → Pull request + verificações → Branch estável → Deploy → Correção de vulnerabilidades`

**Rodapé:** Fontes: [2], [13], [14]

---

## Slide 3: Relação com Gerência de Configuração

**Título:** Fury na prática da GC

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

---

## Opção reduzida (se o grupo só tiver espaço para 1 ou 2 slides)

- **1 slide:** usar o Slide 2 com uma faixa no topo com os 3 objetivos do Fury e, embaixo, uma linha com os conceitos de GC (controle de mudanças, baseline, auditoria, retorno à baseline).
- **2 slides:** juntar os Slides 1 e 2 (problema + 3 pilares) e manter o Slide 3 (tabela de GC).

---

## Dicas de design

- Máximo de 5 linhas de texto por bloco; o resto vai na fala.
- Usar o mesmo padrão visual dos outros temas (peçam o modelo ao colega que está consolidando).
- Se houver espaço, adicionar o logo do Fury ou do Mercado Livre apenas no Slide 1.
- Citar as fontes no rodapé de cada slide e listar todas no slide final de referências do grupo.

---

## Referências usadas nos slides

(Numeração conforme `referencias.md`)

- [2] Scaling from 2K engineers to 12K engineers and 10K deploys per day, Platform Engineering. https://platformengineering.org/talks-library/scaling-from-2k-engineers-to-12k-engineers-and-10k-deploys-per-day
- [13] Cardoso, J. Safe but flexible: the DevEx-based code management culture at Mercado Libre, Mercado Libre Tech (Medium), abr. 2024. https://medium.com/mercadolibre-tech/safe-but-flexible-the-devex-based-code-management-culture-at-mercado-libre-9b1dfde6f1b6
- [14] Scaling from 2K Engineers to 12K Engineers and 10K Deploys/Day, QCon San Francisco, out. 2022. https://qconsf.com/presentation/oct2022/scaling-2k-engineers-12k-engineers-and-10k-deploys-day
