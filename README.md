# script_estatistica_aplicada_2023_portfolio
Esse repositório serve como parte de um portfólio pessoal e tem o objetivo de demonstrar uma das minhas primeiras experiências práticas com R e estatística aplicada às Ciências Sociais.

#################################

# 📊 Portfólio - Estatística Aplicada em R

## 📋 Descrição do Projeto

Este projeto apresenta análises estatísticas bivariadas utilizando R, demonstrando a aplicação prática de três tipos principais de testes de hipóteses: análise tabular (chi-quadrado), teste de diferença de médias (teste-t) e análise de correlação/regressão linear.

Esse script foi feito baseado no curso de **Estatística Aplicada** e ele foi feito pouco depois da minha conclusão nessa disciplina (no final de 2023) com alguns dados diferentes dos usados pelo professor, para entender melhor a logica do R e das análises estatísticas.

- Manipulação e análise de dados em R
- Visualização de dados com ggplot2
- Interpretação de resultados estatísticos
- Comunicação de achados científicos

## 🗂️ Estrutura dos Arquivos

```
📁 Projeto R Portfolio eacs2/
│
├── 📊 ANES2016small.RData              # Dados eleitorais (para análise tabular)
├── 📈 liberal_democracy_index.csv      # Índice de democracia (Our World in Data)
├── 🌍 ti_corruption_perception_index.csv # Índice de percepção de corrupção (Transparency International)
├── 👩‍💼 women_political_empowerment_index.csv # Índice de empoderamento feminino (V-Dem Project)
├── 💻 testes-das-aulas-eacs2.R         # Script principal com todas as análises
└── 📖 README.md                        # Este arquivo
```

## 🔬 Análises Realizadas

### 1. **Análise Tabular - Chi-Quadrado**
- **Objetivo**: Verificar associação entre variáveis categóricas
- **Dados**: ANES 2016 (American National Election Studies)
- **Variáveis analisadas**:
  - Intenção de voto em Trump × Sindicalização domiciliar
  - Apoio a Trump × Gênero
- **Resultado**: Ambas as associações são estatisticamente significativas (p < 0.05)

### 2. **Teste de Diferença de Médias (Teste-t)**
- **Objetivo**: Comparar médias entre dois grupos
- **Dados**: Índice de Percepção de Corrupção 2022 (Transparency International)
- **Comparação**: América do Norte vs América do Sul
- **Países analisados**:
  - **América do Norte**: Estados Unidos, Canadá, México
  - **América do Sul**: Brasil, Chile, Argentina
- **Resultado**: América do Norte apresenta menor percepção de corrupção (p < 0.05)

### 3. **Correlação e Regressão Linear**
- **Objetivo**: Analisar relação entre democracia e empoderamento político feminino
- **Dados**: Índices de 2022 (Our World in Data + V-Dem Project)
- **Variáveis**:
  - **X (independente)**: Índice de Democracia Liberal
  - **Y (dependente)**: Índice de Empoderamento Político Feminino
- **Resultado**: Correlação positiva forte (r ≈ 0.8-0.9) e estatisticamente significativa

## 📈 Principais Visualizações

1. **Box plots** - Comparação de distribuições entre grupos
2. **Gráficos de densidade** - Distribuição das variáveis por categoria
3. **Gráficos de dispersão** - Relação entre variáveis contínuas
4. **Modelos de regressão** - Linha de tendência e capacidade preditiva

## 🛠️ Tecnologias Utilizadas

- **R** (versão 4.4.2)
- **RStudio** - Ambiente de desenvolvimento
- **Pacotes utilizados**:
  - `tidyverse` - Manipulação e visualização de dados
  - `gmodels` - Tabelas cruzadas e testes estatísticos
  - `ggplot2` - Visualizações avançadas (incluído no tidyverse)

## 📊 Resultados Principais

### Chi-Quadrado
- ✅ Associação significativa entre voto em Trump e sindicalização (χ² = 6.17, p = 0.013)
- ✅ Associação significativa entre apoio a Trump e gênero (χ² = 19.73, p < 0.001)

### Teste-t
- 🇺🇸 **América do Norte**: Média = 60.8 (DP = 21.7)
- 🇧🇷 **América do Sul**: Média = 48.3 (DP = 14.7)
- ✅ Diferença estatisticamente significativa (p < 0.05)

### Correlação/Regressão
- 📈 **Correlação de Pearson**: r ≈ 0.8-0.9 (p < 0.001)
- 📊 **R² do modelo**: > 0.7 (alta capacidade explicativa)
- 🎯 **Interpretação**: Países mais democráticos tendem a ter maior empoderamento político feminino

## 🌐 Fontes dos Dados

- **[Our World in Data](https://ourworldindata.org/)** - Índices de democracia e empoderamento feminino
- **[Transparency International](https://www.transparency.org/)** - Índice de Percepção de Corrupção
- **[V-Dem Project](https://www.v-dem.net/)** - Dados sobre democracia e empoderamento
- **[ANES](https://electionstudies.org/)** - American National Election Studies 2016

## 🚀 Como Executar

1. **Instalar dependências**:
   ```r
   install.packages(c("tidyverse", "gmodels"))
   ```

2. **Carregar os dados**:
   ```r
   # Definir diretório de trabalho
   setwd("caminho/para/sua/pasta")
   
   # Carregar arquivo R
   load("ANES2016small.RData")
   ```

3. **Executar o script**:
   ```r
   source("testes-das-aulas-eacs2.R")
   ```

Este projeto permitiu desenvolver:
- **Competências técnicas**: Manipulação de dados, testes estatísticos, visualização
- **Pensamento analítico**: Interpretação de resultados e comunicação científica
- **Boas práticas**: Organização de código, documentação e reprodutibilidade

Essa foi uma das minhas primeiras experiências com o R, com o codigo baseado no que vimos nas aulas, mas com adaptações para os dados diferentes.

## 👨‍💻 Autor

**Diego Amorim**  
Estudante de Ciências Sociais - Universidade Federal de Goiás (UFG)  
Disciplina: Estatística Aplicada às Ciências Sociais II  
Professor: Gabriel Madeira
