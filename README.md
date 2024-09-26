# Testes de Performance - Carga e Stress

Este projeto utiliza o **JMeter** para executar testes de performance (carga e pico) automaticamente através de uma pipeline criada via **GitHub Actions**. O JMeter é executado através de **Docker**, garantindo um ambiente padronizado e replicável para os testes de **carga** e **pico** da aplicação.

## Índice

-   [Instruções de Execução](#instruções-de-execução)
-   [Acessando o Relatório de Execução](#acessando-o-relatório-de-execução)
-   [Detalhes sobre os Testes](#detalhes-sobre-os-testes)
-   [Conclusão da Execução dos Testes](#conclusão-da-execução-dos-testes)

---

## Instruções de Execução

Os testes de performance são executados automaticamente no GitHub Actions a cada novo **push** ou **pull request** na branch `main` mas você também pode executá-lo na aba **Actions**.

### Passos:

1. Vá até a aba **Actions** na parte superior do repositório.
2. Clique no workflow mais recente da execução.
3. No canto superior direito da página de detalhes do workflow, clique no botão **"Re-run all jobs"**.
4. Isso iniciará uma nova execução da pipeline, disparando os testes de performance com base no último commit.

---

## Acessando o Relatório de Execução

Após a execução dos testes no **GitHub Actions**, o relatório será disponibilizado como um artefato que pode ser baixado diretamente.

### Como acessar o relatório:

1. Vá até a aba **Actions** na parte superior do repositório.
2. Clique no workflow mais recente da execução.
3. Role até a seção de artefatos, onde você verá o link para o relatório com o nome **jmeter-report**.
4. Baixe o arquivo `.zip` e descompacte-o.
5. Abra o arquivo `index.html` localizado dentro da pasta descompactada no navegador para visualizar o relatório completo do teste de performance.

---

## Detalhes sobre os Testes

-   **Tipos de Testes**: Este repositório contém um script `performance-tests.jmx` que executa testes de **carga** e **pico**, verificando a capacidade de resposta da aplicação.

-   **Critério de Aceitação**: O script foi configurado para atingir **250 requisições por segundo** e visando que o tempo de resposta no **percentil 90** seja inferior a **2 segundos**.

-   **Teste de Carga**: Este teste tem como objetivo avaliar o comportamento da aplicação sob uma carga constante durante **5 minutos**. Ele simula um número elevado e contínuo de requisições para verificar como o sistema lida com uma carga sustentada. O teste visa atingir o critério de **250 requisições por segundo** ao longo de todo o período.

-   **Teste de Pico**: Após o teste de carga, o sistema é submetido a um teste de pico, que **estressa a aplicação por 1 minuto**. Este teste visa avaliar a capacidade da aplicação de lidar com um aumento repentino e elevado de requisições em um curto período de tempo. O objetivo é verificar a resiliência e a estabilidade do sistema sob alta pressão em um intervalo concentrado.

Ambos os testes são configurados para serem executados **em sequência**. Ou seja, o teste de carga é executado primeiro, e assim que ele termina, o teste de pico é iniciado. Isso garante que a aplicação seja avaliada de maneira isolada em cada cenário, permitindo uma análise clara do comportamento do sistema em cada tipo de teste.

-   **Configurações**:
    -   O arquivo `Dockerfile` é responsável por criar a imagem necessária para executar os testes de performance.
    -   O workflow do GitHub Actions está configurado para automatizar todo o processo de build, execução dos testes, e upload dos relatórios.

---

## Conclusão da Execução dos Testes

Após a execução dos testes de performance, foi observado que o sistema **não atendeu ao critério de aceitação** estabelecido. Os principais pontos que levaram a essa conclusão foram:

-   O tempo de resposta no **percentil 90** ultrapassou **2 segundos** na maioria das execuções, indicando que o sistema não foi capaz de processar as requisições dentro do tempo esperado sob a carga testada.
-   Em algumas execuções, foi possível observar o erro **429 - Too Many Requests**, o que sugere que o sistema, em determinados momentos, atingiu seus limites de taxa de requisição.

Esses resultados indicam que o sistema apresenta limitações ao lidar com o volume de requisições esperado, afetando o tempo de resposta e, ocasionalmente, gerando falhas por excesso de requisições. O aumento no tempo de resposta, junto aos erros 429, reforça que o servidor está enfrentando dificuldades para processar o número de requisições por segundo, especialmente em momentos de pico de carga.

Portanto, o teste foi considerado **não satisfatório**, e recomenda-se uma análise mais aprofundada para identificar gargalos e melhorar a capacidade de processamento e a resiliência do servidor frente a uma carga elevada.
