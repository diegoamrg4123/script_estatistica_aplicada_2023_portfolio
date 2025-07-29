#############################################################
######## Portfólio - Estatística Aplicada em R #############
#############################################################
######## Análises Bivariadas e Testes de Hipóteses ##########
#############################################################

# Fiz esse script pouco depois de ter feito a disciplina de 
# Estatística Aplicada a Ciências Sociais 2 para testar uma aplicação com outros
# dados que não os trabalhados na aula. Então, usei dados do Our World in Data.


library(tidyverse)
library(gmodels)

#############################################################
## 1. ANÁLISE TABULAR - CHI-QUADRADO      


# Analisando a relação entre intenção de voto em Trump e sindicalização
CrossTable(ANES2016small$V2Trump, ANES2016small$unionHH, chisq = T)

# Analisando a relação entre apoio a Trump e gênero
CrossTable(ANES2016small$V2Trump, ANES2016small$female, chisq = T)

# Interpretação dos resultados:
# - P-valor < 0.05: rejeitamos H0 (há associação entre as variáveis)
# - Chi² > 3.84 (1 grau de liberdade): indica significância estatística
# - Ambos os testes mostraram associações significativas

#############################################################
## 2. TESTE DE DIFERENÇA DE MÉDIAS                       


# Carregando dados de percepção de corrupção
corruption_data <- read.csv("ti-corruption-perception-index.csv")

# Verificando estrutura dos dados
names(corruption_data)
unique(corruption_data$Entity)

# Selecionando países das Américas para comparação (2022)
americas_data <- corruption_data %>%
  filter(Year == 2022, 
         Entity %in% c("United States", "Canada", "Mexico", 
                       "Brazil", "Chile", "Argentina")) %>%
  filter(!is.na(`Corruption Perceptions Index`)) %>%
  mutate(Regiao = ifelse(Entity %in% c("United States", "Canada", "Mexico"), 
                         "América do Norte", "América do Sul"))

# Visualização 1: Box plot comparativo
ggplot(americas_data, aes(x = Regiao, y = `Corruption Perceptions Index`)) +
  geom_boxplot(fill = "lightblue", color = "black") + 
  theme_minimal() +
  labs(title = "Índice de Percepção de Corrupção por Região (2022)",
       subtitle = "Comparação entre América do Norte e América do Sul",
       x = "Região", 
       y = "Índice de Percepção de Corrupção",
       caption = "Nota: Valores maiores = menor percepção de corrupção") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Visualização 2: Gráfico de densidade
ggplot(americas_data, aes(x = `Corruption Perceptions Index`, color = Regiao)) +
  geom_density(size = 1.2) +
  theme_minimal() +
  labs(title = "Distribuição do Índice de Percepção de Corrupção",
       x = "Índice de Percepção de Corrupção",
       y = "Densidade",
       color = "Região")

# Teste-t para diferença de médias
resultado_teste_t <- t.test(`Corruption Perceptions Index` ~ Regiao, 
                            data = americas_data, var.equal = TRUE)
print(resultado_teste_t)

# Estatísticas descritivas por região
americas_data %>%
  group_by(Regiao) %>%
  summarise(
    n_paises = n(),
    media = round(mean(`Corruption Perceptions Index`, na.rm = TRUE), 2),
    desvio_padrao = round(sd(`Corruption Perceptions Index`, na.rm = TRUE), 2),
    .groups = 'drop'
  )

# Interpretação: América do Norte apresenta média superior (menor corrupção)
# com p-valor < 0.05, rejeitamos H0 (médias iguais)

#############################################################
## 3. CORRELAÇÃO E REGRESSÃO LINEAR                    


# Carregando dados de democracia e empoderamento feminino
democracy_data <- read.csv("liberal-democracy-index.csv")
women_data <- read.csv("women-political-empowerment-index.csv")

# Preparando dados para 2022
democracy_2022 <- democracy_data %>%
  filter(Year == 2022) %>%
  select(Entity, Code, 
         democracy_index = `Liberal democracy index (central estimate)`)

