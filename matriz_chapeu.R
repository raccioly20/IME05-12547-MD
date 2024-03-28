# Criado vetor com respostas
y = c(3.0, 3.9, 2.9, 2.7, 3.7, 2.4)

# Criando matriz de dados
X = matrix(
  data = c(
    rep(1, 6), 
    560, 780, 620, 600, 720, 380, 
    11, 10, 19, 7, 18, 13
  ),
  ncol = 3
)

# Estimando os coeficientes
b = solve(t(X) %*% X) %*% t(X) %*% y

# Obtendo y chapéu ou seja os valores ajustados
y_chapeu = X %*% b

# Vendo y_chapeu
y_chapeu


# Criando H (matriz chapeu)
H = X %*% solve(t(X) %*% X) %*% t(X)

# Vendo H
H

# Calculando os valores ajustados
H %*% y

# Calcula o traço da matriz H
sum(diag(H))


# Create 6x6 identity matrix
I = diag(6)

# Compute the vector of residuals
residuals = (I - H) %*% y

# View vector of residuals
residuals