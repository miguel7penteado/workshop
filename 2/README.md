# Extraindo feições de Ortofotos - OpenIBGE

## INDICE

* 1. Introdução
* 2. O jeito antigo de se criar um mapa - camada vetorial + ortofoto
* 3. O jeito novo de se criar um mapa - camada vetorial + ortofoto + Inteligência Artificial
* 4. Algoritmos de Extração de borda
* 5. BIG DATA - Poder de processamento barato.
* 6. Núvem (Google Cloud, Microsoft Azure, Amazon EC2) - Seria este o meu CPD 
* 7. Juntando tudo.

### 1. Introdução
No mundo atual, onde a produção de informações geolocalizadas exige muito mais do que mapas impressos ou arquivos PDFs escalonizados, faz-se necessário o uso de metodologias eficientes de armazenamento e processamento de dados, uma vez que o volume de informação produzido é imenso e a atenção ( processamento "humano") é inversamente proporcional a este montante.
Para alcançar um objetivo qualquer, frente a tamanho volume de dados, é necessário suporte computacional.
O desafio deste trabalho é fazer o processo de extração de feições de uma Ortofoto de alta resolução, conseguido através de bibliotecas diversas (algumas com interface a códigos binários de origem alienígena a máquina virtual JAVA) ser processado em framework BIG DATA padrão de fato (os projetos da fundação apache integrados HADOOP + SPARK). 
Por ser um framework de processamento basicamente JAVA, portanto em essência, gerenciado por uma máquina virtual JAVA, a conversão de tipos de dados oriundos em outras linguagens ja é um desafio, embora, espera-se, seja teoricamente (teoricamente) transparente graças ao framework apache SPARK.