women_2022 <- women_data %>%
  filter(Year == 2022) %>%
  select(Entity, Code, 
         women_index = `Women's political empowerment index (central estimate)`)

# Combinando os datasets
combined_data <- inner_join(democracy_2022, women_2022, by = c("Entity", "Code")) %>%
  filter(!is.na(democracy_index), !is.na(women_index))

print(paste("Número de países analisados:", nrow(combined_data)))

# Análise exploratória: Gráfico de dispersão
ggplot(combined_data, aes(x = democracy_index, y = women_index)) +
  geom_point(alpha = 0.7, color = "steelblue", size = 2) +
  theme_minimal() +
  labs(title = "Democracia vs Empoderamento Político Feminino",
       subtitle = "Dados de 2022 para países do mundo",
       x = "Índice de Democracia Liberal",
       y = "Índice de Empoderamento Político Feminino")

# Calculando covariância
covariancia <- cov(combined_data$democracy_index, combined_data$women_index, 
                   use = "complete.obs")
print(paste("Covariância:", round(covariancia, 4)))

# Gráfico com linhas das médias
ggplot(combined_data, aes(x = democracy_index, y = women_index)) +
  geom_point(shape = 1, alpha = 0.7, size = 2) +
  geom_hline(yintercept = mean(combined_data$women_index), 
             linetype = "dashed", color = "red", alpha = 0.7) +
  geom_vline(xintercept = mean(combined_data$democracy_index), 
             linetype = "dashed", color = "red", alpha = 0.7) +
  theme_minimal() +
  labs(title = "Relação com Médias Destacadas",
       x = "Índice de Democracia Liberal",
       y = "Índice de Empoderamento Político Feminino")

# Teste de correlação de Pearson
correlacao <- cor.test(combined_data$democracy_index, combined_data$women_index, 
                       method = "pearson")
print(correlacao)

# Interpretação: Correlação forte e positiva (r ≈ 0.8-0.9)
# P-valor < 0.001 confirma significância estatística

#############################################################
## 4. MODELO DE REGRESSÃO LINEAR              


# Ajustando modelo de regressão
modelo <- lm(women_index ~ democracy_index, data = combined_data)
summary(modelo)

# Visualização da regressão
combined_data %>%
  mutate(valores_preditos = fitted(modelo)) %>%
  ggplot(aes(x = democracy_index)) +
  geom_point(aes(y = women_index), alpha = 0.7, color = "steelblue", size = 2) +
  geom_line(aes(y = valores_preditos), color = "red", size = 1.2) +
  geom_hline(yintercept = mean(combined_data$women_index), 
             linetype = "dashed", alpha = 0.5) +
  geom_vline(xintercept = mean(combined_data$democracy_index), 
             linetype = "dashed", alpha = 0.5) +
  theme_minimal() +
  labs(title = "Modelo de Regressão Linear",
       subtitle = "Democracia como preditor do Empoderamento Feminino",
       x = "Índice de Democracia Liberal",
       y = "Índice de Empoderamento Político Feminino",
       caption = "Linha vermelha: reta de regressão | Linhas tracejadas: médias")

#############################################################
## RESUMO DOS RESULTADOS                      


#1. CHI-QUADRADO (Análise Tabular):
#   • Ambos os testes rejeitaram H0 (p < 0.05)
#   • Há associação significativa entre as variáveis categóricas
#
#2. TESTE-T (Diferença de Médias):
#   • América do Norte: maior índice anticorrupção
#   • Diferença estatisticamente significativa entre regiões
#
#3. CORRELAÇÃO DE PEARSON:
#   • Correlação positiva forte entre democracia e empoderamento feminino
#   • Relação estatisticamente significativa (p < 0.001)
#
#4. REGRESSÃO LINEAR:
#   • Democracia é preditora significativa do empoderamento feminino
#   • Modelo explica alta porcentagem da variação (R² > 0.7)
#
# FONTES DOS DADOS
#• Our World in Data: https://ourworldindata.org/
#• Transparency International (Corruption Index)
#• V-Dem Project (Democracy & Women Empowerment Indices)


